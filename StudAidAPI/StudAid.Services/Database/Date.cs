using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Date
    {
        public Date()
        {
            Adverts = new HashSet<Advert>();
        }

        public int DateId { get; set; }
        public int? Day { get; set; }
        public int? Month { get; set; }
        public int? Year { get; set; }

        public virtual ICollection<Advert> Adverts { get; set; }
    }
}
