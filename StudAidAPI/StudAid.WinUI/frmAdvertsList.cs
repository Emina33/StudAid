using StudAid.Model;
using StudAid.Model.SearchObjects;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace StudAid.WinUI
{
    public partial class frmAdvertsList : Form
    {
        public APIService AdvertService { get; set; } = new APIService("Advert");
        public APIService AppUserService { get; set; } = new APIService("AppUser");
        public frmAdvertsList()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns = false;
        }

        private async void btnShow_Click_1(object sender, EventArgs e)
        {
            int a;

            var searchObject = new AdvertSearchObject();
            if (txtPrice.Text != "" && int.TryParse(txtPrice.Text,out a) == true )
                searchObject.Price = a;
            searchObject.AdvertName = txtAdvertName.Text;
            var list = new List<Record>();
            var adverts = await AdvertService.Get<List<Advert>>(searchObject);
            var users = await AppUserService.Get<List<AppUser>>(searchObject);
            foreach (var advert in adverts)
            {
                foreach (var user in users)
                {
                    if (advert.Tutor == user.UserId)
                    {
                        list.Add(new Record() { AdvertName=advert.AdvertName, AvailableTime= advert.AvailableTime, Price= advert.Price, Tutor= user.FirstName + " " + user.LastName });
                    }

                }
            }

            dataGridView1.DataSource = list;
        }

        private async void frmAdvertsList_Load(object sender, EventArgs e)
        {
            var list = new List<Record>();
            var adverts = await AdvertService.Get<List<Advert>>();
            var users = await AppUserService.Get<List<AppUser>>();
            foreach (var advert in adverts)
            {
                foreach (var user in users)
                {
                    if (advert.Tutor == user.UserId)
                    {
                        list.Add(new Record() { AdvertName = advert.AdvertName, AvailableTime = advert.AvailableTime, Price = advert.Price, Tutor = user.FirstName + " " + user.LastName });
                    }

                }
            }

            dataGridView1.DataSource = list;
        }
    }
}
public class Record : Object
{
    public string AdvertName { get; set; }

    public string AvailableTime { get; set; }
    public double? Price { get; set; }

    public string Tutor { get; set; }

    
}