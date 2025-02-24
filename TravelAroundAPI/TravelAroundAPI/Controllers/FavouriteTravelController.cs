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

    [HttpDelete("delete")]
    public async Task<IActionResult> DeleteFavourite(FavouriteTravelDTO fav)
    {
        var model = new FavouriteTravel
        {
            UserId = fav.UserId,
            TravelId = fav.TravelId
        };

        var travel = await _context.Travels.FindAsync(fav.TravelId);
        if (travel != null)
        {
            travel.Likes -= 1;
        }

         _context.FavouriteTravels.Remove(model);
        await _context.SaveChangesAsync();

        return Ok();

       
    }

    [HttpGet("userFavourites/{userId}")]
    public async Task<ActionResult<List<TravelModel>>> getUserFavourites(int userId)
    {
        var travel = await _context.FavouriteTravels
            .Where(f => f.UserId == userId)
            .Select(f => new TravelWithAtractionsDTO
            {
                TravelId = f.Travel.Id,
                ImageUrl = f.Travel.ImageUrl,
                Price = f.Travel.Price,
                From = f.Travel.From,
                Members = f.Travel.Members,
                Name = f.Travel.Name,
                Destination = f.Travel.Destination,
                Description = f.Travel.Description,
                Days = t.Days,
                Atractions = f.Travel.TravelAtractions
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



        return Ok(travel);
    }
}
