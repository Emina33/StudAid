using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class MessageController : BaseCRUDController<Model.Message, MessageSearchObject, MessageInsertRequest, MessageInsertRequest>
    {
        public MessageController(IMessageService service)
       : base(service) { }
    }
}
