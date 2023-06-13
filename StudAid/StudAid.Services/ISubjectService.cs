using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface ISubjectService : ICRUDService<Model.Subject, SubjectSearchObject, SubjectUpsertRequest, SubjectUpsertRequest>
    {
    }
}
