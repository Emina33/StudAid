using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Flurl;
using Flurl.Http;
using StudAid.Model;
using StudAid.Model.SearchObjects;

namespace StudAid.WinUI
{
    public partial class frmUsersList : Form
    {
        public APIService AppUserService { get; set; } = new APIService("AppUser");
        public frmUsersList()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns = false;
        }

        private async void btnShow_Click(object sender, EventArgs e)
        {
 
            var searchObject = new AppUserSearchObject();
            searchObject.FirstName = txtFirstName.Text;
            searchObject.LastName = txtLastName.Text;
            searchObject.Username = txtUsername.Text;
            var list = await AppUserService.Get<List<AppUser>>(searchObject);
            dataGridView1.DataSource = list;
        }


        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            var item = dataGridView1.SelectedRows[0].DataBoundItem as AppUser;
            frmUserDetails frm = new frmUserDetails(item);
            frm.ShowDialog();
        }
    }
}
