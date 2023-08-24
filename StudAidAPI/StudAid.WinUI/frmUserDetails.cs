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
    public partial class frmUserDetails : Form
    {
        public APIService AppUserService { get; set; } = new APIService("AppUser");
        private AppUser User = null;
        public frmUserDetails(AppUser user = null)
        {
            InitializeComponent();
            User = user;
        }

        private void frmUserDetails_Load(object sender, EventArgs e)
        {
            string[] items = {
        "admin",
        "basic user"
    };
            cmbRole.Items.AddRange(items);
            cmbRole.SelectedIndex = 1;
            if (User != null)
            {
                txtFirstName.Text = User.FirstName;
                txtLastName.Text = User.LastName;
                txtUsername.Text = User.Username;
                txtUsername.Enabled = false;

                if (User.Role == "basic user")
                    cmbRole.SelectedIndex = 1;
                else
                    cmbRole.SelectedIndex = 0;
                txtDescription.Text = User.Description;
                
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            
                if (User == null)
                {
                
                if (Validate())
                    { 
                        try
                        {
                            AppUserInsertRequest insertRequest = new AppUserInsertRequest()
                            {
                                FirstName = txtFirstName.Text,
                                LastName = txtLastName.Text,
                                Username = txtUsername.Text,
                                Role = cmbRole.SelectedItem as string,
                                Password = txtPass.Text,
                                LocationId = 11,
                                Description = txtDescription.Text,
                            };
                            if (txtPass.Text == txtConfirmPass.Text)
                            {
                                var user = await AppUserService.Post<AppUser>(insertRequest);
                            txtFirstName.Clear();
                            txtLastName.Clear();
                            txtUsername.Clear();
                            txtPass.Clear();
                            txtConfirmPass.Clear();
                            txtDescription.Clear();
                            cmbRole.SelectedIndex = 1;
                            MessageBox.Show("You have successfully added a user");
                            }
                        }
                        catch (Exception ex)
                        {

                            MessageBox.Show("Something went wrong");
                        }
                        
                    }
                   
                }
                else
                {
                    if(Validate())
                    {
                        try
                        {
                            AppUserUpdateRequest updateRequest = new AppUserUpdateRequest()
                            {
                                FirstName = txtFirstName.Text,
                                LastName = txtLastName.Text,
                                Role = cmbRole.SelectedItem as string,
                                Password = txtPass.Text,
                                LocationId = 11,
                                Description = txtDescription.Text,
                                ProfilePicture = User.ProfilePicture,
                            };
                            User = await AppUserService.Put<AppUser>(updateRequest, User.UserId);
                            MessageBox.Show("You have successfully updated a user");
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
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                
                txtFirstName.Focus();
                errorProvider.SetError(txtFirstName, "First name should not be left blank!");
                return false;
            }
            else
            {
                
                errorProvider.SetError(txtFirstName, "");
            }
            if (string.IsNullOrWhiteSpace(txtLastName.Text))
            {

                txtLastName.Focus();
                errorProvider.SetError(txtLastName, "Last name should not be left blank!");
                return false;
            }
            else
            {
               
                errorProvider.SetError(txtLastName, "");
            }
            if (string.IsNullOrWhiteSpace(txtUsername.Text))
            {

                txtUsername.Focus();
                errorProvider.SetError(txtUsername, "Username should not be left blank!");
                return false;
            }
            else
            {
                
                errorProvider.SetError(txtUsername, "");
            }
            if (string.IsNullOrWhiteSpace(txtPass.Text))
            {

                txtPass.Focus();
                errorProvider.SetError(txtPass, "Password should not be left blank!");
                return false;
            }
            else
            {
                
                errorProvider.SetError(txtPass, "");
            }
            if (txtPass.Text != txtConfirmPass.Text)
            {

                txtConfirmPass.Focus();
                errorProvider.SetError(txtPass, "Passwords should match!");
                errorProvider.SetError(txtConfirmPass, "Passwords should match!");
                return false;
            }
            else
            {

                errorProvider.SetError(txtPass, "");
                errorProvider.SetError(txtConfirmPass, "");
            }
            if (string.IsNullOrWhiteSpace(txtDescription.Text))
            {

                txtDescription.Focus();
                errorProvider.SetError(txtDescription, "Description should not be left blank!");
                return false;
            }
            else
            {
                
                errorProvider.SetError(txtDescription, "");
            }
            

            return true;
        }

        private void cmbRole_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
