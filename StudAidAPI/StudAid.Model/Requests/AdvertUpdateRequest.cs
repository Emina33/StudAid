using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class AdvertUpdateRequest
    {
        public string AdvertName { get; set; }

        public string AvailableTime { get; set; }
        public double? Price { get; set; }
        public int? Tutor { get; set; }
        public int? SubjectId { get; set; }
        public int? Date { get; set; }
    }
}
