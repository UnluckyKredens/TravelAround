using System;
namespace TravelAroundAPI.Entities
{
	public class TravelAtraction
	{
        public int TravelId { get; set; }
        public TravelModel Travel { get; set; }

        public int AtractionId { get; set; }
        public Atraction Atraction { get; set; }
    }
}

