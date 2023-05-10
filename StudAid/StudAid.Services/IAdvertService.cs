using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface IAdvertService:ICRUDService<Model.Advert, AdvertSearchObject, AdvertInsertRequest, AdvertUpdateRequest>
    {
        Model.Advert Activate(int id);
        List<string> AllowedActions(int id);
       
    }
}
