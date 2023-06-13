using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using StudAid.Model;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class LocationController : BaseCRUDController<Model.Location, LocationSearchObject, LocationUpsertRequest, LocationUpsertRequest>
    {    
        public LocationController(ILocationService service)
        : base(service) { }
        //[AllowAnonymous]
        //public override IEnumerable<Model.Location> Get([FromQuery] LocationSearchObject search = null)
        //{
        //    return base.Get(search);
        //}
    }
}
