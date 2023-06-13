using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class MessageSearchObject:BaseSearchObject
    {
        public string Content { get; set; }
        public int Sender { get; set; }
        public int Receiver { get; set; }
    }
}
