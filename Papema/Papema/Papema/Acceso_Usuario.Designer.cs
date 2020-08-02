namespace Papema
{
    partial class Acceso_Usuario
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Acceso_Usuario));
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle2 = new System.Windows.Forms.DataGridViewCellStyle();
            this.dateTime = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.ventasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.salirToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.gridVentas = new System.Windows.Forms.DataGridView();
            this.buttonPagar = new System.Windows.Forms.Button();
            this.label2 = new System.Windows.Forms.Label();
            this.textTotal = new System.Windows.Forms.TextBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.lblName = new System.Windows.Forms.Label();
            this.textArticulo = new System.Windows.Forms.TextBox();
            this.lblArticulo = new System.Windows.Forms.Label();
            this.buttonAgrega = new System.Windows.Forms.Button();
            this.lblCliente = new System.Windows.Forms.Label();
            this.textCliente = new System.Windows.Forms.TextBox();
            this.textCantidad = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.buttonIniciar = new System.Windows.Forms.Button();
            this.gridArticulos = new System.Windows.Forms.DataGridView();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridVentas)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridArticulos)).BeginInit();
            this.SuspendLayout();
            // 
            // dateTime
            // 
            this.dateTime.Location = new System.Drawing.Point(54, 323);
            this.dateTime.Name = "dateTime";
            this.dateTime.Size = new System.Drawing.Size(200, 20);
            this.dateTime.TabIndex = 8;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 25.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(24, 45);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(196, 39);
            this.label1.TabIndex = 6;
            this.label1.Text = "Le atiende:";
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.Color.CadetBlue;
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.ventasToolStripMenuItem,
            this.salirToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(1337, 24);
            this.menuStrip1.TabIndex = 7;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // ventasToolStripMenuItem
            // 
            this.ventasToolStripMenuItem.Image = global::Papema.Properties.Resources.genera_mas_ventas;
            this.ventasToolStripMenuItem.Name = "ventasToolStripMenuItem";
            this.ventasToolStripMenuItem.Size = new System.Drawing.Size(69, 20);
            this.ventasToolStripMenuItem.Text = "Ventas";
            this.ventasToolStripMenuItem.Click += new System.EventHandler(this.ventasToolStripMenuItem_Click);
            // 
            // salirToolStripMenuItem
            // 
            this.salirToolStripMenuItem.Image = global::Papema.Properties.Resources.Salir;
            this.salirToolStripMenuItem.Name = "salirToolStripMenuItem";
            this.salirToolStripMenuItem.Size = new System.Drawing.Size(57, 20);
            this.salirToolStripMenuItem.Text = "Salir";
            this.salirToolStripMenuItem.Click += new System.EventHandler(this.salirToolStripMenuItem_Click);
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::Papema.Properties.Resources.Usuario;
            this.pictureBox1.Location = new System.Drawing.Point(52, 118);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(202, 199);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Zoom;
            this.pictureBox1.TabIndex = 5;
            this.pictureBox1.TabStop = false;
            // 
            // gridVentas
            // 
            this.gridVentas.AllowUserToAddRows = false;
            this.gridVentas.AllowUserToDeleteRows = false;
            dataGridViewCellStyle1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.gridVentas.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle1;
            this.gridVentas.BackgroundColor = System.Drawing.Color.White;
            this.gridVentas.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridVentas.Location = new System.Drawing.Point(717, 141);
            this.gridVentas.Name = "gridVentas";
            this.gridVentas.ReadOnly = true;
            this.gridVentas.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridVentas.Size = new System.Drawing.Size(608, 383);
            this.gridVentas.TabIndex = 9;
            // 
            // buttonPagar
            // 
            this.buttonPagar.BackColor = System.Drawing.Color.CadetBlue;
            this.buttonPagar.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonPagar.Location = new System.Drawing.Point(1155, 583);
            this.buttonPagar.Name = "buttonPagar";
            this.buttonPagar.Size = new System.Drawing.Size(170, 66);
            this.buttonPagar.TabIndex = 10;
            this.buttonPagar.Text = "Pagar";
            this.buttonPagar.UseVisualStyleBackColor = false;
            this.buttonPagar.Click += new System.EventHandler(this.buttonPagar_Click);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(674, 597);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(123, 47);
            this.label2.TabIndex = 11;
            this.label2.Text = "Total:";
            // 
            // textTotal
            // 
            this.textTotal.Enabled = false;
            this.textTotal.Font = new System.Drawing.Font("Microsoft Sans Serif", 22.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textTotal.Location = new System.Drawing.Point(803, 588);
            this.textTotal.Multiline = true;
            this.textTotal.Name = "textTotal";
            this.textTotal.Size = new System.Drawing.Size(276, 61);
            this.textTotal.TabIndex = 12;
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(37, 421);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(228, 215);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox2.TabIndex = 13;
            this.pictureBox2.TabStop = false;
            // 
            // lblName
            // 
            this.lblName.AutoSize = true;
            this.lblName.Font = new System.Drawing.Font("Microsoft Sans Serif", 24.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblName.Location = new System.Drawing.Point(226, 46);
            this.lblName.Name = "lblName";
            this.lblName.Size = new System.Drawing.Size(103, 38);
            this.lblName.TabIndex = 14;
            this.lblName.Text = "label3";
            // 
            // textArticulo
            // 
            this.textArticulo.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textArticulo.Location = new System.Drawing.Point(333, 471);
            this.textArticulo.Multiline = true;
            this.textArticulo.Name = "textArticulo";
            this.textArticulo.Size = new System.Drawing.Size(146, 49);
            this.textArticulo.TabIndex = 15;
            // 
            // lblArticulo
            // 
            this.lblArticulo.AutoSize = true;
            this.lblArticulo.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblArticulo.Location = new System.Drawing.Point(325, 421);
            this.lblArticulo.Name = "lblArticulo";
            this.lblArticulo.Size = new System.Drawing.Size(159, 47);
            this.lblArticulo.TabIndex = 16;
            this.lblArticulo.Text = "Articulo";
            // 
            // buttonAgrega
            // 
            this.buttonAgrega.BackColor = System.Drawing.Color.CadetBlue;
            this.buttonAgrega.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonAgrega.Location = new System.Drawing.Point(394, 526);
            this.buttonAgrega.Name = "buttonAgrega";
            this.buttonAgrega.Size = new System.Drawing.Size(193, 66);
            this.buttonAgrega.TabIndex = 17;
            this.buttonAgrega.Text = "Agregar";
            this.buttonAgrega.UseVisualStyleBackColor = false;
            this.buttonAgrega.Click += new System.EventHandler(this.buttonAgrega_Click);
            // 
            // lblCliente
            // 
            this.lblCliente.AutoSize = true;
            this.lblCliente.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblCliente.Location = new System.Drawing.Point(825, 55);
            this.lblCliente.Name = "lblCliente";
            this.lblCliente.Size = new System.Drawing.Size(150, 47);
            this.lblCliente.TabIndex = 19;
            this.lblCliente.Text = "Cliente";
            // 
            // textCliente
            // 
            this.textCliente.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textCliente.Location = new System.Drawing.Point(981, 55);
            this.textCliente.Multiline = true;
            this.textCliente.Name = "textCliente";
            this.textCliente.Size = new System.Drawing.Size(109, 61);
            this.textCliente.TabIndex = 18;
            // 
            // textCantidad
            // 
            this.textCantidad.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textCantidad.Location = new System.Drawing.Point(510, 471);
            this.textCantidad.Multiline = true;
            this.textCantidad.Name = "textCantidad";
            this.textCantidad.Size = new System.Drawing.Size(146, 49);
            this.textCantidad.TabIndex = 20;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 30.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(487, 421);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(186, 47);
            this.label3.TabIndex = 21;
            this.label3.Text = "Cantidad";
            // 
            // buttonIniciar
            // 
            this.buttonIniciar.BackColor = System.Drawing.Color.CadetBlue;
            this.buttonIniciar.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonIniciar.Location = new System.Drawing.Point(1111, 62);
            this.buttonIniciar.Name = "buttonIniciar";
            this.buttonIniciar.Size = new System.Drawing.Size(104, 38);
            this.buttonIniciar.TabIndex = 22;
            this.buttonIniciar.Text = "Iniciar";
            this.buttonIniciar.UseVisualStyleBackColor = false;
            this.buttonIniciar.Click += new System.EventHandler(this.buttonIniciar_Click);
            // 
            // gridArticulos
            // 
            this.gridArticulos.AllowUserToAddRows = false;
            this.gridArticulos.AllowUserToDeleteRows = false;
            dataGridViewCellStyle2.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(0)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.gridArticulos.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle2;
            this.gridArticulos.BackgroundColor = System.Drawing.Color.White;
            this.gridArticulos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.gridArticulos.Location = new System.Drawing.Point(318, 118);
            this.gridArticulos.Name = "gridArticulos";
            this.gridArticulos.ReadOnly = true;
            this.gridArticulos.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.gridArticulos.Size = new System.Drawing.Size(355, 250);
            this.gridArticulos.TabIndex = 23;
            this.gridArticulos.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.gridArticulos_CellClick);
            // 
            // Acceso_Usuario
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(1337, 699);
            this.Controls.Add(this.gridArticulos);
            this.Controls.Add(this.buttonIniciar);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.textCantidad);
            this.Controls.Add(this.lblCliente);
            this.Controls.Add(this.textCliente);
            this.Controls.Add(this.buttonAgrega);
            this.Controls.Add(this.lblArticulo);
            this.Controls.Add(this.textArticulo);
            this.Controls.Add(this.lblName);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.textTotal);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.buttonPagar);
            this.Controls.Add(this.gridVentas);
            this.Controls.Add(this.dateTime);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Acceso_Usuario";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Acceso_Usuario";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.Acceso_Usuario_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridVentas)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.gridArticulos)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dateTime;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem salirToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ventasToolStripMenuItem;
        private System.Windows.Forms.DataGridView gridVentas;
        private System.Windows.Forms.Button buttonPagar;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textTotal;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.TextBox textArticulo;
        private System.Windows.Forms.Label lblArticulo;
        private System.Windows.Forms.Button buttonAgrega;
        private System.Windows.Forms.Label lblCliente;
        private System.Windows.Forms.TextBox textCliente;
        private System.Windows.Forms.TextBox textCantidad;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button buttonIniciar;
        private System.Windows.Forms.DataGridView gridArticulos;
    }
}