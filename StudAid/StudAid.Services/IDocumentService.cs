using StudAid.Model.SearchObjects;
using StudAid.Model.Requests;
using StudAid.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface IDocumentService:ICRUDService<Model.Document, DocumentSearchObject, DocumentInsertRequest, DocumentInsertRequest>
    {
    }
}
