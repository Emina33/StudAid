using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public class Subject
    {
        public int SubjectId { get; set; }
     
        public string SubjectName { get; set; }

        public int? CategoryId { get; set; }
    }
}
