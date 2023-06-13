using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Document
    {
        public int DocumentId { get; set; }
        public string? DocumentName { get; set; }
        public int? SubjectId { get; set; }
        public string? Author { get; set; }
        public string? Description { get; set; }

        public virtual Subject? Subject { get; set; }
        public byte[]? DocumentFile { get; set; }
    }
}
