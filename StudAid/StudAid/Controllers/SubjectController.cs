using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    
    public class SubjectController : BaseCRUDController<Model.Subject, SubjectSearchObject, SubjectUpsertRequest, SubjectUpsertRequest>
    {

        //private readonly ISubjectService _Service;
        public SubjectController(ISubjectService service)
       : base(service) { }

    }
}
