using System;
namespace TravelAroundAPI.DTOs.GPT
{
    public class TravelGenerationRequest
    {
        public string? From { get; set; }
        public string? Destination { get; set; }
        public int? Members { get; set; }
        public decimal? Price { get; set; }
    }

}

