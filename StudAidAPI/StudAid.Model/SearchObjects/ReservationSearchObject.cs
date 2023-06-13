using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class ReservationSearchObject:BaseSearchObject
    {

       public int? AdvertId { get; set; }
        public int? UserId { get; set; }

    }
}
