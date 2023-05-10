using Microsoft.AspNetCore.Mvc;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    
    public class AdvertController : BaseCRUDController<Model.Advert, AdvertSearchObject, AdvertInsertRequest, AdvertUpdateRequest>
    {
        public IAdvertService Service { get; set; }
        
       public AdvertController(IAdvertService service)
            : base(service) 
        { 
            Service = service;
        }

        [HttpPut("{id}/Activate")]
        public Model.Advert Activate(int id)
        {
            var result = Service.Activate(id);

            return result;
        }
        [HttpPut("{id}/AllowedActions")]
        public List<string> AllowedActions(int id)
        {
            var result = Service.AllowedActions(id);

            return result;
        }
    }
}
