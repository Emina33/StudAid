using System;
using System.Collections.Generic;
using System.Text;

namespace StudAid.Model.SearchObjects
{
    public class CategorySearchObject:BaseSearchObject
    {
        public int CategoryId { get; set; }
        public string CategoryName { get; set; }
    }
}
