using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using StudAid.Model.Requests;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services.AdvertStateMachine
{
    public class BaseState
    {
        public IMapper Mapper { get; set; }
        public IServiceProvider ServiceProvider { get; set; }
        public BaseState(IServiceProvider serviceProvider, stud_aid2Context context, IMapper mapper)
        {
            Context = context;
            ServiceProvider = serviceProvider;
            Mapper = mapper;
        }

        public Advert CurrentEntity { get; set; }
        public string CurrentState { get; set; }

        public stud_aid2Context Context { get; set; } = null;

        public virtual Model.Advert Insert(AdvertInsertRequest request)
        {
            throw new Exception("Not allowed");
        }

        public virtual void Update(AdvertUpdateRequest request)
        {
            throw new Exception("Not allowed");
        }

        public virtual void Activate()
        {
            throw new Exception("Not allowed");
        }

        public virtual void Hide()
        {
            throw new Exception("Not allowed");
        }

        public virtual void Delete()
        {
            throw new Exception("Not allowed");
        }

        public BaseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "initial":
                    return ServiceProvider.GetService<InitialAdvertState>();
                    break;
                case "draft":
                    return ServiceProvider.GetService<DraftAdvertState>();
                    break;
                case "active":
                    return ServiceProvider.GetService<ActiveAdvertState>();
                    break;
                default:
                    throw new Exception("Not supported");
            }
        }

        public virtual List<string> AllowedActions()
        {
            return new List<string>();
        }


    }
}
