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
    public class SubjectService : BaseCRUDService<Model.Subject,Subject, SubjectSearchObject, SubjectUpsertRequest, SubjectUpsertRequest>, ISubjectService
    {
        public SubjectService(stud_aid2Context context, IMapper mapper)
          : base(context, mapper)
        {

        }
        public override IQueryable<Subject> AddFilter(IQueryable<Subject> query, SubjectSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.SubjectName))
            {
                filteredQuery = filteredQuery.Where(s => s.SubjectName.Contains(search.SubjectName));
            }

            return filteredQuery;
        }
    }
}
