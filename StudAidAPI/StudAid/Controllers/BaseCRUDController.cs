using Microsoft.AspNetCore.Mvc;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(service)
        {
        }

        [HttpPost]
        public virtual T Insert([FromBody] TInsert insert)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Insert(insert);

            return result;
        }

        [HttpPut("{id}")]
        public virtual T Update(int id,[FromBody] TUpdate update)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Update(id, update);

            return result;
        }
        [HttpDelete("{id}")]
        public virtual T Delete(int id)
        {
            var result = ((ICRUDService<T, TSearch, TInsert, TUpdate>)this.Service).Delete(id);

            return result;
        }
    }
}
