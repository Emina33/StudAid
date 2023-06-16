using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class SubjectUpsertRequest
    {

        public string SubjectName { get; set; }
        public int? CategoryId { get; set; }
    }
}
