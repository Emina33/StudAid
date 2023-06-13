using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Review
    {
        public int ReviewId { get; set; }
     
        public string ReviewText { get; set; }
        public int? ReviewStars { get; set; }
        public int? Reviewer { get; set; }
    }
}
