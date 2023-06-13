using AutoMapper;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services.AdvertStateMachine
{
    public class ActiveAdvertState : BaseState
    {
        public ActiveAdvertState(IServiceProvider serviceProvider, stud_aid2Context context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
    }
}
