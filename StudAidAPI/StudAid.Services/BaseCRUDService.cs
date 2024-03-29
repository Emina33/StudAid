﻿using AutoMapper;
using StudAid.Model.SearchObjects;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class BaseCRUDService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>, ICRUDService<T, TSearch, TInsert, TUpdate> where T : class where TDb : class where TSearch : BaseSearchObject where TInsert : class where TUpdate : class
    {
        public BaseCRUDService(stud_aid2Context context, IMapper mapper)
            : base(context, mapper)
        {
            
        }

        public virtual T Insert(TInsert insert)
        {
            var set = Context.Set<TDb>();

            TDb entity = Mapper.Map<TDb>(insert);

            set.Add(entity);
            BeforeInsert(insert,entity);

            Context.SaveChanges();

            return Mapper.Map<T>(entity);
        }

        public virtual void BeforeInsert(TInsert insert, TDb entity)
        {

        }
        public virtual void BeforeUpdate(TUpdate update, TDb entity)
        {

        }

        public virtual T Update(int id, TUpdate update)
        {
            var set = Context.Set<TDb>();
            var entity = set.Find(id);

            if (entity != null)
            {
                Mapper.Map(update, entity);
            }
            else
            {
                return null;
            }
            BeforeUpdate(update, entity);
            Context.SaveChanges();
            return Mapper.Map<T>(entity);
        }
        public virtual void BeforeDelete(TDb dbentity)
        {

        }
        public virtual void AfterDelete(TDb dbentity)
        {

        }
        public virtual T? Delete(int id)
        {
            var set = Context.Set<TDb>();

            var dbentity = set.Find(id);

            if (dbentity == null)
            {
                return null;
            }

            var deletedEntity = dbentity;

            BeforeDelete(deletedEntity);

            set.Remove(dbentity);
            AfterDelete(deletedEntity);

            Context.SaveChanges();

            return Mapper.Map<T>(deletedEntity);
        }
    }
}
