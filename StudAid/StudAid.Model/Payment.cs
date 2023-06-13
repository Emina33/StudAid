using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Payment
    {
        public int PaymentId { get; set; }

        public int? ReservationId { get; set; }

        public string CardNumber { get; set; }

        public string ExpiryDate { get; set; }
   
        public string Cvv { get; set; }

    }
}
