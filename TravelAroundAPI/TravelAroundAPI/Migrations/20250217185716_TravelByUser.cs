using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace TravelAroundAPI.Migrations
{
    public partial class TravelByUser : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MadeTravels");

            migrationBuilder.AddColumn<int>(
                name: "madeByUserId",
                table: "Travels",
                type: "int",
                nullable: false,
                defaultValue: 0);

            migrationBuilder.CreateIndex(
                name: "IX_Travels_madeByUserId",
                table: "Travels",
                column: "madeByUserId");

            migrationBuilder.AddForeignKey(
                name: "FK_Travels_Users_madeByUserId",
                table: "Travels",
                column: "madeByUserId",
                principalTable: "Users",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Travels_Users_madeByUserId",
                table: "Travels");

            migrationBuilder.DropIndex(
                name: "IX_Travels_madeByUserId",
                table: "Travels");

            migrationBuilder.DropColumn(
                name: "madeByUserId",
                table: "Travels");

            migrationBuilder.CreateTable(
                name: "MadeTravels",
                columns: table => new
                {
                    UserId = table.Column<int>(type: "int", nullable: false),
                    TravelId = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MadeTravels", x => new { x.UserId, x.TravelId });
                    table.ForeignKey(
                        name: "FK_MadeTravels_Travels_TravelId",
                        column: x => x.TravelId,
                        principalTable: "Travels",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                    table.ForeignKey(
                        name: "FK_MadeTravels_Users_UserId",
                        column: x => x.UserId,
                        principalTable: "Users",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Cascade);
                })
                .Annotation("MySql:CharSet", "utf8mb4");

            migrationBuilder.CreateIndex(
                name: "IX_MadeTravels_TravelId",
                table: "MadeTravels",
                column: "TravelId");
        }
    }
}
