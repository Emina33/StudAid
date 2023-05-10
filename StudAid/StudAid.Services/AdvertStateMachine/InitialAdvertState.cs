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
    public class InitialAdvertState : BaseState
    {
        public InitialAdvertState(IServiceProvider serviceProvider, stud_aid2Context context, IMapper mapper)
            : base(serviceProvider, context, mapper)
        {
        }

        public override Model.Advert Insert(AdvertInsertRequest request)
        {
            var set = Context.Set<Advert>();

            Advert entity = Mapper.Map<Advert>(request);

            CurrentEntity = entity;
            CurrentEntity.StateMachine = "draft";

            set.Add(entity);

            Context.SaveChanges();

            return Mapper.Map<Model.Advert>(entity);
        }
    }
}
