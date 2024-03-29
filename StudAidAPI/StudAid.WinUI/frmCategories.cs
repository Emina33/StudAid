﻿using StudAid.Model;
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
    public partial class frmCategories : Form
    {
        public APIService CategoryService { get; set; } = new APIService("Category");
        public frmCategories()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns = false;
        }

        private async void btnShow_Click(object sender, EventArgs e)
        {
            var searchObject = new CategorySearchObject();
            searchObject.CategoryName = txtCategoryName.Text;

            var list = await CategoryService.Get<List<Category>>(searchObject);
            dataGridView1.DataSource = list;
        }

        private async void frmCategories_Load(object sender, EventArgs e)
        {
            var list = await CategoryService.Get<List<Category>>();
            dataGridView1.DataSource = list;
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            var item = dataGridView1.SelectedRows[0].DataBoundItem as Category;
            frmNewCategory frm = new frmNewCategory(item);
            frm.ShowDialog();
        }
    }
}
