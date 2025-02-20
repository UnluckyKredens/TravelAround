using System;
namespace TravelAroundAPI.Entities
{
	public class FavouriteTravel
	{
        public int UserId { get; set; }
        public User User { get; set; }

        public int TravelId { get; set; }
        public TravelModel Travel { get; set; }
    }
}

