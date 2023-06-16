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
    public class ReservationService:BaseCRUDService<Model.Reservation, Reservation, ReservationSearchObject, ReservationInsertRequest, ReservationInsertRequest>, IReservationService
    {
        public ReservationService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {
            
        }
        public override IQueryable<Reservation> AddFilter(IQueryable<Reservation> query, ReservationSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
           
            
           
            return filteredQuery;
        }

        
    }
}
