using StudAid.Model;
using StudAid.Model.Requests;
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
    public partial class frmNewLocation : Form
    {
        public APIService LocationService { get; set; } = new APIService("Location");
        public frmNewLocation()
        {
            InitializeComponent();
        }

        private async void btnAdd_Click(object sender, EventArgs e)
        {
            if (Validate())
            {
                try
                {
                    LocationUpsertRequest insertRequest = new LocationUpsertRequest()
                    {
                        City = txtCity.Text,
                        Country = txtCountry.Text,
                    };
                   
                        var user = await LocationService.Post<Location>(insertRequest);
                        MessageBox.Show("You have successfully added a location");
                    
                }
                catch (Exception ex)
                {

                    MessageBox.Show("Something went wrong");
                }

            }
        }
        public bool Validate()
        {
            if (string.IsNullOrWhiteSpace(txtCity.Text))
            {

                txtCity.Focus();
                errorProvider.SetError(txtCity, "City name should not be left blank!");
                return false;
            }
            else
            {

                errorProvider.SetError(txtCity, "");
            }
            if (string.IsNullOrWhiteSpace(txtCountry.Text))
            {

                txtCountry.Focus();
                errorProvider.SetError(txtCountry, "Last name should not be left blank!");
                return false;
            }
            else
            {

                errorProvider.SetError(txtCountry, "");
            }
            

            return true;
        }
    }
}
