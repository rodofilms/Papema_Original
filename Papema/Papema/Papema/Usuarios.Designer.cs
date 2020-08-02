namespace Papema
{
    partial class Usuarios
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Usuarios));
            this.gridUsuarios = new System.Windows.Forms.DataGridView();
            this.textBuscar = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.textID = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.buttonModificar = new System.Windows.Forms.Button();
            this.buttonEliminar = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.gridUsuarios)).BeginInit();
            this.SuspendLayout();
            // 
            // gridUsuarios
            // 
            this.gridUsuarios.AllowUserToAddRows = false;
            this.gridUsuarios.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.Aqua;
            this.gridUsuarios.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.gridUsuarios.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.gridUsuarios.BackgroundColor = System.Drawing.Color.White;
            this.gridUsuarios.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridUsuarios.Location = new System.Drawing.Point(12, 79);
            this.gridUsuarios.Name = "gridUsuarios";
            this.gridUsuarios.ReadOnly = true;
            this.gridUsuarios.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridUsuarios.Size = new System.Drawing.Size(729, 299);
            this.gridUsuarios.TabIndex = 0;
            this.gridUsuarios.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridUsuarios_CellClick);
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
            // textID
            // 
            this.textID.Enabled = false;
            this.textID.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.Location = new System.Drawing.Point(67, 394);
            this.textID.Multiline = true;
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(110, 35);
            this.textID.TabIndex = 3;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(27, 397);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(34, 25);
            this.label2.TabIndex = 4;
            this.label2.Text = "ID";
            // 
            // buttonModificar
            // 
            this.buttonModificar.BackColor = System.Drawing.SystemColors.Control;
            this.buttonModificar.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonModificar.ForeColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.buttonModificar.Location = new System.Drawing.Point(439, 391);
            this.buttonModificar.Name = "buttonModificar";
            this.buttonModificar.Size = new System.Drawing.Size(137, 35);
            this.buttonModificar.TabIndex = 5;
            this.buttonModificar.Text = "Modificar";
            this.buttonModificar.Click += new System.EventHandler(this.buttonModificar_Click);
            // 
            // buttonEliminar
            // 
            this.buttonEliminar.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonEliminar.ForeColor = System.Drawing.SystemColors.InactiveCaptionText;
            this.buttonEliminar.Location = new System.Drawing.Point(604, 391);
            this.buttonEliminar.Name = "buttonEliminar";
            this.buttonEliminar.Size = new System.Drawing.Size(137, 35);
            this.buttonEliminar.TabIndex = 6;
            this.buttonEliminar.Text = "Eliminar";
            this.buttonEliminar.UseVisualStyleBackColor = true;
            // 
            // Usuarios
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.CadetBlue;
            this.ClientSize = new System.Drawing.Size(753, 441);
            this.Controls.Add(this.buttonEliminar);
            this.Controls.Add(this.buttonModificar);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.textID);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.textBuscar);
            this.Controls.Add(this.gridUsuarios);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Usuarios";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Usuarios";
            this.Load += new System.EventHandler(this.Usuarios_Load);
            ((System.ComponentModel.ISupportInitialize)(this.gridUsuarios)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DataGridView gridUsuarios;
        private System.Windows.Forms.TextBox textBuscar;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox textID;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Button buttonModificar;
        private System.Windows.Forms.Button buttonEliminar;
    }
}