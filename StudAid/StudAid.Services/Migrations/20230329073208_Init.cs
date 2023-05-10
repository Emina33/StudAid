using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudAid.Services.Migrations
{
    public partial class Init : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Category",
                columns: table => new
                {
                    CategoryID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    CategoryName = table.Column<string>(type: "varchar(70)", unicode: false, maxLength: 70, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Category", x => x.CategoryID);
                });

            migrationBuilder.CreateTable(
                name: "Date",
                columns: table => new
                {
                    DateID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Day = table.Column<int>(type: "int", nullable: true),
                    Month = table.Column<int>(type: "int", nullable: true),
                    Year = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Date", x => x.DateID);
                });

            migrationBuilder.CreateTable(
                name: "Location",
                columns: table => new
                {
                    LocationID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    City = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    Country = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Location", x => x.LocationID);
                });

            migrationBuilder.CreateTable(
                name: "Subject",
                columns: table => new
                {
                    SubjectID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    SubjectName = table.Column<string>(type: "varchar(70)", unicode: false, maxLength: 70, nullable: true),
                    CategoryID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Subject", x => x.SubjectID);
                    table.ForeignKey(
                        name: "FK__Subject__Categor__267ABA7A",
                        column: x => x.CategoryID,
                        principalTable: "Category",
                        principalColumn: "CategoryID");
                });

            migrationBuilder.CreateTable(
                name: "AppUser",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    FirstName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    LastName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    Username = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    Password = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    PasswordSalt = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    LocationID = table.Column<int>(type: "int", nullable: true),
                    Role = table.Column<string>(type: "nvarchar(max)", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__AppUser__1788CCACAAA5764A", x => x.UserID);
                    table.ForeignKey(
                        name: "FK__AppUser__Locatio__300424B4",
                        column: x => x.LocationID,
                        principalTable: "Location",
                        principalColumn: "LocationID");
                });

            migrationBuilder.CreateTable(
                name: "Document",
                columns: table => new
                {
                    DocumentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    DocumentName = table.Column<string>(type: "varchar(70)", unicode: false, maxLength: 70, nullable: true),
                    SubjectID = table.Column<int>(type: "int", nullable: true),
                    Author = table.Column<string>(type: "varchar(80)", unicode: false, maxLength: 80, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Document", x => x.DocumentID);
                    table.ForeignKey(
                        name: "FK__Document__Subjec__2B3F6F97",
                        column: x => x.SubjectID,
                        principalTable: "Subject",
                        principalColumn: "SubjectID");
                });

            migrationBuilder.CreateTable(
                name: "Advert",
                columns: table => new
                {
                    AdvertID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AdvertName = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    AvailableTime = table.Column<string>(type: "varchar(100)", unicode: false, maxLength: 100, nullable: true),
                    Price = table.Column<double>(type: "float", nullable: true),
                    Tutor = table.Column<int>(type: "int", nullable: true),
                    SubjectID = table.Column<int>(type: "int", nullable: true),
                    Date = table.Column<int>(type: "int", nullable: true),
                    StateMachine = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Advert", x => x.AdvertID);
                    table.ForeignKey(
                        name: "FK__Advert__Date__33D4B598",
                        column: x => x.Date,
                        principalTable: "Date",
                        principalColumn: "DateID");
                    table.ForeignKey(
                        name: "FK__Advert__SubjectI__34C8D9D1",
                        column: x => x.SubjectID,
                        principalTable: "Subject",
                        principalColumn: "SubjectID");
                    table.ForeignKey(
                        name: "FK__Advert__Tutor__35BCFE0A",
                        column: x => x.Tutor,
                        principalTable: "AppUser",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "Message",
                columns: table => new
                {
                    MessageID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Content = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true),
                    Sender = table.Column<int>(type: "int", nullable: true),
                    Receiver = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Message", x => x.MessageID);
                    table.ForeignKey(
                        name: "FK__Message__Receive__38996AB5",
                        column: x => x.Receiver,
                        principalTable: "AppUser",
                        principalColumn: "UserID");
                    table.ForeignKey(
                        name: "FK__Message__Sender__398D8EEE",
                        column: x => x.Sender,
                        principalTable: "AppUser",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "Review",
                columns: table => new
                {
                    ReviewID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReviewText = table.Column<string>(type: "varchar(200)", unicode: false, maxLength: 200, nullable: true),
                    ReviewStars = table.Column<int>(type: "int", nullable: true),
                    Reviewer = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Review", x => x.ReviewID);
                    table.ForeignKey(
                        name: "FK__Review__Reviewer__4AB81AF0",
                        column: x => x.Reviewer,
                        principalTable: "AppUser",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "Reservation",
                columns: table => new
                {
                    ReservationID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AdvertID = table.Column<int>(type: "int", nullable: true),
                    UserID = table.Column<int>(type: "int", nullable: true),
                    SelectedTime = table.Column<string>(type: "varchar(20)", unicode: false, maxLength: 20, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Reservation", x => x.ReservationID);
                    table.ForeignKey(
                        name: "FK__Reservati__Adver__3F466844",
                        column: x => x.AdvertID,
                        principalTable: "Advert",
                        principalColumn: "AdvertID");
                    table.ForeignKey(
                        name: "FK__Reservati__UserI__403A8C7D",
                        column: x => x.UserID,
                        principalTable: "AppUser",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "Payment",
                columns: table => new
                {
                    PaymentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReservationID = table.Column<int>(type: "int", nullable: true),
                    CardNumber = table.Column<string>(type: "varchar(16)", unicode: false, maxLength: 16, nullable: true),
                    ExpiryDate = table.Column<string>(type: "varchar(5)", unicode: false, maxLength: 5, nullable: true),
                    CVV = table.Column<string>(type: "varchar(3)", unicode: false, maxLength: 3, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Payment", x => x.PaymentID);
                    table.ForeignKey(
                        name: "FK__Payment__Reserva__44FF419A",
                        column: x => x.ReservationID,
                        principalTable: "Reservation",
                        principalColumn: "ReservationID");
                });

            migrationBuilder.CreateTable(
                name: "Report",
                columns: table => new
                {
                    ReportID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    ReservationID = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Report", x => x.ReportID);
                    table.ForeignKey(
                        name: "FK__Report__Reservat__47DBAE45",
                        column: x => x.ReservationID,
                        principalTable: "Reservation",
                        principalColumn: "ReservationID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_Advert_Date",
                table: "Advert",
                column: "Date");

            migrationBuilder.CreateIndex(
                name: "IX_Advert_SubjectID",
                table: "Advert",
                column: "SubjectID");

            migrationBuilder.CreateIndex(
                name: "IX_Advert_Tutor",
                table: "Advert",
                column: "Tutor");

            migrationBuilder.CreateIndex(
                name: "IX_AppUser_LocationID",
                table: "AppUser",
                column: "LocationID");

            migrationBuilder.CreateIndex(
                name: "IX_Document_SubjectID",
                table: "Document",
                column: "SubjectID");

            migrationBuilder.CreateIndex(
                name: "IX_Message_Receiver",
                table: "Message",
                column: "Receiver");

            migrationBuilder.CreateIndex(
                name: "IX_Message_Sender",
                table: "Message",
                column: "Sender");

            migrationBuilder.CreateIndex(
                name: "IX_Payment_ReservationID",
                table: "Payment",
                column: "ReservationID");

            migrationBuilder.CreateIndex(
                name: "IX_Report_ReservationID",
                table: "Report",
                column: "ReservationID");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_AdvertID",
                table: "Reservation",
                column: "AdvertID");

            migrationBuilder.CreateIndex(
                name: "IX_Reservation_UserID",
                table: "Reservation",
                column: "UserID");

            migrationBuilder.CreateIndex(
                name: "IX_Review_Reviewer",
                table: "Review",
                column: "Reviewer");

            migrationBuilder.CreateIndex(
                name: "IX_Subject_CategoryID",
                table: "Subject",
                column: "CategoryID");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Document");

            migrationBuilder.DropTable(
                name: "Message");

            migrationBuilder.DropTable(
                name: "Payment");

            migrationBuilder.DropTable(
                name: "Report");

            migrationBuilder.DropTable(
                name: "Review");

            migrationBuilder.DropTable(
                name: "Reservation");

            migrationBuilder.DropTable(
                name: "Advert");

            migrationBuilder.DropTable(
                name: "Date");

            migrationBuilder.DropTable(
                name: "Subject");

            migrationBuilder.DropTable(
                name: "AppUser");

            migrationBuilder.DropTable(
                name: "Category");

            migrationBuilder.DropTable(
                name: "Location");
        }
    }
}
