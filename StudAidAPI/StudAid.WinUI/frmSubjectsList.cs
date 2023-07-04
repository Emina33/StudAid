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
    public partial class frmSubjectsList : Form
    {
        public APIService SubjectService { get; set; } = new APIService("Subject");
        public frmSubjectsList()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns = false;
        }

        private async void btnShow_Click(object sender, EventArgs e)
        {
            var searchObject = new SubjectSearchObject();
            searchObject.SubjectName = txtSubjectName.Text;
            
            var list = await SubjectService.Get<List<Subject>>(searchObject);
            dataGridView1.DataSource = list;
        }

        
    }
}
