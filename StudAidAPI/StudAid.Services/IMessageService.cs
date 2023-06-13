using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public interface IMessageService: ICRUDService<Model.Message, MessageSearchObject, MessageInsertRequest, MessageInsertRequest>
    {
    }
}
