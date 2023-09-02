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
    public partial class frmLocationsList : Form
    {
        public APIService LocationService { get; set; } = new APIService("Location");
        public frmLocationsList()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns = false;
        }

        private async void btnShow_Click(object sender, EventArgs e)
        {
            var searchObject = new LocationSearchObject();
            searchObject.City = txtCity.Text;
            searchObject.Country = txtCountry.Text;
            var list = await LocationService.Get<List<Location>>(searchObject);
            dataGridView1.DataSource = list;
        }

        private async void frmLocationsList_Load(object sender, EventArgs e)
        {
            var list = await LocationService.Get<List<Location>>();
            dataGridView1.DataSource = list;
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            var item = dataGridView1.SelectedRows[0].DataBoundItem as Location;
            frmNewLocation frm = new frmNewLocation(item);
            frm.ShowDialog();
        }
    }
}
