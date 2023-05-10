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
            if(User != null)
            {
                txtFirstName.Text = User.FirstName;
                txtLastName.Text = User.LastName;
                txtUsername.Text = User.Username;
                txtRole.Text = User.Role;
            }
        }

        private async void btnSave_Click(object sender, EventArgs e)
        {
            if(ValidateChildren())
            {
                if (User == null)
                {
                    AppUserInsertRequest insertRequest = new AppUserInsertRequest()
                    {
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Username = txtUsername.Text,
                        Role = txtRole.Text,
                        Password = txtPass.Text
                    };
                    if (txtPass.Text == txtConfirmPass.Text)
                    {
                        var user = await AppUserService.Post<AppUser>(insertRequest);
                    }
                }
                else
                {
                    AppUserInsertRequest updateRequest = new AppUserInsertRequest()
                    {
                        FirstName = txtFirstName.Text,
                        LastName = txtLastName.Text,
                        Role = txtRole.Text,
                        Username = txtUsername.Text,
                        //Password = txtPass.Text
                    };
                    User = await AppUserService.Put<AppUser>(User.UserId, updateRequest);
                }
            }
            
           
            
            
        }

        private void txtFirstName_Validating(object sender, CancelEventArgs e)
        {
            if (string.IsNullOrWhiteSpace(txtFirstName.Text))
            {
                e.Cancel = true;
                txtFirstName.Focus();
                errorProvider.SetError(txtFirstName, "Name should not be left blank!");
            }
            else
            {
                e.Cancel = false;
                errorProvider.SetError(txtFirstName, "");
            }
        }
    }
}
