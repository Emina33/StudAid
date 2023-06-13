using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Date
    {
        public int DateId { get; set; }
        public int? Day { get; set; }
        public int? Month { get; set; }
        public int? Year { get; set; }
    }
}
