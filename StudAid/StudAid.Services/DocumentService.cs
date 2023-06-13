using AutoMapper;
using Microsoft.EntityFrameworkCore;
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
    public class DocumentService:BaseCRUDService<Model.Document, Document, DocumentSearchObject, DocumentInsertRequest, DocumentInsertRequest>, IDocumentService
    {
        public DocumentService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {
            
        }
        public override IQueryable<Document> AddFilter(IQueryable<Document> query, DocumentSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            
            if (!string.IsNullOrEmpty(search?.DocumentName))
            {
                filteredQuery = filteredQuery.Where(s => s.DocumentName.StartsWith(search.DocumentName));
            }
            
            return filteredQuery;
        }
        public override IQueryable<Document> AddInclude(IQueryable<Document> query, DocumentSearchObject search = null)
        {
           
            query = query.Include(d => d.Subject);
          
            return query;
        }


    }
}
