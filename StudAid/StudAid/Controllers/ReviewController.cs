using Microsoft.AspNetCore.Mvc;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class ReviewController : BaseCRUDController<Model.Review, ReviewSearchObject, ReviewInsertRequest, ReviewInsertRequest>
    {
        public ReviewController(IReviewService service)
        : base(service) { }
    }
}
