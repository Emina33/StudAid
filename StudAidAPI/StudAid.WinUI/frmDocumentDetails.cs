using StudAid.Model;
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
    public partial class frmDocumentDetails : Form
    {
        public APIService DocumentService { get; set; } = new APIService("Document");
        private Document Document = null;
        public frmDocumentDetails(Document document = null)
        {
            InitializeComponent();
            Document = document;
        }

        private async void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                Document = await DocumentService.Delete<Document>(Document.DocumentId);
            }
            catch (Exception ex)
            {

                MessageBox.Show("Something went wrong");
            }
        }

        private void frmDocumentDetails_Load(object sender, EventArgs e)
        {
            if (Document != null)
            {
                txtDocumentName.Text = Document.DocumentName;
                txtAuthor.Text = Document.Author;
                txtDescription.Text = Document.Description;
                

            }
        }
    }
}
