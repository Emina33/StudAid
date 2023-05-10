using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Category
    {
        public Category()
        {
            Subjects = new HashSet<Subject>();
        }

        public int CategoryId { get; set; }
        public string? CategoryName { get; set; }

        public virtual ICollection<Subject> Subjects { get; set; }
    }
}
