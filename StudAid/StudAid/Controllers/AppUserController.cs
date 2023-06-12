using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using StudAid.Services;
using StudAid.Model;
using StudAid.Model.SearchObjects;
using StudAid.Model.Requests;
using Microsoft.AspNetCore.Authorization;

namespace StudAid.Controllers
{
    [ApiController]
    [Route("[controller]")]
    [Authorize]
    public class AppUserController : BaseCRUDController<Model.AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>
    {
       // private readonly IAppUserService _Service;

        public IAppUserService AppUserService { get; set; }

        public AppUserController(IAppUserService service)
            : base(service) { 
        AppUserService = service;
        }
        
        [HttpGet("{id}/Recommend")]
        [AllowAnonymous]
        public List<Model.Advert> Recommend(int id)
        {
            var result = AppUserService.Recommend(id);

            return result;
        }
        //[Authorize("johndoe1")]
        //public override Model.AppUser Insert([FromBody] AppUserInsertRequest insert)
        //{
        //    return base.Insert(insert);
        //}
        //[Authorize("johndoe1")]
        //public override Model.AppUser Update(int id,[FromBody] AppUserInsertRequest update)
        //{
        //    return base.Update(id,update);
        //}

    }
}
