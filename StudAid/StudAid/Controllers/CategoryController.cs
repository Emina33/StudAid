using Microsoft.AspNetCore.Mvc;
using StudAid.Model;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    //[Route("/[controller]")]
    //[ApiController]
    public class CategoryController : BaseCRUDController<Model.Category, CategorySearchObject, CategoryInsertRequest, CategoryInsertRequest>
    {
        //private readonly IService<Model.Category, CategorySearchObject> _Service;
        //private readonly ICategoryService _Service;
        public CategoryController(ICategoryService service)
        : base(service) { }

        //[HttpGet]

        //public IEnumerable<Category> Get()
        //{
        //    return _Service.Get();
        //}
        //[HttpGet("{id}")]
        //public Category GetById(int id)
        //{
        //    return _Service.GetById(id);
        //}

    }
}
