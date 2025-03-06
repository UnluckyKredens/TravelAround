using System;
using System.Net.Http;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;
using TravelAroundAPI.Data;
using TravelAroundAPI.DTOs;
using TravelAroundAPI.DTOs.GPT;
using TravelAroundAPI.DTOs.ReturnDTOs;
using TravelAroundAPI.Entities;

namespace TravelAroundAPI.Controllers.GPT
{
    [Route("api/[controller]")]
    [ApiController]
    public class GPTController : Controller
    {
        private readonly DataContext _context;
        private readonly IConfiguration _configuration;
        private readonly HttpClient _httpClient;

        public GPTController(DataContext context, IConfiguration configuration, HttpClient httpClient)
        {
            _context = context;
            _configuration = configuration;
            _httpClient = httpClient;
        }

        [HttpPost("GenerateTravel")]
        public async Task<ActionResult> GenerateTravel(GenerateTravelDTO request)
        {
            if (request == null || string.IsNullOrWhiteSpace(request.Destination) || string.IsNullOrWhiteSpace(request.From))
            {
                return BadRequest("Niepoprawne dane wejściowe. Sprawdź parametry.");
            }

            var prompt = $@"
                Jesteś ekspertem ds. podróży. Stwórz szczegółowy plan wycieczki do {request.Destination} z {request.From} dla {request.Members} osób, na {request.Days} dni z budżetem {request.Price}. 
                Zwróć odpowiedź w poprawnym formacie JSON:
                {{
                    ""madeByUserId"": {request.userId},
                    ""imageUrl"": ""Podaj URL realistycznego zdjęcia pasującego do miejsca {request.Destination}"",
                    ""name"": ""Wymyśl kreatywną nazwę wycieczki do {request.Destination}"",
                    ""price"": {request.Price},
                    ""destination"": ""{request.Destination}"",
                    ""from"": ""{request.From}"",
                    ""members"": {request.Members},
                    ""days"": {request.Days},
                    ""description"": ""Stwórz kompletny plan podróży, podzielony na dni. Używaj \\n do oddzielania akapitów."",
                    ""likes"": 0
                }}";

            var apiKey = _configuration["OpenAI:ApiKey"];
            if (string.IsNullOrEmpty(apiKey))
            {
                return StatusCode(500, "Brak klucza API OpenAI. Sprawdź konfigurację.");
            }

            var openAiRequest = new
            {
                model = "gpt-4-turbo",
                messages = new[]
                {
                    new { role = "system", content = "Pomagasz zaplanować podróż. Odpowiedź musi być w formacie JSON." },
                    new { role = "user", content = prompt }
                },
                max_tokens = 4000
            };

            var content = new StringContent(JsonSerializer.Serialize(openAiRequest), Encoding.UTF8, "application/json");
            _httpClient.DefaultRequestHeaders.Clear();
            _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {apiKey}");

            var response = await _httpClient.PostAsync("https://api.openai.com/v1/chat/completions", content);
            if (!response.IsSuccessStatusCode)
            {
                return StatusCode((int)response.StatusCode, $"Błąd komunikacji z OpenAI: {await response.Content.ReadAsStringAsync()}");
            }

            var responseString = await response.Content.ReadAsStringAsync();
            using var jsonDoc = JsonDocument.Parse(responseString);
            var contentJson = jsonDoc.RootElement
                .GetProperty("choices")[0]
                .GetProperty("message")
                .GetProperty("content")
                .GetString();

            if (string.IsNullOrEmpty(contentJson))
            {
                return StatusCode(500, "OpenAI zwrócił pustą odpowiedź.");
            }

            try
            {
                var options = new JsonSerializerOptions { PropertyNameCaseInsensitive = true };
                var travel = JsonSerializer.Deserialize<TravelModel>(contentJson, options);

                if (travel == null)
                {
                    return StatusCode(500, "Błąd podczas parsowania odpowiedzi OpenAI.");
                }

                travel.ImageUrl ??= "https://via.placeholder.com/150";
                    travel.TravelAtractions = new List<TravelAtraction>();
                travel.FavouritedByUsers = new List<FavouriteTravel>();

                _context.Travels.Add(travel);
                await _context.SaveChangesAsync();

                var travelDto = new TravelWithAtractionsDTO
                {
                    TravelId = travel.Id,
                    ImageUrl = travel.ImageUrl,
                    Name = travel.Name,
                    Price = travel.Price,
                    Destination = travel.Destination,
                    From = travel.From,
                    Members = travel.Members,
                    Description = travel.Description,
                    Likes = travel.Likes,
                    Days = travel.Days,
                    Atractions = travel.TravelAtractions
                    .Select(ta => new AtractionDTO
                    {
                        Id = ta.Atraction.Id,
                        Name = ta.Atraction.Name,
                        Price = ta.Atraction.Price,
                        Destination = ta.Atraction.Destination,
                        Description = ta.Atraction.Description,
                        ImageUrl = ta.Atraction.ImageUrl
                    })
                    .ToList()
                            };

                return Ok(travelDto);
            }
            catch (JsonException ex)
            {
                return StatusCode(500, $"Błąd parsowania JSON: {ex.Message}");
            }
        }
    }
}
