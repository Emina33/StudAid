using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Location
    {
        public Location()
        {
            AppUsers = new HashSet<AppUser>();
        }

        public int LocationId { get; set; }
        public string? City { get; set; }
        public string? Country { get; set; }

        public virtual ICollection<AppUser> AppUsers { get; set; }
    }
}
