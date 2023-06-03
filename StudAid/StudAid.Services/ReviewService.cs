using AutoMapper;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class ReviewService:BaseCRUDService<Model.Review, Review, ReviewSearchObject, ReviewInsertRequest, ReviewInsertRequest>, IReviewService
    {
        public ReviewService(stud_aid2Context context, IMapper mapper)
          : base(context, mapper)
        {

        }
        public override IQueryable<Review> AddFilter(IQueryable<Review> query, ReviewSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            


            return filteredQuery;
        }
    }
}
