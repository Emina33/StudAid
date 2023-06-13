using StudAid.Model.SearchObjects;
using StudAid.Model.Requests;
using StudAid.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface ICategoryService:ICRUDService<Model.Category, CategorySearchObject, CategoryInsertRequest, CategoryInsertRequest>
    {
    }
}
