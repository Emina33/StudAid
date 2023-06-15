namespace StudAid.WinUI
{
    partial class frmAdvertsList
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
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.txtPrice = new System.Windows.Forms.TextBox();
            this.txtAdvertName = new System.Windows.Forms.TextBox();
            this.btnShow = new System.Windows.Forms.Button();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.AdvertName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AvailableTime = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Price = new System.Windows.Forms.DataGridViewTextBoxColumn();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.SuspendLayout();
            // 
            // textBox4
            // 
            this.textBox4.BackColor = System.Drawing.SystemColors.MenuBar;
            this.textBox4.BorderStyle = System.Windows.Forms.BorderStyle.None;
            this.textBox4.Enabled = false;
            this.textBox4.ForeColor = System.Drawing.SystemColors.InfoText;
            this.textBox4.Location = new System.Drawing.Point(59, 38);
            this.textBox4.Name = "textBox4";
            this.textBox4.ReadOnly = true;
            this.textBox4.Size = new System.Drawing.Size(125, 20);
            this.textBox4.TabIndex = 25;
            this.textBox4.Text = "Advert search:";
            // 
            // txtPrice
            // 
            this.txtPrice.Location = new System.Drawing.Point(260, 79);
            this.txtPrice.Name = "txtPrice";
            this.txtPrice.PlaceholderText = "Price:";
            this.txtPrice.Size = new System.Drawing.Size(179, 27);
            this.txtPrice.TabIndex = 23;
            // 
            // txtAdvertName
            // 
            this.txtAdvertName.Location = new System.Drawing.Point(59, 79);
            this.txtAdvertName.Name = "txtAdvertName";
            this.txtAdvertName.PlaceholderText = "Advert name:";
            this.txtAdvertName.Size = new System.Drawing.Size(179, 27);
            this.txtAdvertName.TabIndex = 22;
            this.txtAdvertName.Tag = "";
            // 
            // btnShow
            // 
            this.btnShow.Location = new System.Drawing.Point(472, 77);
            this.btnShow.Name = "btnShow";
            this.btnShow.Size = new System.Drawing.Size(94, 29);
            this.btnShow.TabIndex = 21;
            this.btnShow.Text = "Show";
            this.btnShow.UseVisualStyleBackColor = true;
            this.btnShow.Click += new System.EventHandler(this.btnShow_Click_1);
            // 
            // dataGridView1
            // 
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.AdvertName,
            this.AvailableTime,
            this.Price});
            this.dataGridView1.Location = new System.Drawing.Point(49, 129);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.RowHeadersWidth = 51;
            this.dataGridView1.RowTemplate.Height = 29;
            this.dataGridView1.Size = new System.Drawing.Size(703, 283);
            this.dataGridView1.TabIndex = 20;
            // 
            // AdvertName
            // 
            this.AdvertName.DataPropertyName = "AdvertName";
            this.AdvertName.HeaderText = "Advert name";
            this.AdvertName.MinimumWidth = 6;
            this.AdvertName.Name = "AdvertName";
            this.AdvertName.Width = 260;
            // 
            // AvailableTime
            // 
            this.AvailableTime.DataPropertyName = "AvailableTime";
            this.AvailableTime.HeaderText = "Available time";
            this.AvailableTime.MinimumWidth = 6;
            this.AvailableTime.Name = "AvailableTime";
            this.AvailableTime.Width = 200;
            // 
            // Price
            // 
            this.Price.DataPropertyName = "Price";
            this.Price.HeaderText = "Price";
            this.Price.MinimumWidth = 6;
            this.Price.Name = "Price";
            this.Price.Width = 200;
            // 
            // frmAdvertsList
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 20F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.textBox4);
            this.Controls.Add(this.txtPrice);
            this.Controls.Add(this.txtAdvertName);
            this.Controls.Add(this.btnShow);
            this.Controls.Add(this.dataGridView1);
            this.Name = "frmAdvertsList";
            this.Text = "frmAdvertsList";
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private TextBox textBox4;
        private TextBox txtPrice;
        private TextBox txtAdvertName;
        private Button btnShow;
        private DataGridView dataGridView1;
        private DataGridViewTextBoxColumn AdvertName;
        private DataGridViewTextBoxColumn AvailableTime;
        private DataGridViewTextBoxColumn Price;
    }
}