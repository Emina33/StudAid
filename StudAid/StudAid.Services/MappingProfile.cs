using AutoMapper;
using StudAid.Model.Requests;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class MappingProfile : Profile
    {
        public MappingProfile()
        {
            CreateMap<AppUser, Model.AppUser>();
            CreateMap<Category, Model.Category>();
            CreateMap<Subject, Model.Subject>();
            CreateMap<Advert, Model.Advert>();
            CreateMap<Location, Model.Location>();
            CreateMap<Document, Model.Document>();
            CreateMap<Reservation, Model.Reservation>();
            CreateMap<CategoryInsertRequest, Category>();
            CreateMap<SubjectUpsertRequest,Subject>();
            CreateMap<AdvertInsertRequest, Advert>();
            CreateMap<AdvertUpdateRequest, Advert>();
            CreateMap<AppUserInsertRequest, AppUser>();
            CreateMap<DocumentInsertRequest, Document>();
            CreateMap<LocationUpsertRequest, Location>();
            CreateMap<ReservationInsertRequest, Reservation>();
        }
    }
}
