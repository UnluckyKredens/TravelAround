using System;
namespace TravelAroundAPI.DTOs.GPT
{
	public class GenerateTravelDTO
	{
		public int userId { get; set; }
        public float Price { get; set; }
        public string Destination { get; set; }
        public string From { get; set; }
        public int Members { get; set; }
        public int Days { get; set; }
    }
}

