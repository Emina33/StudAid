using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.Requests
{
    public class AppUserUpdateRequest
    {
        
        public string FirstName { get; set; }
     
        public string LastName { get; set; }
   

        public string Password { get; set; }
        public string Role { get; set; }
        public string Description { get; set; }
        public byte[] ProfilePicture { get; set; }
    }
}
