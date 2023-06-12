using AutoMapper;
using StudAid.Model;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services.AdvertStateMachine;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;

namespace StudAid.Services
{
    public class AdvertService:BaseCRUDService<Model.Advert,Advert, AdvertSearchObject, AdvertInsertRequest, AdvertUpdateRequest>, IAdvertService
    {
        public BaseState BaseState { get; set; }
        public AdvertService(stud_aid2Context context, IMapper mapper, BaseState baseState)
            : base(context, mapper)
        {
            BaseState = baseState;
            //Context = context;
            //Mapper = mapper;
        }
        public override Model.Advert Insert(AdvertInsertRequest insert)
        {
            //return base.Insert(insert);
            var state = BaseState.CreateState("initial");
            return state.Insert(insert);
        }

        public override Model.Advert Update(int id, AdvertUpdateRequest update)
        {
            //return base.Update(id, update);
            var advert = Context.Adverts.Find(id);

            var state = BaseState.CreateState(advert.StateMachine);
         
            state.CurrentEntity = advert;
            state.Update(update);
            return GetById(id);
        }
        public Model.Advert Activate(int id)
        {
            var advert = Context.Adverts.Find(id);

            var state = BaseState.CreateState(advert.StateMachine);
            state.Context = Context;
            state.CurrentEntity = advert;
            state.Activate();
            return GetById(id);
        }
        public List<string> AllowedActions(int id)
        {
            var entity = GetById(id);
            var state = BaseState.CreateState(entity.StateMachine);
            return state.AllowedActions();
        }


        public override IEnumerable<Model.Advert> Get(AdvertSearchObject search=null)
        {
            return base.Get(search);
        }
        public override IQueryable<Advert> AddFilter(IQueryable<Advert> query, AdvertSearchObject? search)
        {
            var filteredQuery = base.AddFilter(query, search);
            if(search?.Price != null || !string.IsNullOrWhiteSpace(search?.AdvertName))
            {
                filteredQuery = filteredQuery.Where(s => s.Price == search.Price || s.AdvertName.Contains(search.AdvertName));
            }
            return filteredQuery;
        }
       



        //public override IEnumerable<Advert> Get(AdvertSearchObject search = null)
        //{
        //    return base.Get(search);
        //}
    }
   
}
