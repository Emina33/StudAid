using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class ReservationInsertRequest
    {

       public int? AdvertId { get; set; }
        public int? UserId { get; set; }
        public string SelectedTime { get; set; }

    }
}
