using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using Microsoft.ML.Data;
using Microsoft.ML.Trainers;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class AppUserService : BaseCRUDService<Model.AppUser, AppUser, AppUserSearchObject, AppUserInsertRequest, AppUserUpdateRequest>, IAppUserService
    {
    
        public AppUserService(stud_aid2Context context, IMapper mapper)
            : base(context, mapper)
        {
      
        }
        public override Model.AppUser Insert(AppUserInsertRequest insert)
        {
           

            var entity = base.Insert(insert);


           

            return entity;
        }
        public override Model.AppUser Update(int id, AppUserUpdateRequest update)
        {

            var entity = base.Update(id, update);




            return entity;
        }
        public override void BeforeInsert(AppUserInsertRequest insert, AppUser entity)
        {
            var salt = GenerateSalt();
            entity.PasswordSalt = salt;
            entity.Password = GenerateHash(salt, insert.Password);
            base.BeforeInsert(insert, entity);
        }
        public override void BeforeUpdate(AppUserUpdateRequest update, AppUser entity)
        {
            var salt = GenerateSalt();
            entity.PasswordSalt = salt;
            entity.Password = GenerateHash(salt, update.Password);
            base.BeforeUpdate(update, entity);
        }
        public static string GenerateSalt()
        {
        
            return Convert.ToBase64String(new byte[16]);
        }
        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public override IQueryable<AppUser> AddFilter(IQueryable<AppUser> query, AppUserSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);

            if (!string.IsNullOrWhiteSpace(search?.FirstName))
            {
                filteredQuery = filteredQuery.Where(s => s.FirstName.Contains(search.FirstName));
            }
            if (!string.IsNullOrWhiteSpace(search?.LastName))
            {
                filteredQuery = filteredQuery.Where(s => s.LastName.Contains(search.LastName));
            }
            if (!string.IsNullOrWhiteSpace(search?.Username))
            {
                filteredQuery = filteredQuery.Where(s => s.Username.Contains(search.Username));
            }
            return filteredQuery;
        }

        public Model.AppUser Login(string username, string password)
        {
            var entity = Context.AppUsers.FirstOrDefault(x => x.Username == username);
            if (entity == null)
            {
                return null;
            }

            var hash = GenerateHash(entity.PasswordSalt, password);
            if (hash != entity.Password)
            {
                return null;
            }
            return Mapper.Map<Model.AppUser>(entity);
        }
       
    }
}
