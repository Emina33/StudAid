using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class PaymentInsertRequest
    {
        public int? ReservationId { get; set; }

        public string CardNumber { get; set; }

        public string ExpiryDate { get; set; }

        public string Cvv { get; set; }
    }
}
