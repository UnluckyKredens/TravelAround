
using System;
namespace TravelAroundAPI.DTOs
{
	public class AddTravelDTO
	{
        public int userId { get; set; }
        public string ImageUrl { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string Destination { get; set; }
        public string From { get; set; }
        public double Members { get; set; }
        public int Days { get; set; }
        public string Description { get; set; }
    }
}

