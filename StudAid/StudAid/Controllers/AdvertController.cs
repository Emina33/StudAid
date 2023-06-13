using Microsoft.AspNetCore.Mvc;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    
    public class AdvertController : BaseCRUDController<Model.Advert, AdvertSearchObject, AdvertInsertRequest, AdvertUpdateRequest>
    {
        public IAdvertService AdvertService { get; set; }
        
       public AdvertController(IAdvertService service)
            : base(service) 
        { 
            AdvertService = service;
        }

        [HttpPut("{id}/Activate")]
        public Model.Advert Activate(int id)
        {
            var result = AdvertService.Activate(id);

            return result;
        }
        [HttpPut("{id}/AllowedActions")]
        public List<string> AllowedActions(int id)
        {
            var result = AdvertService.AllowedActions(id);

            return result;
        }
        [HttpGet("{id}/Recommend")]
        public List<Model.Advert> Recommend(int id)
        {
            var result = AdvertService.Recommend(id);

            return result;
        }
    }
}
