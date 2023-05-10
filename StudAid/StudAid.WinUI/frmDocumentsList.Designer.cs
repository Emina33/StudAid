namespace StudAid.WinUI
{
    partial class frmDocumentsList
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.button2 = new System.Windows.Forms.Button();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.txtAuthor = new System.Windows.Forms.TextBox();
            this.txtSubject = new System.Windows.Forms.TextBox();
            this.txtDocumentName = new System.Windows.Forms.TextBox();
            this.btnShow = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.DocumentName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Author = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.SubjectName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(658, 409);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(94, 29);
            this.button2.TabIndex = 20;
            this.button2.Text = "Add document";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // textBox4
            // 
            this.textBox4.BackColor = System.Drawing.SystemColors.MenuBar;
            this.textBox4.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBox4.Enabled = false;
            this.textBox4.ForeColor = System.Drawing.SystemColors.InfoText;
            this.textBox4.Location = new System.Drawing.Point(59, 12);
            this.textBox4.Name = "textBox4";
            this.textBox4.ReadOnly = true;
            this.textBox4.Size = new System.Drawing.Size(125, 20);
            this.textBox4.TabIndex = 19;
            this.textBox4.Text = "Document search:";
            this.textBox4.TextChanged += new System.EventHandler(this.textBox4_TextChanged);
            // 
            // txtAuthor
            // 
            this.txtAuthor.Location = new System.Drawing.Point(459, 53);
            this.txtAuthor.Name = "txtAuthor";
            this.txtAuthor.PlaceholderText = "Author:";
            this.txtAuthor.Size = new System.Drawing.Size(179, 27);
            this.txtAuthor.TabIndex = 18;
            this.txtAuthor.TextChanged += new System.EventHandler(this.textBox3_TextChanged);
            // 
            // txtSubject
            // 
            this.txtSubject.Location = new System.Drawing.Point(260, 53);
            this.txtSubject.Name = "txtSubject";
            this.txtSubject.PlaceholderText = "Subject:";
            this.txtSubject.Size = new System.Drawing.Size(179, 27);
            this.txtSubject.TabIndex = 17;
            this.txtSubject.TextChanged += new System.EventHandler(this.textBox2_TextChanged);
            // 
            // txtDocumentName
            // 
            this.txtDocumentName.Location = new System.Drawing.Point(59, 53);
            this.txtDocumentName.Name = "txtDocumentName";
            this.txtDocumentName.PlaceholderText = "Document name:";
            this.txtDocumentName.Size = new System.Drawing.Size(179, 27);
            this.txtDocumentName.TabIndex = 16;
            this.txtDocumentName.Tag = "";
            this.txtDocumentName.TextChanged += new System.EventHandler(this.textBox1_TextChanged);
            // 
            // btnShow
            // 
            this.btnShow.Location = new System.Drawing.Point(658, 51);
            this.btnShow.Name = "btnShow";
            this.btnShow.Size = new System.Drawing.Size(94, 29);
            this.btnShow.TabIndex = 15;
            this.btnShow.Text = "Show";
            this.btnShow.UseVisualStyleBackColor = true;
            this.btnShow.Click += new System.EventHandler(this.btnShow_Click);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.DocumentName,
            this.Author,
            this.SubjectName});
            this.dataGridView1.Location = new System.Drawing.Point(49, 103);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 29;
            this.dataGridView1.Size = new System.Drawing.Size(703, 283);
            this.dataGridView1.TabIndex = 14;
            this.dataGridView1.CellContentClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentClick);
            // 
            // DocumentName
            // 
            this.DocumentName.DataPropertyName = "DocumentName";
            this.DocumentName.HeaderText = "Document name";
            this.DocumentName.MinimumWidth = 6;
            this.DocumentName.Name = "DocumentName";
            this.DocumentName.Width = 260;
            // 
            // Author
            // 
            this.Author.DataPropertyName = "Author";
            this.Author.HeaderText = "Author";
            this.Author.MinimumWidth = 6;
            this.Author.Name = "Author";
            this.Author.Width = 200;
            // 
            // SubjectName
            // 
            this.SubjectName.DataPropertyName = "NameSubject";
            this.SubjectName.HeaderText = "Subject";
            this.SubjectName.MinimumWidth = 6;
            this.SubjectName.Name = "SubjectName";
            this.SubjectName.Width = 200;
            // 
            // frmDocumentsList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.textBox4);
            this.Controls.Add(this.txtAuthor);
            this.Controls.Add(this.txtSubject);
            this.Controls.Add(this.txtDocumentName);
            this.Controls.Add(this.btnShow);
            this.Controls.Add(this.dataGridView1);
            this.Name = "frmDocumentsList";
            this.Text = "frmDocumentsList";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private Button button2;
        private TextBox textBox4;
        private TextBox txtAuthor;
        private TextBox txtSubject;
        private TextBox txtDocumentName;
        private Button btnShow;
        private DataGridView dataGridView1;
        private DataGridViewTextBoxColumn DocumentName;
        private DataGridViewTextBoxColumn Author;
        private DataGridViewTextBoxColumn SubjectName;
    }
}