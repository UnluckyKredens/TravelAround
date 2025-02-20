using System;
namespace TravelAroundAPI.Entities.Travel
{
    public class TravelWithAtractions
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string From { get; set; }
        public string Destination { get; set; }
        public int Members { get; set; }
        public decimal Price { get; set; }
        public string Description { get; set; }
        public List<Atraction> Atractions { get; set; }
    }

}

