﻿using System;
namespace TravelAroundAPI.DTOs
{
	public class AtractionDTO
	{
        public int Id { get; set; }
        public string Name { get; set; }
        public double Price { get; set; }
        public string Destination { get; set; }
        public string Description { get; set; }
        public string ImageUrl { get; set; }
    }
}

