using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class MessageInsertRequest
    {
        public string Content { get; set; }
        public int Sender { get; set; }
        public int Receiver { get; set; }
    }
}
