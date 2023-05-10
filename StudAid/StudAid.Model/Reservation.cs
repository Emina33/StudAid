using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Reservation
    {
        
        public int? AdvertId { get; set; }
  
        public int? UserId { get; set; }

        public string SelectedTime { get; set; }
    }
}
