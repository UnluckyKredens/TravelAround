using System;
using TravelAroundAPI.Entities;

namespace TravelAroundAPI.DTOs.ReturnDTOs
{
	public class TravelWithAtractionsDTO
	{
        public int TravelId { get; set; }
        public string ImageUrl { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string Destination { get; set; }
        public string From { get; set; }
        public double Members { get; set; }
        public string Description { get; set; }
        public int Likes { get; set; }


        public ICollection<AtractionDTO> Atractions { get; set; }
    }
}

