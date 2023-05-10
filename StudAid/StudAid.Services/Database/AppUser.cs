using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class AppUser
    {
        public AppUser()
        {
            Adverts = new HashSet<Advert>();
            MessageReceiverNavigations = new HashSet<Message>();
            MessageSenderNavigations = new HashSet<Message>();
            Reservations = new HashSet<Reservation>();
            Reviews = new HashSet<Review>();
        }

        public int UserId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Username { get; set; }
        public string? Password { get; set; }
        public string? PasswordSalt { get; set; }
        public int? LocationId { get; set; }
        public string? Role { get; set; }
        public string? Description { get; set; }

        public virtual Location? Location { get; set; }
        public virtual ICollection<Advert> Adverts { get; set; }
        public virtual ICollection<Message> MessageReceiverNavigations { get; set; }
        public virtual ICollection<Message> MessageSenderNavigations { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
        public virtual ICollection<Review> Reviews { get; set; }
    }
}
