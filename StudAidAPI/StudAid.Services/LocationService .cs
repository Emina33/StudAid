using AutoMapper;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class LocationService:BaseCRUDService<Model.Location, Location, LocationSearchObject, LocationUpsertRequest, LocationUpsertRequest>, ILocationService
    {
        public LocationService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {
            
        }
        public override IQueryable<Location> AddFilter(IQueryable<Location> query, LocationSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrEmpty(search?.Country))
            {
                filteredQuery = filteredQuery.Where(s => s.Country.StartsWith(search.Country));
            }
            if (!string.IsNullOrEmpty(search?.City))
            {
                filteredQuery = filteredQuery.Where(s => s.City.StartsWith(search.City));
            }

            return filteredQuery;
        }


    }
}
