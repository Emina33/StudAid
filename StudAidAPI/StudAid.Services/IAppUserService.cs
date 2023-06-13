using StudAid.Model;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface IAppUserService : ICRUDService<Model.AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>
    {
        Model.AppUser Login(string username, string password);
       
    }
}
