namespace Papema
{
    partial class VerProvedores
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle1 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(VerProvedores));
            this.gridProvedores = new System.Windows.Forms.DataGridView();
            ((System.ComponentModel.ISupportInitialize)(this.gridProvedores)).BeginInit();
            this.SuspendLayout();
            // 
            // gridProvedores
            // 
            this.gridProvedores.AllowUserToAddRows = false;
            this.gridProvedores.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.CadetBlue;
            this.gridProvedores.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.gridProvedores.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.gridProvedores.BackgroundColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.gridProvedores.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridProvedores.Location = new System.Drawing.Point(12, 12);
            this.gridProvedores.Name = "gridProvedores";
            this.gridProvedores.ReadOnly = true;
            this.gridProvedores.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridProvedores.Size = new System.Drawing.Size(717, 244);
            this.gridProvedores.TabIndex = 0;
            // 
            // VerProvedores
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(745, 268);
            this.Controls.Add(this.gridProvedores);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "VerProvedores";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "VerProvedores";
            this.Load += new System.EventHandler(this.VerProvedores_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridProvedores)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.DataGridView gridProvedores;
    }
}