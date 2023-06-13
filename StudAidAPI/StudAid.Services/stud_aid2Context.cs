using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;

namespace StudAid.Services
{
    public partial class stud_aid2Context : DbContext
    {
        public stud_aid2Context()
        {
        }

        public stud_aid2Context(DbContextOptions<stud_aid2Context> options)
            : base(options)
        {
        }

        public virtual DbSet<Advert> Adverts { get; set; } = null!;
        public virtual DbSet<AppUser> AppUsers { get; set; } = null!;
        public virtual DbSet<Category> Categories { get; set; } = null!;
        public virtual DbSet<Date> Dates { get; set; } = null!;
        public virtual DbSet<Document> Documents { get; set; } = null!;
        public virtual DbSet<Location> Locations { get; set; } = null!;
        public virtual DbSet<Message> Messages { get; set; } = null!;
        public virtual DbSet<Payment> Payments { get; set; } = null!;
        public virtual DbSet<Report> Reports { get; set; } = null!;
        public virtual DbSet<Reservation> Reservations { get; set; } = null!;
        public virtual DbSet<Review> Reviews { get; set; } = null!;
        public virtual DbSet<Subject> Subjects { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see http://go.microsoft.com/fwlink/?LinkId=723263.
                optionsBuilder.UseSqlServer("Data Source=.;Initial Catalog=stud_aid2;Integrated Security=True");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Advert>(entity =>
            {
                entity.ToTable("Advert");

                entity.Property(e => e.AdvertId).HasColumnName("AdvertID");

                entity.Property(e => e.AdvertName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.AvailableTime)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.StateMachine).HasMaxLength(50);

                entity.Property(e => e.SubjectId).HasColumnName("SubjectID");

                entity.HasOne(d => d.DateNavigation)
                    .WithMany(p => p.Adverts)
                    .HasForeignKey(d => d.Date)
                    .HasConstraintName("FK__Advert__Date__33D4B598");

                entity.HasOne(d => d.Subject)
                    .WithMany(p => p.Adverts)
                    .HasForeignKey(d => d.SubjectId)
                    .HasConstraintName("FK__Advert__SubjectI__34C8D9D1");

                entity.HasOne(d => d.TutorNavigation)
                    .WithMany(p => p.Adverts)
                    .HasForeignKey(d => d.Tutor)
                    .HasConstraintName("FK__Advert__Tutor__35BCFE0A");
            });

