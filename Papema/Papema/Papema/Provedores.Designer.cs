namespace Papema
{
    partial class Provedores
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Provedores));
            this.gridProvedores = new System.Windows.Forms.DataGridView();
            this.textBuscar = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.textID = new System.Windows.Forms.TextBox();
            ((System.ComponentModel.ISupportInitialize)(this.gridProvedores)).BeginInit();
            this.SuspendLayout();
            // 
            // gridProvedores
            // 
            this.gridProvedores.AllowUserToAddRows = false;
            this.gridProvedores.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.Aqua;
            this.gridProvedores.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.gridProvedores.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.gridProvedores.BackgroundColor = System.Drawing.Color.White;
            this.gridProvedores.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridProvedores.Location = new System.Drawing.Point(12, 79);
            this.gridProvedores.Name = "gridProvedores";
            this.gridProvedores.ReadOnly = true;
            this.gridProvedores.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridProvedores.Size = new System.Drawing.Size(729, 315);
            this.gridProvedores.TabIndex = 0;
            this.gridProvedores.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridProvedores_CellClick);
            // 
            // textBuscar
            // 
            this.textBuscar.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textBuscar.Location = new System.Drawing.Point(100, 37);
            this.textBuscar.Multiline = true;
            this.textBuscar.Name = "textBuscar";
            this.textBuscar.Size = new System.Drawing.Size(198, 35);
            this.textBuscar.TabIndex = 1;
            this.textBuscar.TextChanged += new System.EventHandler(this.textBuscar_TextChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(12, 40);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(85, 25);
            this.label1.TabIndex = 2;
            this.label1.Text = "Buscar";
            // 
            // button1
            // 
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.Location = new System.Drawing.Point(447, 414);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(137, 35);
            this.button1.TabIndex = 3;
            this.button1.Text = "Modificar";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button2.Location = new System.Drawing.Point(603, 414);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(137, 35);
            this.button2.TabIndex = 4;
            this.button2.Text = "Eliminar";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(12, 414);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(79, 25);
            this.label2.TabIndex = 8;
            this.label2.Text = "Clave:";
            // 
            // textID
            // 
            this.textID.Enabled = false;
            this.textID.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.Location = new System.Drawing.Point(94, 414);
            this.textID.Multiline = true;
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(198, 35);
            this.textID.TabIndex = 7;
            // 
            // Provedores
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.CadetBlue;
            this.ClientSize = new System.Drawing.Size(753, 471);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.textID);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBuscar);
            this.Controls.Add(this.gridProvedores);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Provedores";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Proveedores";
            this.Load += new System.EventHandler(this.Provedores_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridProvedores)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gridProvedores;
        private System.Windows.Forms.TextBox textBuscar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textID;
    }
}