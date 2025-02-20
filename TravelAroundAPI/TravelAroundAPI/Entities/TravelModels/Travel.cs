using System;
namespace TravelAroundAPI.Entities
{
	public class TravelModel
	{
        public int Id { get; set; }
        public string ImageUrl { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string Destination { get; set; }
        public string From { get; set; }
        public double Members { get; set; }
        public string Description { get; set; }

        public int Likes { get; set; } = 0;

        public int? madeByUserId { get; set; }

        public ICollection<FavouriteTravel> FavouritedByUsers { get; set; }
        public ICollection<TravelAtraction> TravelAtractions { get; set; }
    }
}

