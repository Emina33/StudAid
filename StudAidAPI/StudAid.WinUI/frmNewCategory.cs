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
    public partial class frmNewCategory : Form
    {
        public APIService CategoryService { get; set; } = new APIService("Category");
        public APIService SubjectService { get; set; } = new APIService("Subject");
        private Category Category = null;
        public frmNewCategory(Category category=null)
        {
            
            InitializeComponent();
            Category = category;
        }

        private async void btnAdd_Click(object sender, EventArgs e)
        {
            if(Category == null)
            {
                if (Validate())
                            {
                                try
                                {
                                    CategoryInsertRequest insertRequest = new CategoryInsertRequest()
                                    {
                                        CategoryName = txtCategory.Text
                                    };

                                    var user = await CategoryService.Post<Category>(insertRequest);
                                    MessageBox.Show("You have successfully added a category");
                                    txtCategory.Clear();
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
                        CategoryInsertRequest insertRequest = new CategoryInsertRequest()
                        {
                            CategoryName = txtCategory.Text
                        };

                        var user = await CategoryService.Put<Category>(insertRequest, Category.CategoryId);
                        MessageBox.Show("You have successfully updated a category");
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
            if (string.IsNullOrWhiteSpace(txtCategory.Text))
            {

                txtCategory.Focus();
                errorProvider1.SetError(txtCategory, "Category name should not be left blank!");
                return false;
            }
            else
            {

                errorProvider1.SetError(txtCategory, "");
            }


            return true;
        }

        private void frmNewCategory_Load(object sender, EventArgs e)
        {
            if (Category != null)
            {
                btnDelete.Enabled = true;
                txtCategory.Text = Category.CategoryName;

            }
        }

        private async void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                var list = await SubjectService.Get<List<Subject>>();
                foreach (var item in list)
                {
                    if (item.CategoryId == Category.CategoryId)
                    {
                        MessageBox.Show("This category is in use!");
                        return;
                    }

                }
                Category = await CategoryService.Delete<Category>(Category.CategoryId);
                MessageBox.Show("You have successfully deleted this category!");
                Close();
            }
            catch (Exception ex)
            {

                MessageBox.Show("Something went wrong!");
            }
        }
    }
}
