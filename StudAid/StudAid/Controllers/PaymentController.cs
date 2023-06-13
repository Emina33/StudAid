using StudAid.Model.Requests;
using StudAid.Model.SearchObjects;
using StudAid.Services;

namespace StudAid.Controllers
{
    public class PaymentController:BaseCRUDController<Model.Payment, PaymentSearchObject, PaymentInsertRequest, PaymentInsertRequest>
    {
        public PaymentController(IPaymentService service)
        : base(service) { }
    }
}
