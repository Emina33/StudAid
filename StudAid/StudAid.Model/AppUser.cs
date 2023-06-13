using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class AppUser
    {
        
        public int UserId { get; set; }
        
        public string FirstName { get; set; }
        
        public string LastName { get; set; }
        
        public string Username { get; set; }

        public string Role { get; set; }
        public string Description { get; set; }

        public int? LocationId { get; set; }
        public byte[] ProfilePicture { get; set; }

        //public virtual Location? Location { get; set; }

        //public virtual ICollection<Advert> Adverts { get; set; }

        //public virtual ICollection<Message> MessageReceiverNavigations { get; set; }

        //public virtual ICollection<Message> MessageSenderNavigations { get; set; }

        //public virtual ICollection<Reservation> Reservations { get; set; }
        //public virtual ICollection<Review> Reviews { get; set; }
    }
}
