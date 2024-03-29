﻿// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Metadata;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using StudAid.Services;

#nullable disable

namespace StudAid.Services.Migrations
{
    [DbContext(typeof(stud_aid2Context))]
    partial class stud_aid2ContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("ProductVersion", "6.0.10")
                .HasAnnotation("Relational:MaxIdentifierLength", 128);

            SqlServerModelBuilderExtensions.UseIdentityColumns(modelBuilder, 1L, 1);

            modelBuilder.Entity("StudAid.Services.Advert", b =>
                {
                    b.Property<int>("AdvertId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("AdvertID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("AdvertId"), 1L, 1);

                    b.Property<string>("AdvertName")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("AvailableTime")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<int?>("Date")
                        .HasColumnType("int");

                    b.Property<double?>("Price")
                        .HasColumnType("float");

                    b.Property<string>("StateMachine")
                        .HasMaxLength(50)
                        .HasColumnType("nvarchar(50)");

                    b.Property<int?>("SubjectId")
                        .HasColumnType("int")
                        .HasColumnName("SubjectID");

                    b.Property<int?>("Tutor")
                        .HasColumnType("int");

                    b.HasKey("AdvertId");

                    b.HasIndex("Date");

                    b.HasIndex("SubjectId");

                    b.HasIndex("Tutor");

                    b.ToTable("Advert", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.AppUser", b =>
                {
                    b.Property<int>("UserId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("UserID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("UserId"), 1L, 1);

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("FirstName")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("LastName")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<int?>("LocationId")
                        .HasColumnType("int")
                        .HasColumnName("LocationID");

                    b.Property<string>("Password")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("PasswordSalt")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("ProfilePicture")
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("Role")
                        .HasColumnType("nvarchar(max)");

                    b.Property<string>("Username")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.HasKey("UserId")
                        .HasName("PK__AppUser__1788CCACAAA5764A");

                    b.HasIndex("LocationId");

                    b.ToTable("AppUser", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Category", b =>
                {
                    b.Property<int>("CategoryId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("CategoryID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("CategoryId"), 1L, 1);

                    b.Property<string>("CategoryName")
                        .HasMaxLength(70)
                        .IsUnicode(false)
                        .HasColumnType("varchar(70)");

                    b.HasKey("CategoryId");

                    b.ToTable("Category", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Date", b =>
                {
                    b.Property<int>("DateId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("DateID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DateId"), 1L, 1);

                    b.Property<int?>("Day")
                        .HasColumnType("int");

                    b.Property<int?>("Month")
                        .HasColumnType("int");

                    b.Property<int?>("Year")
                        .HasColumnType("int");

                    b.HasKey("DateId");

                    b.ToTable("Date", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Document", b =>
                {
                    b.Property<int>("DocumentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("DocumentID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("DocumentId"), 1L, 1);

                    b.Property<string>("Author")
                        .HasMaxLength(80)
                        .IsUnicode(false)
                        .HasColumnType("varchar(80)");

                    b.Property<string>("Description")
                        .HasColumnType("nvarchar(max)");

                    b.Property<byte[]>("DocumentFile")
                        .HasColumnType("varbinary(max)");

                    b.Property<string>("DocumentName")
                        .HasMaxLength(70)
                        .IsUnicode(false)
                        .HasColumnType("varchar(70)");

                    b.Property<int?>("SubjectId")
                        .HasColumnType("int")
                        .HasColumnName("SubjectID");

                    b.HasKey("DocumentId");

                    b.HasIndex("SubjectId");

                    b.ToTable("Document", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Location", b =>
                {
                    b.Property<int>("LocationId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("LocationID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("LocationId"), 1L, 1);

                    b.Property<string>("City")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.Property<string>("Country")
                        .HasMaxLength(100)
                        .IsUnicode(false)
                        .HasColumnType("varchar(100)");

                    b.HasKey("LocationId");

                    b.ToTable("Location", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Message", b =>
                {
                    b.Property<int>("MessageId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("MessageID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("MessageId"), 1L, 1);

                    b.Property<string>("Content")
                        .HasMaxLength(200)
                        .IsUnicode(false)
                        .HasColumnType("varchar(200)");

                    b.Property<int?>("Receiver")
                        .HasColumnType("int");

                    b.Property<int?>("Sender")
                        .HasColumnType("int");

                    b.HasKey("MessageId");

                    b.HasIndex("Receiver");

                    b.HasIndex("Sender");

                    b.ToTable("Message", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Payment", b =>
                {
                    b.Property<int>("PaymentId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("PaymentID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("PaymentId"), 1L, 1);

                    b.Property<string>("CardNumber")
                        .HasMaxLength(16)
                        .IsUnicode(false)
                        .HasColumnType("varchar(16)");

                    b.Property<string>("Cvv")
                        .HasMaxLength(3)
                        .IsUnicode(false)
                        .HasColumnType("varchar(3)")
                        .HasColumnName("CVV");

                    b.Property<string>("ExpiryDate")
                        .HasMaxLength(5)
                        .IsUnicode(false)
                        .HasColumnType("varchar(5)");

                    b.Property<int?>("ReservationId")
                        .HasColumnType("int")
                        .HasColumnName("ReservationID");

                    b.HasKey("PaymentId");

                    b.HasIndex("ReservationId");

                    b.ToTable("Payment", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Report", b =>
                {
                    b.Property<int>("ReportId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ReportID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ReportId"), 1L, 1);

                    b.Property<int?>("ReservationId")
                        .HasColumnType("int")
                        .HasColumnName("ReservationID");

                    b.HasKey("ReportId");

                    b.HasIndex("ReservationId");

                    b.ToTable("Report", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Reservation", b =>
                {
                    b.Property<int>("ReservationId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ReservationID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ReservationId"), 1L, 1);

                    b.Property<int?>("AdvertId")
                        .HasColumnType("int")
                        .HasColumnName("AdvertID");

                    b.Property<string>("SelectedTime")
                        .HasMaxLength(20)
                        .IsUnicode(false)
                        .HasColumnType("varchar(20)");

                    b.Property<int?>("UserId")
                        .HasColumnType("int")
                        .HasColumnName("UserID");

                    b.HasKey("ReservationId");

                    b.HasIndex("AdvertId");

                    b.HasIndex("UserId");

                    b.ToTable("Reservation", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Review", b =>
                {
                    b.Property<int>("ReviewId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("ReviewID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("ReviewId"), 1L, 1);

                    b.Property<int?>("ReviewStars")
                        .HasColumnType("int");

                    b.Property<string>("ReviewText")
                        .HasMaxLength(200)
                        .IsUnicode(false)
                        .HasColumnType("varchar(200)");

                    b.Property<int?>("Reviewer")
                        .HasColumnType("int");

                    b.HasKey("ReviewId");

                    b.HasIndex("Reviewer");

                    b.ToTable("Review", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Subject", b =>
                {
                    b.Property<int>("SubjectId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int")
                        .HasColumnName("SubjectID");

                    SqlServerPropertyBuilderExtensions.UseIdentityColumn(b.Property<int>("SubjectId"), 1L, 1);

                    b.Property<int?>("CategoryId")
                        .HasColumnType("int")
                        .HasColumnName("CategoryID");

                    b.Property<string>("SubjectName")
                        .HasMaxLength(70)
                        .IsUnicode(false)
                        .HasColumnType("varchar(70)");

                    b.HasKey("SubjectId");

                    b.HasIndex("CategoryId");

                    b.ToTable("Subject", (string)null);
                });

            modelBuilder.Entity("StudAid.Services.Advert", b =>
                {
                    b.HasOne("StudAid.Services.Date", "DateNavigation")
                        .WithMany("Adverts")
                        .HasForeignKey("Date")
                        .HasConstraintName("FK__Advert__Date__33D4B598");

                    b.HasOne("StudAid.Services.Subject", "Subject")
                        .WithMany("Adverts")
                        .HasForeignKey("SubjectId")
                        .HasConstraintName("FK__Advert__SubjectI__34C8D9D1");

                    b.HasOne("StudAid.Services.AppUser", "TutorNavigation")
                        .WithMany("Adverts")
                        .HasForeignKey("Tutor")
                        .HasConstraintName("FK__Advert__Tutor__35BCFE0A");

                    b.Navigation("DateNavigation");

                    b.Navigation("Subject");

                    b.Navigation("TutorNavigation");
                });

            modelBuilder.Entity("StudAid.Services.AppUser", b =>
                {
                    b.HasOne("StudAid.Services.Location", "Location")
                        .WithMany("AppUsers")
                        .HasForeignKey("LocationId")
                        .HasConstraintName("FK__AppUser__Locatio__300424B4");

                    b.Navigation("Location");
                });

            modelBuilder.Entity("StudAid.Services.Document", b =>
                {
                    b.HasOne("StudAid.Services.Subject", "Subject")
                        .WithMany("Documents")
                        .HasForeignKey("SubjectId")
                        .HasConstraintName("FK__Document__Subjec__2B3F6F97");

                    b.Navigation("Subject");
                });

            modelBuilder.Entity("StudAid.Services.Message", b =>
                {
                    b.HasOne("StudAid.Services.AppUser", "ReceiverNavigation")
                        .WithMany("MessageReceiverNavigations")
                        .HasForeignKey("Receiver")
                        .HasConstraintName("FK__Message__Receive__38996AB5");

                    b.HasOne("StudAid.Services.AppUser", "SenderNavigation")
                        .WithMany("MessageSenderNavigations")
                        .HasForeignKey("Sender")
                        .HasConstraintName("FK__Message__Sender__398D8EEE");

                    b.Navigation("ReceiverNavigation");

                    b.Navigation("SenderNavigation");
                });

            modelBuilder.Entity("StudAid.Services.Payment", b =>
                {
                    b.HasOne("StudAid.Services.Reservation", "Reservation")
                        .WithMany("Payments")
                        .HasForeignKey("ReservationId")
                        .HasConstraintName("FK__Payment__Reserva__44FF419A");

                    b.Navigation("Reservation");
                });

            modelBuilder.Entity("StudAid.Services.Report", b =>
                {
                    b.HasOne("StudAid.Services.Reservation", "Reservation")
                        .WithMany("Reports")
                        .HasForeignKey("ReservationId")
                        .HasConstraintName("FK__Report__Reservat__47DBAE45");

                    b.Navigation("Reservation");
                });

            modelBuilder.Entity("StudAid.Services.Reservation", b =>
                {
                    b.HasOne("StudAid.Services.Advert", "Advert")
                        .WithMany("Reservations")
                        .HasForeignKey("AdvertId")
                        .HasConstraintName("FK__Reservati__Adver__3F466844");

                    b.HasOne("StudAid.Services.AppUser", "User")
                        .WithMany("Reservations")
                        .HasForeignKey("UserId")
                        .HasConstraintName("FK__Reservati__UserI__403A8C7D");

                    b.Navigation("Advert");

                    b.Navigation("User");
                });

            modelBuilder.Entity("StudAid.Services.Review", b =>
                {
                    b.HasOne("StudAid.Services.AppUser", "ReviewerNavigation")
                        .WithMany("Reviews")
                        .HasForeignKey("Reviewer")
                        .HasConstraintName("FK__Review__Reviewer__4AB81AF0");

                    b.Navigation("ReviewerNavigation");
                });

            modelBuilder.Entity("StudAid.Services.Subject", b =>
                {
                    b.HasOne("StudAid.Services.Category", "Category")
                        .WithMany("Subjects")
                        .HasForeignKey("CategoryId")
                        .HasConstraintName("FK__Subject__Categor__267ABA7A");

                    b.Navigation("Category");
                });

            modelBuilder.Entity("StudAid.Services.Advert", b =>
                {
                    b.Navigation("Reservations");
                });

            modelBuilder.Entity("StudAid.Services.AppUser", b =>
                {
                    b.Navigation("Adverts");

                    b.Navigation("MessageReceiverNavigations");

                    b.Navigation("MessageSenderNavigations");

                    b.Navigation("Reservations");

                    b.Navigation("Reviews");
                });

            modelBuilder.Entity("StudAid.Services.Category", b =>
                {
                    b.Navigation("Subjects");
                });

            modelBuilder.Entity("StudAid.Services.Date", b =>
                {
                    b.Navigation("Adverts");
                });

            modelBuilder.Entity("StudAid.Services.Location", b =>
                {
                    b.Navigation("AppUsers");
                });

            modelBuilder.Entity("StudAid.Services.Reservation", b =>
                {
                    b.Navigation("Payments");

                    b.Navigation("Reports");
                });

            modelBuilder.Entity("StudAid.Services.Subject", b =>
                {
                    b.Navigation("Adverts");

                    b.Navigation("Documents");
                });
#pragma warning restore 612, 618
        }
    }
}
