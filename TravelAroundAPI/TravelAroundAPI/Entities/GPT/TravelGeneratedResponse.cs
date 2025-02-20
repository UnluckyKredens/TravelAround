using System;
namespace TravelAroundAPI.DTOs.GPT
{
    public class TravelGeneratedResponse
    {
        public string Description { get; set; }
        public List<AtractionDTO> Atractions { get; set; }
    }

}

