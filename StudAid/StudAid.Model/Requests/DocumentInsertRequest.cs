using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class DocumentInsertRequest
    {
        public string DocumentName { get; set; }

        public int? SubjectId { get; set; }

        public string Author { get; set; }
        public string Description { get; set; }
        public byte[] DocumentFile { get; set; }
    }
}
