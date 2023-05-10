using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class DocumentSearchObject:BaseSearchObject
    {
        public string DocumentName { get; set; }

        public int? SubjectId { get; set; }

        public string Author { get; set; }
    }
}
