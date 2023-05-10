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
    public class CategoryService:BaseCRUDService<Model.Category, Category, CategorySearchObject, CategoryInsertRequest, CategoryInsertRequest>, ICategoryService
    {
        public CategoryService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {
            
        }
        public override IQueryable<Category> AddFilter(IQueryable<Category> query, CategorySearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            Console.WriteLine("Idemoooooo");
            
            if (!string.IsNullOrEmpty(search?.CategoryName))
            {
                filteredQuery = filteredQuery.Where(s => s.CategoryName.StartsWith(search.CategoryName));
            }
            
            return filteredQuery;
        }

        
    }
}
