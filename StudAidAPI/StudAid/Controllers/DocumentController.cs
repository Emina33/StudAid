using Microsoft.AspNetCore.Mvc;
using StudAid.Model;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class DocumentController : BaseCRUDController<Model.Document, DocumentSearchObject, DocumentInsertRequest, DocumentInsertRequest>
    {    
        public DocumentController(IDocumentService service)
        : base(service) { }
    }
}
