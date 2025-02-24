using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Text.Json;
using System.Threading.Tasks;
using TravelAroundAPI.Data;
using TravelAroundAPI.DTOs;
using TravelAroundAPI.DTOs.GPT;
using TravelAroundAPI.DTOs.ReturnDTOs;
using TravelAroundAPI.Entities;
using TravelAroundAPI.Entities.Travel;
using TravelAroundAPI.Services;

[Route("api/[controller]")]
[ApiController]
public class TravelController : ControllerBase
{
    private readonly DataContext _context;
    //private readonly GPTService _gptService;

    public TravelController(DataContext context) //GPTService gpTService
    {
        _context = context;
        //_gptService = gpTService;
    }

    [HttpPost("Add")]
    public async Task<IActionResult> AddTravel(AddTravelDTO travel)
    {
        var model = new TravelModel
        {
            Name = travel.Name,
            ImageUrl = travel.ImageUrl,
            Price = travel.Price,
            Destination = travel.Destination,
            From = travel.From,
            Members = travel.Members,
            Description = travel.Description,
            Days = travel.Days,
            madeByUserId = travel.userId
        };

        _context.Travels.Add(model);
        await _context.SaveChangesAsync();
        return Ok();
    }

    

    [HttpGet]
    public async Task<IActionResult> GetAllTravels()
    {
        var travels = await _context.Travels
            .Include(t => t.TravelAtractions)
            .ThenInclude(ta => ta.Atraction)
            .ToListAsync();

        var travelDtos = travels.Select(t => new TravelWithAtractionsDTO
        {
            TravelId = t.Id,
            ImageUrl = t.ImageUrl,
            Name = t.Name,
            Price = t.Price,
            Destination = t.Destination,
            From = t.From,
            Members = t.Members,
            Description = t.Description,
            Days = t.Days,
            Likes = t.Likes,
            Atractions = t.TravelAtractions
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
        }).ToList();

        return Ok(travelDtos);
    }

    [HttpGet("destination")]
    public async Task<ActionResult<IEnumerable<TravelWithAtractionsDTO>>> GetTravelsByDestination(string destination)
    {
        if (string.IsNullOrEmpty(destination))
            return BadRequest("Destination parameter is required.");

        var travels = await _context.Travels
            .Where(t => t.Destination.Contains(destination))
            .Include(t => t.TravelAtractions)
            .ThenInclude(ta => ta.Atraction)
            .ToListAsync();

        if (!travels.Any()) return NotFound("No travels found for the given destination.");

        var travelDtos = travels.Select(t => new TravelWithAtractionsDTO
        {
            TravelId = t.Id,
            ImageUrl = t.ImageUrl,
            Name = t.Name,
            Price = t.Price,
            Destination = t.Destination,
            From = t.From,
            Members = t.Members,
            Description = t.Description,
            Likes = t.Likes,
            Days = t.Days,
            Atractions = t.TravelAtractions
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
        }).ToList();

        return Ok(travelDtos);
    }



    [HttpGet("{id}")]
    public async Task<ActionResult<TravelAtraction>> GetTravelById(int id)
    {
        var travel = await _context.Travels
         .Include(t => t.TravelAtractions)
         .ThenInclude(ta => ta.Atraction) // Pobieramy atrakcje
         .FirstOrDefaultAsync(t => t.Id == id);

        if (travel == null) return NotFound("Travel not found.");

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

    [HttpGet("top")]
    public async Task<ActionResult<IEnumerable<TravelWithAtractionsDTO>>> GetTopTravels()
    {
        var travels = await _context.Travels
            .OrderByDescending(t => t.Likes)
            .Take(5)
            .Include(t => t.TravelAtractions)
            .ThenInclude(ta => ta.Atraction)
            .ToListAsync();

        var travelDtos = travels.Select(t => new TravelWithAtractionsDTO
        {
            TravelId = t.Id,
            ImageUrl = t.ImageUrl,
            Name = t.Name,
            Price = t.Price,
            Destination = t.Destination,
            From = t.From,
            Members = t.Members,
            Description = t.Description,
            Days = t.Days,
            Likes = t.Likes,
            Atractions = t.TravelAtractions
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
        }).ToList();

        return Ok(travelDtos);
    } 

    [HttpGet("user/{userId}")]
    public async Task<ActionResult<IEnumerable<TravelModel>>> GetMyTravels(int userId)
    {
        var travels = await _context.Travels
            .Where(u => u.madeByUserId == userId)
            .Include(a => a.TravelAtractions)
            .Select(f => new TravelWithAtractionsDTO
            {
                TravelId = f.Id,
                ImageUrl = f.ImageUrl,
                Price = f.Price,
                From = f.From,
                Members = f.Members,
                Name = f.Name,
                Destination = f.Destination,
                Description = f.Description,
                Days = t.Days,
                Atractions = f.TravelAtractions
                    .Select(ta => new AtractionDTO
                    {
                        Id = ta.Atraction.Id,
                        Name = ta.Atraction.Name,
                        Description = ta.Atraction.Description,
                        Price = ta.Atraction.Price,
                        Destination = ta.Atraction.Destination,

                    }).ToList()
            })
            .ToListAsync();

        return Ok(travels);
    }
}