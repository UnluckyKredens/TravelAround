using System;
using Microsoft.EntityFrameworkCore;
using TravelAroundAPI.Entities;

namespace TravelAroundAPI.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<TravelModel> Travels { get; set; }
        public DbSet<Atraction> Atractions { get; set; }
        public DbSet<FavouriteTravel> FavouriteTravels { get; set; }
        public DbSet<TravelAtraction> TravelAtractions { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<User>()
                .HasMany(e => e.MadeTravels)
                .WithOne()
                .HasForeignKey(t => t.madeByUserId);

            modelBuilder.Entity<FavouriteTravel>()
                .HasKey(ft => new { ft.UserId, ft.TravelId });

            modelBuilder.Entity<FavouriteTravel>()
                .HasOne(ft => ft.User)
                .WithMany(u => u.FavouriteTravels)
                .HasForeignKey(ft => ft.UserId);

            modelBuilder.Entity<FavouriteTravel>()
                .HasOne(ft => ft.Travel)
                .WithMany(t => t.FavouritedByUsers)
                .HasForeignKey(ft => ft.TravelId);

            modelBuilder.Entity<TravelAtraction>()
                .HasKey(ta => new { ta.TravelId, ta.AtractionId });

            modelBuilder.Entity<TravelAtraction>()
                .HasOne(ta => ta.Travel)
                .WithMany(t => t.TravelAtractions)
                .HasForeignKey(ta => ta.TravelId);

            modelBuilder.Entity<TravelAtraction>()
                .HasOne(ta => ta.Atraction)
                .WithMany(a => a.TravelAtractions)
                .HasForeignKey(ta => ta.AtractionId);
        }
    }
}

