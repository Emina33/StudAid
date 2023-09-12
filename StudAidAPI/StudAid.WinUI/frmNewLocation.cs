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
        public APIService AppUserService { get; set; } = new APIService("AppUser");
        private Location Location = null;
        public frmNewLocation(Location location = null)
        {
            InitializeComponent();
            Location = location;
        }

        private async void btnAdd_Click(object sender, EventArgs e)
        {
            if(Location == null)
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
                        txtCity.Clear();
                        txtCountry.Clear();
                        Close();

                    }
                    catch (Exception ex)
                    {

                        MessageBox.Show("Something went wrong");
                    }

                }
            }
            else
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

                        var user = await LocationService.Put<Location>(insertRequest, Location.LocationId);
                        MessageBox.Show("You have successfully updated a location");
                        Close();

                    }
                    catch (Exception ex)
                    {

                        MessageBox.Show("Something went wrong");
                    }

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
                errorProvider.SetError(txtCountry, "Country name should not be left blank!");
                return false;
            }
            else
            {

                errorProvider.SetError(txtCountry, "");
            }
            

            return true;
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void txtCountry_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtCity_TextChanged(object sender, EventArgs e)
        {

        }

        private void frmNewLocation_Load(object sender, EventArgs e)
        {
            if (Location != null)
            {
                btnDelete.Enabled = true;
                txtCity.Text = Location.City;
                txtCountry.Text=Location.Country;

            }
        }

        private async void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                var list = await AppUserService.Get<List<AppUser>>();
                foreach (var item in list)
                {
                    if(item.LocationId == Location.LocationId)
                    {
                        MessageBox.Show("You are not allowed to delete this location!");
                        return;
                    }
                        
                }
                Location = await LocationService.Delete<Location>(Location.LocationId);
                MessageBox.Show("You have successfully deleted this location!");
                Close();
            }
            catch (Exception ex)
            {

                MessageBox.Show("Something went wrong!");
            }
        }
    }
}
