using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class AdvertSearchObject:BaseSearchObject
    {
        public string AdvertName { get; set; }
        public double? Price { get; set; }
    }
}
