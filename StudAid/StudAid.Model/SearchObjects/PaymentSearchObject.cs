using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class PaymentSearchObject:BaseSearchObject
    {
        public int? ReservationId { get; set; }

        public string CardNumber { get; set; }

        public string ExpiryDate { get; set; }

        public string Cvv { get; set; }
    }
}
