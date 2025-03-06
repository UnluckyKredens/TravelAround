using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TravelAroundAPI.Migrations
{
    public partial class DaysToDB : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Days",
                table: "Travels",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Days",
                table: "Travels");
        }
    }
}
