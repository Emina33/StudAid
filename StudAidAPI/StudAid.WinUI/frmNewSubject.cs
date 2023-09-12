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
        public APIService AdvertService { get; set; } = new APIService("Advert");
        public APIService DocumentService { get; set; } = new APIService("Document");
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
                            CategoryId = cmbCategories.SelectedIndex+1,
                        };

                        var user = await SubjectService.Post<Subject>(insertRequest);
                        MessageBox.Show("You have successfully added a subject");
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
                        SubjectUpsertRequest insertRequest = new SubjectUpsertRequest()
                        {
                            SubjectName = txtSubject.Text,
                            CategoryId = (int)cmbCategories.SelectedIndex+1,
                        };

                        var user = await SubjectService.Put<Subject>(insertRequest, Subject.SubjectId);
                        MessageBox.Show("You have successfully updated a subject");
                        Close();

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
                btnDelete.Enabled = true;
                cmbCategories.SelectedIndex = (int)Subject.CategoryId-1;
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

        private async void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                var documents = await DocumentService.Get<List<Document>>();
                foreach (var item in documents)
                {
                    if (item.SubjectId == Subject.SubjectId)
                    {
                        MessageBox.Show("This subject is in use!");
                        return;
                    }

                }
                var adverts = await AdvertService.Get<List<Advert>>();
                foreach (var item in adverts)
                {
                    if (item.SubjectId == Subject.SubjectId)
                    {
                        MessageBox.Show("This subject is in use!");
                        return;
                    }

                }
                Subject = await SubjectService.Delete<Subject>(Subject.SubjectId);
                MessageBox.Show("You have successfully deleted this subject!");
                Close();
            }
            catch (Exception ex)
            {

                MessageBox.Show("Something went wrong!");
            }
        }
    }
}
