using System;
using System.Collections.Generic;

namespace StudAid.Services
{
    public partial class Message
    {
        public int MessageId { get; set; }
        public string? Content { get; set; }
        public int? Sender { get; set; }
        public int? Receiver { get; set; }

        public virtual AppUser? ReceiverNavigation { get; set; }
        public virtual AppUser? SenderNavigation { get; set; }
    }
}
