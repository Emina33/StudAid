using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class ReviewInsertRequest
    {
        public string ReviewText { get; set; }
        public int ReviewStars { get; set; }
        public int Reviewer { get; set; }
    }
}
