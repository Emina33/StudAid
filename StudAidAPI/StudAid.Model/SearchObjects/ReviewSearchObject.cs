using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class ReviewSearchObject:BaseSearchObject
    {
        public string ReviewText { get; set; }
        public int ReviewStars { get; set; }
        public int Reviewer { get; set; }
    }
}
