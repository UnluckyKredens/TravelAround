using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using TravelAroundAPI.Data;
using TravelAroundAPI.DTOs;
using TravelAroundAPI.DTOs.ReturnDTOs;
using TravelAroundAPI.Entities;

[Route("api/[controller]")]
[ApiController]
public class FavouriteTravelController : ControllerBase
{
    private readonly DataContext _context;

    public FavouriteTravelController(DataContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> AddFavourite(FavouriteTravelDTO favourite)
    {
        var model = new FavouriteTravel
        {
            UserId = favourite.UserId,
            TravelId = favourite.TravelId
        };

        _context.FavouriteTravels.Add(model);

        var travel = await _context.Travels.FindAsync(favourite.TravelId);
        if (travel != null)
        {
            travel.Likes += 1;
        }

        await _context.SaveChangesAsync();
        return Ok();
    }
}
