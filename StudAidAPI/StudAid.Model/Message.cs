using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model
{
    public partial class Message
    {
        public int MessageId { get; set; }
 
        public string Content { get; set; }
        public int? Sender { get; set; }
        public int? Receiver { get; set; }
    }
}