            modelBuilder.Entity<AppUser>(entity =>
            {
                entity.HasKey(e => e.UserId)
                    .HasName("PK__AppUser__1788CCACAAA5764A");

                entity.ToTable("AppUser");

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.Property(e => e.FirstName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.LastName)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.LocationId).HasColumnName("LocationID");

                entity.Property(e => e.Password)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Username)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.HasOne(d => d.Location)
                    .WithMany(p => p.AppUsers)
                    .HasForeignKey(d => d.LocationId)
                    .HasConstraintName("FK__AppUser__Locatio__300424B4");
            });

            modelBuilder.Entity<Category>(entity =>
            {
                entity.ToTable("Category");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.CategoryName)
                    .HasMaxLength(70)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Date>(entity =>
            {
                entity.ToTable("Date");

                entity.Property(e => e.DateId).HasColumnName("DateID");
            });

            modelBuilder.Entity<Document>(entity =>
            {
                entity.ToTable("Document");

                entity.Property(e => e.DocumentId).HasColumnName("DocumentID");

                entity.Property(e => e.Author)
                    .HasMaxLength(80)
                    .IsUnicode(false);

                entity.Property(e => e.DocumentName)
                    .HasMaxLength(70)
                    .IsUnicode(false);

                entity.Property(e => e.SubjectId).HasColumnName("SubjectID");

                entity.HasOne(d => d.Subject)
                    .WithMany(p => p.Documents)
                    .HasForeignKey(d => d.SubjectId)
                    .HasConstraintName("FK__Document__Subjec__2B3F6F97");
            });

            modelBuilder.Entity<Location>(entity =>
            {
                entity.ToTable("Location");

                entity.Property(e => e.LocationId).HasColumnName("LocationID");

                entity.Property(e => e.City)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.Country)
                    .HasMaxLength(100)
                    .IsUnicode(false);
            });

            modelBuilder.Entity<Message>(entity =>
            {
                entity.ToTable("Message");

                entity.Property(e => e.MessageId).HasColumnName("MessageID");

                entity.Property(e => e.Content)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.HasOne(d => d.ReceiverNavigation)
                    .WithMany(p => p.MessageReceiverNavigations)
                    .HasForeignKey(d => d.Receiver)
                    .HasConstraintName("FK__Message__Receive__38996AB5");

                entity.HasOne(d => d.SenderNavigation)
                    .WithMany(p => p.MessageSenderNavigations)
                    .HasForeignKey(d => d.Sender)
                    .HasConstraintName("FK__Message__Sender__398D8EEE");
            });

            modelBuilder.Entity<Payment>(entity =>
            {
                entity.ToTable("Payment");

                entity.Property(e => e.PaymentId).HasColumnName("PaymentID");

                entity.Property(e => e.CardNumber)
                    .HasMaxLength(16)
                    .IsUnicode(false);

                entity.Property(e => e.Cvv)
                    .HasMaxLength(3)
                    .IsUnicode(false)
                    .HasColumnName("CVV");

                entity.Property(e => e.ExpiryDate)
                    .HasMaxLength(5)
                    .IsUnicode(false);

                entity.Property(e => e.ReservationId).HasColumnName("ReservationID");

                entity.HasOne(d => d.Reservation)
                    .WithMany(p => p.Payments)
                    .HasForeignKey(d => d.ReservationId)
                    .HasConstraintName("FK__Payment__Reserva__44FF419A");
            });

            modelBuilder.Entity<Report>(entity =>
            {
                entity.ToTable("Report");

                entity.Property(e => e.ReportId).HasColumnName("ReportID");

                entity.Property(e => e.ReservationId).HasColumnName("ReservationID");

                entity.HasOne(d => d.Reservation)
                    .WithMany(p => p.Reports)
                    .HasForeignKey(d => d.ReservationId)
                    .HasConstraintName("FK__Report__Reservat__47DBAE45");
            });

            modelBuilder.Entity<Reservation>(entity =>
            {
                entity.ToTable("Reservation");

                entity.Property(e => e.ReservationId).HasColumnName("ReservationID");

                entity.Property(e => e.AdvertId).HasColumnName("AdvertID");

                entity.Property(e => e.SelectedTime)
                    .HasMaxLength(20)
                    .IsUnicode(false);

                entity.Property(e => e.UserId).HasColumnName("UserID");

                entity.HasOne(d => d.Advert)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.AdvertId)
                    .HasConstraintName("FK__Reservati__Adver__3F466844");

                entity.HasOne(d => d.User)
                    .WithMany(p => p.Reservations)
                    .HasForeignKey(d => d.UserId)
                    .HasConstraintName("FK__Reservati__UserI__403A8C7D");
            });

            modelBuilder.Entity<Review>(entity =>
            {
                entity.ToTable("Review");

                entity.Property(e => e.ReviewId).HasColumnName("ReviewID");

                entity.Property(e => e.ReviewText)
                    .HasMaxLength(200)
                    .IsUnicode(false);

                entity.HasOne(d => d.ReviewerNavigation)
                    .WithMany(p => p.Reviews)
                    .HasForeignKey(d => d.Reviewer)
                    .HasConstraintName("FK__Review__Reviewer__4AB81AF0");
            });

            modelBuilder.Entity<Subject>(entity =>
            {
                entity.ToTable("Subject");

                entity.Property(e => e.SubjectId).HasColumnName("SubjectID");

                entity.Property(e => e.CategoryId).HasColumnName("CategoryID");

                entity.Property(e => e.SubjectName)
                    .HasMaxLength(70)
                    .IsUnicode(false);

                entity.HasOne(d => d.Category)
                    .WithMany(p => p.Subjects)
                    .HasForeignKey(d => d.CategoryId)
                    .HasConstraintName("FK__Subject__Categor__267ABA7A");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
