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
                
                txtCategory.Text = Category.CategoryName;

            }
        }
    }
}
