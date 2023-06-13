using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Reservation
    {
        public Reservation()
        {
            Payments = new HashSet<Payment>();
            Reports = new HashSet<Report>();
        }

        public int ReservationId { get; set; }
        public int? AdvertId { get; set; }
        public int? UserId { get; set; }
        public string? SelectedTime { get; set; }

        public virtual Advert? Advert { get; set; }
        public virtual AppUser? User { get; set; }
        public virtual ICollection<Payment> Payments { get; set; }
        public virtual ICollection<Report> Reports { get; set; }
    }
}
