using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Review
    {
        public int ReviewId { get; set; }
        public string? ReviewText { get; set; }
        public int? ReviewStars { get; set; }
        public int? Reviewer { get; set; }

        public virtual AppUser? ReviewerNavigation { get; set; }
    }
}
