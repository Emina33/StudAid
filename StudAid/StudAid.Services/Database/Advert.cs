using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Advert
    {
        public Advert()
        {
            Reservations = new HashSet<Reservation>();
        }

        public int AdvertId { get; set; }
        public string? AdvertName { get; set; }
        public string? AvailableTime { get; set; }
        public double? Price { get; set; }
        public int? Tutor { get; set; }
        public int? SubjectId { get; set; }
        public int? Date { get; set; }
        public string? StateMachine { get; set; }

        public virtual Date? DateNavigation { get; set; }
        public virtual Subject? Subject { get; set; }
        public virtual AppUser? TutorNavigation { get; set; }
        public virtual ICollection<Reservation> Reservations { get; set; }
    }
}
