using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using TravelAroundAPI.Data;
using TravelAroundAPI.DTOs;
using TravelAroundAPI.Entities;

[Route("api/[controller]")]
[ApiController]
public class AtractionController : ControllerBase
{
    private readonly DataContext _context;

    public AtractionController(DataContext context)
    {
        _context = context;
    }

    // Dodanie atrakcji
    [HttpPost]
    public async Task<IActionResult> AddAtraction(AtractionDTO atraction)
    {
        var model = new Atraction
        {
            Name = atraction.Name,
            Price = atraction.Price,
            Destination = atraction.Destination,
            Description = atraction.Description,
            ImageUrl = atraction.ImageUrl
        };
        _context.Atractions.Add(model);
        await _context.SaveChangesAsync();
        return Ok();
    }

    // Pobranie wszystkich atrakcji
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Atraction>>> GetAtractions()
    {
        return await _context.Atractions.ToListAsync();
    }

    [HttpPost("toTravel")]
    public async Task<IActionResult> AtractionToTravel(AtractionTravelDTO atraction)
    {
        var model = new TravelAtraction
        {
            TravelId = atraction.TravelId,
            AtractionId = atraction.AtractionId
        };

        await _context.TravelAtractions.AddAsync(model);
        await _context.SaveChangesAsync();

        return Ok("Atraction added succesfuly");
    }
}
