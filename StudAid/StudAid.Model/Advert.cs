using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Advert
    {
        public int AdvertId { get; set; }
     
        public string AdvertName { get; set; }
       
        public string AvailableTime { get; set; }
        public double? Price { get; set; }
        public int? Tutor { get; set; }
        public int? SubjectId { get; set; }
        public int? Date { get; set; }
        public string StateMachine { get; set; }
    }
}
