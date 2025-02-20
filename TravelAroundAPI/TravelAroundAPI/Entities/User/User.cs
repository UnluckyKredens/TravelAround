using System;
namespace TravelAroundAPI.Entities
{
	public class User
	{
        public int Id { get; set; }
        public string Username { get; set; }
        public string Login { get; set; }
        public string PasswordHash { get; set; }
        public string PasswordSalt { get; set; }
        public string Email { get; set; }
        public string Address { get; set; }

        public ICollection<TravelModel> MadeTravels { get; } = new List<TravelModel>();
        public ICollection<FavouriteTravel> FavouriteTravels { get; set; }
    }
}

