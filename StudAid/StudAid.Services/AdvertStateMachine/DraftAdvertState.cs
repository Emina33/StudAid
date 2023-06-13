using AutoMapper;
using StudAid.Model.Requests;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services.AdvertStateMachine
{
    public class DraftAdvertState : BaseState
    {
        public DraftAdvertState(IServiceProvider serviceProvider, stud_aid2Context context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }

        public override void Update(AdvertUpdateRequest request)
        {
            var set = Context.Set<Advert>();

            Mapper.Map(request, CurrentEntity);
           CurrentEntity.StateMachine = "draft";

            Context.SaveChanges();

           


            //update data by calling EF...
        }

        public override void Activate()
        {
            CurrentEntity.StateMachine = "active";
            Context.SaveChanges();
            //update data by calling EF...
        }

        public override List<string> AllowedActions()
        {
            var list = base.AllowedActions();

            list.Add("update");
            list.Add("activate");
            list.Add("hide");

            return list;
        }
    }
}
