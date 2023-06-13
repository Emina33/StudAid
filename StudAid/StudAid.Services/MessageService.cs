using AutoMapper;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class MessageService:BaseCRUDService<Model.Message, Message, MessageSearchObject, MessageInsertRequest, MessageInsertRequest>, IMessageService
    {
        public MessageService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {

        }
        public override IQueryable<Message> AddFilter(IQueryable<Message> query, MessageSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);
            Console.WriteLine("Idemoooooo");


            return filteredQuery;
        }

    }
}
