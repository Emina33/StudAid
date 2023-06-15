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
            
            var list = await AdvertService.Get<List<Advert>>(searchObject);
            dataGridView1.DataSource = list;
        }
    }
}
