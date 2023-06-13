using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Document
    {
        public int DocumentId { get; set; }
       
        public string DocumentName { get; set; }

        public int? SubjectId { get; set; }

        public string Author { get; set; }
        public string Description { get; set; }
        public virtual Subject Subject { get; set; }
        public string NameSubject => Subject?.SubjectName;
        public byte[] DocumentFile { get; set; }
    }
}
