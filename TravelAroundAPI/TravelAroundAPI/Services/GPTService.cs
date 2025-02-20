using System;

    using System.Net.Http;
    using System.Text;
    using System.Text.Json;
    using System.Threading.Tasks;
    using Microsoft.Extensions.Configuration;
    using TravelAroundAPI.DTOs;
    using TravelAroundAPI.DTOs.GPT;

namespace TravelAroundAPI.Services
{
    public class GPTService
    {
        readonly HttpClient? _httpClient;
        readonly string? _apiKey;

        public async Task<string> GenerateText(string prompt)
        {
            var requestBody = new
            {
                model = "gpt-4",
                messages = new[]
                {
            new { role = "system", content = "Jesteś asystentem podróży i zwracasz odpowiedzi w formacie JSON." },
            new { role = "user", content = $"{prompt}. Odpowiedz w formacie JSON na podstawie modelu , bez dodatkowego tekstu." }
        },
                max_tokens = 500
            };

            var requestContent = new StringContent(JsonSerializer.Serialize(requestBody), Encoding.UTF8, "application/json");
            _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {_apiKey}");

            var response = await _httpClient.PostAsync("https://api.openai.com/v1/chat/completions", requestContent);
            var responseString = await response.Content.ReadAsStringAsync();

            return responseString; // Zwracamy cały JSON
        }
    }
}
