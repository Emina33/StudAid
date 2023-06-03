using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace StudAid.Services.Migrations
{
    public partial class dataSeed : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.InsertData(
           table: "Category",
           columns: new[] { "CategoryID", "CategoryName" },
           values: new object[,]
           {
                    {1,"Science"},
               {2,"Languages"}

           });
            migrationBuilder.InsertData(
             table: "Subject",
             columns: new[] { "SubjectID", "SubjectName", "CategoryID" },
             values: new object[,]
             {
                    {1,"Biology",1}

             });
            migrationBuilder.InsertData(
                 table: "Document",
                 columns: new[] { "DocumentID", "DocumentName", "SubjectID", "Author", "Description" },
                 values: new object[,]
                 {
                        {1,"Powerhouse of the cell",1,"John Doe","Mitochondria are organelles found in most eukaryotic cells that produce energy in the form of ATP through a process called cellular respiration. They have their own DNA and reproduce independently of the cell. Mitochondria play a crucial role in metabolism and are involved in a variety of cellular functions, including apoptosis, calcium signaling, and biosynthesis."}

                 });
            /*,*/
            migrationBuilder.InsertData(
            table: "Date",
            columns: new[] { "DateID", "Day", "Month", "Year" },
            values: new object[,]
            {
                    {1,10,6,2023}

            });
            migrationBuilder.InsertData(
             table: "Location",
             columns: new[] { "LocationID", "City", "Country" },
             values: new object[,]
             {
                    {1,"Živinice","Bosnia and Herzegovina"},
                 {2,"Mostar","Bosnia and Herzegovina"},
                 {3,"Visoko","Bosnia and Herzegovina"},
                 {4,"Sarajevo","Bosnia and Herzegovina"},
                 {5,"Zenica","Bosnia and Herzegovina"},
                 {6,"Travnik","Bosnia and Herzegovina"},
                 {7,"Tuzla","Bosnia and Herzegovina"},
             });
            migrationBuilder.InsertData(
              table: "AppUser",
              columns: new[] { "UserID", "FirstName", "LastName", "Username", "Password", "PasswordSalt", "LocationID", "Role", "Description" },
              values: new object[,]
              {
                    {1,"Admin", "Admin", "admin", "oN7EnB9RJfFoHXP5MvO5KaMS4Gc=","AAAAAAAAAAAAAAAAAAAAAA==", 1, "admin","Admin profile"},
                    {2,"John", "Doe", "johndoe", "oN7EnB9RJfFoHXP5MvO5KaMS4Gc=","AAAAAAAAAAAAAAAAAAAAAA==", 1,"basic user","As a biology teacher, I aim to inspire curiosity and critical thinking in my students. Through hands-on activities, inquiry-based investigations, and technology, I facilitate learning of biological concepts and processes. I prioritize the development of important skills, challenge students to think critically, and foster a safe and inclusive learning environment."},
              });

            migrationBuilder.InsertData(
               table: "Advert",
               columns: new[] { "AdvertID", "AdvertName", "AvailableTime", "Price", "Tutor", "SubjectID", "Date", "StateMachine" },
               values: new object[,]
               {
                    {1,"Anatomy class", "10:00, 11:00, 12:00", 10,2,1,1,"initial" },
                    {2,"Bone structure", "13:00, 14:00, 15:00", 10,2,1,1,"initial" },
               });

            /*, */




        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DeleteData(
                table: "Advert",
                keyColumn: "AdvertID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Advert",
                keyColumn: "AdvertID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "AppUser",
                keyColumn: "AppUserID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "AppUser",
                keyColumn: "AppUserID",
                keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Category",
                keyColumn: "CategoryID",
                keyValue: 1);
            migrationBuilder.DeleteData(
               table: "Category",
               keyColumn: "CategoryID",
               keyValue: 2);

            migrationBuilder.DeleteData(
                table: "Date",
                keyColumn: "DateID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Document",
                keyColumn: "DocumentID",
                keyValue: 1);

            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 1);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 2);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 3);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 4);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 5);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 6);
            migrationBuilder.DeleteData(
                table: "Location",
                keyColumn: "LocationID",
                keyValue: 7);

            migrationBuilder.DeleteData(
                table: "Subject",
                keyColumn: "SubjectID",
                keyValue: 1);


        }
    }
}