using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Flurl;
using Flurl.Http;
using StudAid.Model;
using StudAid.Model.SearchObjects;

namespace StudAid.WinUI
{
    public partial class frmDocumentsList : Form
    {
        public APIService DocumentService { get; set; } = new APIService("Document");
        public frmDocumentsList()
        {
            InitializeComponent();
            dataGridView1.AutoGenerateColumns=false;
        }

        private async void btnShow_Click(object sender, EventArgs e)
        {
            var searchObject = new DocumentSearchObject();
            searchObject.DocumentName = txtDocumentName.Text;
            searchObject.Author = txtAuthor.Text;
            var list = await DocumentService.Get<List<Document>>(searchObject);
            dataGridView1.DataSource=list;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            var item = dataGridView1.SelectedRows[0].DataBoundItem as Document;
            frmDocumentDetails frm = new frmDocumentDetails(item);
            frm.ShowDialog();
        }

        private void txtAuthor_TextChanged(object sender, EventArgs e)
        {

        }

        private void txtDocumentName_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
