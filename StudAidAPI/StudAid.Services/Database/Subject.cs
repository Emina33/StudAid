using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Subject
    {
        public Subject()
        {
            Adverts = new HashSet<Advert>();
            Documents = new HashSet<Document>();
        }

        public int SubjectId { get; set; }
        public string? SubjectName { get; set; }
        public int? CategoryId { get; set; }

        public virtual Category? Category { get; set; }
        public virtual ICollection<Advert> Adverts { get; set; }
        public virtual ICollection<Document> Documents { get; set; }
    }
}
