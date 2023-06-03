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
    public class AppUserService : BaseCRUDService<Model.AppUser, AppUser, AppUserSearchObject,AppUserInsertRequest, AppUserUpdateRequest>, IAppUserService
    {
        //public studAidDbContext Context { get; set; }
        //public IMapper Mapper { get; set; }
        public AppUserService(stud_aid2Context context, IMapper mapper)
            :base(context,mapper)
        {
            //Context = context;
            //Mapper = mapper;
        }
        public override Model.AppUser Insert(AppUserInsertRequest insert)
        {
            //zakomentarisano za vise v vise vezu
            //if (insert.Password != insert.PasswordPotvrda)
            //{
            //    throw new UserException("Password and confirmation must be the same");
            //}

            var entity = base.Insert(insert);


            //foreach (var ulogaId in insert.UlogeIdList)
            //{
            //    Database.KorisniciUloge korisniciUloge = new Database.KorisniciUloge();
            //    korisniciUloge.UlogaId = ulogaId;
            //    korisniciUloge.KorisnikId = entity.KorisnikId;
            //    korisniciUloge.DatumIzmjene = DateTime.Now;

            //    Context.KorisniciUloges.Add(korisniciUloge);
            //}

            //Context.SaveChanges();

            return entity;
        }
        public override Model.AppUser Update(int id, AppUserUpdateRequest update)
        {
           
            var entity = base.Update(id,update);


           

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
            //RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            //var byteArray = new byte[16];
            //provider.GetBytes(byteArray);


            //return Convert.ToBase64String(byteArray);
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
            if(entity == null)
            {
                return null;
            }
           
            var hash = GenerateHash(entity.PasswordSalt, password);
            if(hash != entity.Password)
            {
                return null;
            }
            return Mapper.Map<Model.AppUser>(entity);
        }
        static object isLocked = new object();
        static MLContext mLContext = null;
        static ITransformer model = null;
        public List<Model.Advert> Recommend(int id)
        {
            lock (isLocked)
            {
                if (mLContext == null)
                {
                    mLContext = new MLContext();
                    var tmpData = Context.Reservations.ToList();
                    var data = new List<AdvertEntry>();
                    foreach (var item in tmpData)
                    {
                        data.Add(new AdvertEntry()
                        {
                            AdvertID = (uint)item.AdvertId,
                            UserID = (uint)item.UserId
                        });
                    }
                    var traindata = mLContext.Data.LoadFromEnumerable(data);
                    //STEP 3: Your data is already encoded so all you need to do is specify options for MatrxiFactorizationTrainer with a few extra hyperparameters
                    //        LossFunction, Alpa, Lambda and a few others like K and C as shown below and call the trainer.
                    MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
                    options.MatrixColumnIndexColumnName = nameof(AdvertEntry.AdvertID);
                    options.MatrixRowIndexColumnName = nameof(AdvertEntry.UserID);
                    options.LabelColumnName = "Label";
                    options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
                    options.Alpha = 0.01;
                    options.Lambda = 0.025;
                    // For better results use the following parameters
                    options.NumberOfIterations = 100;
                    options.C = 0.00001;


                    var est = mLContext.Recommendation().Trainers.MatrixFactorization(options);


                    model = est.Fit(traindata);
                }
            }

            var allItems = Context.Adverts.Where(x => x.AdvertId != id);
            var predictionResult = new List<Tuple<Advert, float>>();
            foreach (var item in allItems)
            {
                var predictionEngine = mLContext.Model.CreatePredictionEngine<AdvertEntry, PredictionLevel>(model);
                var prediction = predictionEngine.Predict(new AdvertEntry()
                {
                    UserID = (uint)id,
                    AdvertID = (uint)item.AdvertId
                });
                predictionResult.Add(new Tuple<Advert, float>(item, prediction.Score));
            }
            var finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1).Take(3).ToList();

            return Mapper.Map<List<Model.Advert>>(finalResult);
        }

        //public IEnumerable<Model.AppUser> Get()
        //{

        //    var result = Context.AppUsers.ToList();

        //    return Mapper.Map<List<Model.AppUser>>(result);
        //}

        //public Model.AppUser GetById(int id)
        //{
        //    var result = Context.AppUsers.Find(id);
        //    return Mapper.Map<Model.AppUser>(result);
        //}
    }
    public class PredictionLevel
    {
        public float Score { get; set; }
    }

    public class AdvertEntry
    {
        [KeyType(count: 10)]
        public uint AdvertID { get; set; }

        [KeyType(count: 10)]
        public uint UserID { get; set; }

        public float Label { get; set; }
    }
}
