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
    public partial class frmNewSubject : Form
    {
        public APIService CategoryService { get; set; } = new APIService("Category");
        public APIService SubjectService { get; set; } = new APIService("Subject");
        private Subject Subject = null;
        public frmNewSubject(Subject subject = null)
        {
            InitializeComponent();
            Subject = subject;
        }

        private async void btnAdd_Click(object sender, EventArgs e)
        {
            if(Subject == null)
            {
                if (Validate())
                {
                    try
                    {
                        SubjectUpsertRequest insertRequest = new SubjectUpsertRequest()
                        {
                            SubjectName = txtSubject.Text,
                            CategoryId = cmbCategories.SelectedIndex,
                        };

                        var user = await SubjectService.Post<Subject>(insertRequest);
                        MessageBox.Show("You have successfully added a subject");

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
                        SubjectUpsertRequest insertRequest = new SubjectUpsertRequest()
                        {
                            SubjectName = txtSubject.Text,
                            CategoryId = cmbCategories.SelectedIndex,
                        };

                        var user = await SubjectService.Put<Subject>(insertRequest, Subject.SubjectId);
                        MessageBox.Show("You have successfully updated a subject");

                    }
                    catch (Exception ex)
                    {

                        MessageBox.Show("Something went wrong");
                    }

                }
            }
            
        }

        private async void frmNewSubject_Load(object sender, EventArgs e)
        {
            var list = await CategoryService.Get<List<Category>>();
            cmbCategories.DataSource = list;
            cmbCategories.DisplayMember = "categoryName";
            cmbCategories.ValueMember = "categoryId";
            if(Subject != null)
            {
                cmbCategories.SelectedIndex = (int)Subject.CategoryId;
                txtSubject.Text = Subject.SubjectName;
            }
        }
        public bool Validate()
        {
            if (string.IsNullOrWhiteSpace(txtSubject.Text))
            {

                txtSubject.Focus();
                errorProvider.SetError(txtSubject, "Subject name should not be left blank!");
                return false;
            }
            else
            {

                errorProvider.SetError(txtSubject, "");
            }
            

            return true;
        }
    }
}
