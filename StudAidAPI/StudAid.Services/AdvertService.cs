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
            
        }
        public override Model.Advert Insert(AdvertInsertRequest insert)
        {
            var state = BaseState.CreateState("initial");
            return state.Insert(insert);
        }

        public override Model.Advert Update(int id, AdvertUpdateRequest update)
        {
            
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




        static object isLocked = new object();
        static MLContext mlContext = null;
        static ITransformer model = null;
       

        public List<Model.Advert> Recommend(int id)
        {
            


            var allAdverts = Context.Adverts.ToList();
            var trainedModel = ModelTrainer(id);

            var predictionResult = new List<Tuple<Advert, float>>();
            foreach (var advert in allAdverts)
            {

                if (advert.SubjectId != null && advert.Tutor != null && mlContext != null && trainedModel != null)
                {
                var predictionEngine = mlContext.Model.CreatePredictionEngine<ReservationEntry, PredictionLevel>(trainedModel);

                var prediction = predictionEngine.Predict(new ReservationEntry()
                {
                    UserID = (uint)id,
                    AdvertID = (uint)advert.AdvertId,
                    SubjectId = (uint)advert.SubjectId,
                    TutorId = (uint)advert.Tutor,
                });
                predictionResult.Add(new Tuple<Advert, float>(advert, prediction.Score));

                }
                else
                {
                    predictionResult.Add(new Tuple<Advert, float>(advert, 0));
                }
            }

            

            var finalResult = predictionResult?.OrderByDescending(o => o.Item2).Select(s => s.Item1).ToList();

            return Mapper.Map<List<Model.Advert>>(finalResult);
        }

        public ITransformer ModelTrainer(int id)
        {
            lock (isLocked)
            {
                if (mlContext == null)
                {
                    mlContext = new MLContext();


                    var allAdverts = Context.Adverts.ToList();

                    var reservations = Context.Reservations.ToList();

                    var data = new List<ReservationEntry>();

                    foreach (var advert in allAdverts)
                    {
                        foreach (var reservation in reservations)
                        {
                            if (advert.AdvertId == reservation.AdvertId && advert.Tutor != null && advert.SubjectId != null)
                            {
                                data.Add(new ReservationEntry()
                                {
                                    UserID = (uint)reservation.UserId,
                                    AdvertID = (uint)reservation.AdvertId,
                                    SubjectId = (uint)advert.SubjectId,
                                    TutorId = (uint)advert.Tutor,

                                });
                            }

                        }





                    }



                    var trainData = mlContext.Data.LoadFromEnumerable(data);

                    MatrixFactorizationTrainer.Options options = new()
                    {
                        MatrixColumnIndexColumnName = nameof(ReservationEntry.UserID),
                        MatrixRowIndexColumnName = nameof(ReservationEntry.AdvertID),
                        LabelColumnName = "Label",
                        LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                        Alpha = 0.01,
                        Lambda = 0.025
                    };


                    var est = mlContext.Recommendation().Trainers.MatrixFactorization(options);

                    model = est.Fit(trainData);
                }
                if (model != null)
                    return model;
                else
                    return null;
            }


        }
    }
    public class PredictionLevel
    {
        public float Score { get; set; }
    }

    public class ReservationEntry
    {
        [KeyType(count: 10)]
        public uint AdvertID { get; set; }

        [KeyType(count: 10)]
        public uint UserID { get; set; }
        public uint SubjectId { get; set; }
        public uint TutorId { get; set; }
        public float Label { get; set; }
    }
}
   

