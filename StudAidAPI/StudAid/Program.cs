using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using StudAid.Filters;
using StudAid.Model.SearchObjects;
using StudAid.Services;
using StudAid.Services.AdvertStateMachine;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });

    c.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference { Type = ReferenceType.SecurityScheme, Id = "basicAuth" }
            },
            new string[]{}
        }
    });
});

builder.Services.AddTransient<IAppUserService, AppUserService>();
//builder.Services.AddTransient<IService<StudAid.Model.Category, CategorySearchObject>, BaseService<StudAid.Model.Category, Category, CategorySearchObject>>();
builder.Services.AddTransient<IAdvertService, AdvertService>();
builder.Services.AddTransient<ICategoryService, CategoryService>();
builder.Services.AddTransient<ISubjectService, SubjectService>();
builder.Services.AddTransient<IDocumentService, DocumentService>();
builder.Services.AddTransient<ILocationService, LocationService>();
builder.Services.AddTransient<IReservationService, ReservationService>();
builder.Services.AddTransient<IReviewService, ReviewService>();
builder.Services.AddTransient<IPaymentService, PaymentService>();
builder.Services.AddTransient<IMessageService, MessageService>();

builder.Services.AddTransient<BaseState>();
builder.Services.AddTransient<InitialAdvertState>();
builder.Services.AddTransient<DraftAdvertState>();
builder.Services.AddTransient<ActiveAdvertState>();

builder.Services.AddAutoMapper(typeof(IAppUserService));

builder.Services.AddAuthentication("BasicAuthentication").AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

builder.Services.AddDbContext<stud_aid2Context>(options => options.UseSqlServer(builder.Configuration.GetConnectionString("stud_aid2")));
var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    //app.UseDeveloperExceptionPage();
    app.UseSwagger();
    app.UseSwaggerUI();
}


//app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();
using (var scope = app.Services.CreateScope())
{
    var dataContext = scope.ServiceProvider.GetRequiredService<stud_aid2Context>();
    dataContext.Database.Migrate();
}

app.Run();
