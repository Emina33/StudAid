using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Report
    {
        public int ReportId { get; set; }
        public int? ReservationId { get; set; }

        public virtual Reservation? Reservation { get; set; }
    }
}
