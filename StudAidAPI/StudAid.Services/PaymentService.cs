using AutoMapper;
using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudAid.Services
{
    public class PaymentService:BaseCRUDService<Model.Payment, Payment, PaymentSearchObject, PaymentInsertRequest, PaymentInsertRequest>, IPaymentService
    {
        public PaymentService(stud_aid2Context context, IMapper mapper)
           : base(context, mapper)
        {

        }
        public override IQueryable<Payment> AddFilter(IQueryable<Payment> query, PaymentSearchObject search = null)
        {
            var filteredQuery = base.AddFilter(query, search);


            return filteredQuery;
        }
    }
}
