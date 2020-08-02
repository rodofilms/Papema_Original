namespace Papema
{
    partial class Acceso_Administrador
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Acceso_Administrador));
            this.dateTimePicker1 = new System.Windows.Forms.DateTimePicker();
            this.label1 = new System.Windows.Forms.Label();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.comprasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.artículosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripSeparator();
            this.proovedoresToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.clientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.inventarioToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.verClientesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.verProvedoresToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.verArticulosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.verUsuariosToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.reporteDeInventarioToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.reportesToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.ventasToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.salirToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.lblName = new System.Windows.Forms.Label();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.menuStrip1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            this.SuspendLayout();
            // 
            // dateTimePicker1
            // 
            this.dateTimePicker1.Location = new System.Drawing.Point(187, 472);
            this.dateTimePicker1.Name = "dateTimePicker1";
            this.dateTimePicker1.Size = new System.Drawing.Size(200, 20);
            this.dateTimePicker1.TabIndex = 7;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.SystemColors.ControlText;
            this.label1.Location = new System.Drawing.Point(31, 64);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(203, 31);
            this.label1.TabIndex = 6;
            this.label1.Text = "Bienvenido(a):";
            // 
            // menuStrip1
            // 
            this.menuStrip1.BackColor = System.Drawing.Color.CadetBlue;
            this.menuStrip1.Font = new System.Drawing.Font("Microsoft Sans Serif", 11.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.comprasToolStripMenuItem,
            this.inventarioToolStripMenuItem,
            this.reportesToolStripMenuItem,
            this.ventasToolStripMenuItem,
            this.salirToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.RenderMode = System.Windows.Forms.ToolStripRenderMode.Professional;
            this.menuStrip1.Size = new System.Drawing.Size(1323, 26);
            this.menuStrip1.TabIndex = 4;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // comprasToolStripMenuItem
            // 
            this.comprasToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.artículosToolStripMenuItem,
            this.toolStripMenuItem1,
            this.proovedoresToolStripMenuItem,
            this.clientesToolStripMenuItem});
            this.comprasToolStripMenuItem.Image = global::Papema.Properties.Resources.compras;
            this.comprasToolStripMenuItem.Name = "comprasToolStripMenuItem";
            this.comprasToolStripMenuItem.Size = new System.Drawing.Size(96, 22);
            this.comprasToolStripMenuItem.Text = "Registrar";
            // 
            // artículosToolStripMenuItem
            // 
            this.artículosToolStripMenuItem.Image = global::Papema.Properties.Resources.articulos;
            this.artículosToolStripMenuItem.Name = "artículosToolStripMenuItem";
            this.artículosToolStripMenuItem.Size = new System.Drawing.Size(161, 22);
            this.artículosToolStripMenuItem.Text = "Artículos";
            this.artículosToolStripMenuItem.Click += new System.EventHandler(this.artículosToolStripMenuItem_Click);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(158, 6);
            // 
            // proovedoresToolStripMenuItem
            // 
            this.proovedoresToolStripMenuItem.Image = global::Papema.Properties.Resources.PROVEEDOR;
            this.proovedoresToolStripMenuItem.Name = "proovedoresToolStripMenuItem";
            this.proovedoresToolStripMenuItem.Size = new System.Drawing.Size(161, 22);
            this.proovedoresToolStripMenuItem.Text = "Proveedores";
            this.proovedoresToolStripMenuItem.Click += new System.EventHandler(this.proovedoresToolStripMenuItem_Click);
            // 
            // clientesToolStripMenuItem
            // 
            this.clientesToolStripMenuItem.Image = global::Papema.Properties.Resources.Clientes;
            this.clientesToolStripMenuItem.Name = "clientesToolStripMenuItem";
            this.clientesToolStripMenuItem.Size = new System.Drawing.Size(161, 22);
            this.clientesToolStripMenuItem.Text = "Clientes";
            this.clientesToolStripMenuItem.Click += new System.EventHandler(this.clientesToolStripMenuItem_Click);
            // 
            // inventarioToolStripMenuItem
            // 
            this.inventarioToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.verClientesToolStripMenuItem,
            this.verProvedoresToolStripMenuItem,
            this.verArticulosToolStripMenuItem,
            this.verUsuariosToolStripMenuItem,
            this.toolStripSeparator1,
            this.reporteDeInventarioToolStripMenuItem});
            this.inventarioToolStripMenuItem.Image = global::Papema.Properties.Resources.inventario;
            this.inventarioToolStripMenuItem.Name = "inventarioToolStripMenuItem";
            this.inventarioToolStripMenuItem.Size = new System.Drawing.Size(99, 22);
            this.inventarioToolStripMenuItem.Text = "Inventario";
            // 
            // verClientesToolStripMenuItem
            // 
            this.verClientesToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("verClientesToolStripMenuItem.Image")));
            this.verClientesToolStripMenuItem.Name = "verClientesToolStripMenuItem";
            this.verClientesToolStripMenuItem.Size = new System.Drawing.Size(216, 22);
            this.verClientesToolStripMenuItem.Text = "Ver Clientes";
            this.verClientesToolStripMenuItem.Click += new System.EventHandler(this.verClientesToolStripMenuItem_Click);
            // 
            // verProvedoresToolStripMenuItem
            // 
            this.verProvedoresToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("verProvedoresToolStripMenuItem.Image")));
            this.verProvedoresToolStripMenuItem.Name = "verProvedoresToolStripMenuItem";
            this.verProvedoresToolStripMenuItem.Size = new System.Drawing.Size(216, 22);
            this.verProvedoresToolStripMenuItem.Text = "Ver Provedores";
            this.verProvedoresToolStripMenuItem.Click += new System.EventHandler(this.verProvedoresToolStripMenuItem_Click);
            // 
            // verArticulosToolStripMenuItem
            // 
            this.verArticulosToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("verArticulosToolStripMenuItem.Image")));
            this.verArticulosToolStripMenuItem.Name = "verArticulosToolStripMenuItem";
            this.verArticulosToolStripMenuItem.Size = new System.Drawing.Size(216, 22);
            this.verArticulosToolStripMenuItem.Text = "Ver Articulos";
            this.verArticulosToolStripMenuItem.Click += new System.EventHandler(this.verArticulosToolStripMenuItem_Click);
            // 
            // verUsuariosToolStripMenuItem
            // 
            this.verUsuariosToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("verUsuariosToolStripMenuItem.Image")));
            this.verUsuariosToolStripMenuItem.Name = "verUsuariosToolStripMenuItem";
            this.verUsuariosToolStripMenuItem.Size = new System.Drawing.Size(216, 22);
            this.verUsuariosToolStripMenuItem.Text = "Ver Usuarios";
            this.verUsuariosToolStripMenuItem.Click += new System.EventHandler(this.verUsuariosToolStripMenuItem_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(213, 6);
            // 
            // reporteDeInventarioToolStripMenuItem
            // 
            this.reporteDeInventarioToolStripMenuItem.Image = ((System.Drawing.Image)(resources.GetObject("reporteDeInventarioToolStripMenuItem.Image")));
            this.reporteDeInventarioToolStripMenuItem.Name = "reporteDeInventarioToolStripMenuItem";
            this.reporteDeInventarioToolStripMenuItem.Size = new System.Drawing.Size(216, 22);
            this.reporteDeInventarioToolStripMenuItem.Text = "Reporte de Inventario";
            this.reporteDeInventarioToolStripMenuItem.Click += new System.EventHandler(this.reporteDeInventarioToolStripMenuItem_Click);
            // 
            // reportesToolStripMenuItem
            // 
            this.reportesToolStripMenuItem.Image = global::Papema.Properties.Resources.reportes;
            this.reportesToolStripMenuItem.Name = "reportesToolStripMenuItem";
            this.reportesToolStripMenuItem.Size = new System.Drawing.Size(97, 22);
            this.reportesToolStripMenuItem.Text = "Reportes";
            this.reportesToolStripMenuItem.Click += new System.EventHandler(this.reportesToolStripMenuItem_Click);
            // 
            // ventasToolStripMenuItem
            // 
            this.ventasToolStripMenuItem.Image = global::Papema.Properties.Resources.genera_mas_ventas;
            this.ventasToolStripMenuItem.Name = "ventasToolStripMenuItem";
            this.ventasToolStripMenuItem.Size = new System.Drawing.Size(81, 22);
            this.ventasToolStripMenuItem.Text = "Ventas";
            this.ventasToolStripMenuItem.Click += new System.EventHandler(this.ventasToolStripMenuItem_Click);
            // 
            // salirToolStripMenuItem
            // 
            this.salirToolStripMenuItem.Image = global::Papema.Properties.Resources.Salir;
            this.salirToolStripMenuItem.Name = "salirToolStripMenuItem";
            this.salirToolStripMenuItem.Size = new System.Drawing.Size(65, 22);
            this.salirToolStripMenuItem.Text = "Salir";
            this.salirToolStripMenuItem.Click += new System.EventHandler(this.salirToolStripMenuItem_Click);
            // 
            // lblName
            // 
            this.lblName.AutoSize = true;
            this.lblName.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblName.Location = new System.Drawing.Point(264, 67);
            this.lblName.Name = "lblName";
            this.lblName.Size = new System.Drawing.Size(81, 29);
            this.lblName.TabIndex = 9;
            this.lblName.Text = "label2";
            // 
            // pictureBox2
            // 
            this.pictureBox2.Image = ((System.Drawing.Image)(resources.GetObject("pictureBox2.Image")));
            this.pictureBox2.Location = new System.Drawing.Point(659, 40);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(569, 539);
            this.pictureBox2.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox2.TabIndex = 8;
            this.pictureBox2.TabStop = false;
            // 
            // pictureBox1
            // 
            this.pictureBox1.Image = global::Papema.Properties.Resources.Admin;
            this.pictureBox1.Location = new System.Drawing.Point(91, 165);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(405, 301);
            this.pictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage;
            this.pictureBox1.TabIndex = 5;
            this.pictureBox1.TabStop = false;
            // 
            // Acceso_Administrador
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(1323, 600);
            this.Controls.Add(this.lblName);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.dateTimePicker1);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.pictureBox1);
            this.Controls.Add(this.menuStrip1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "Acceso_Administrador";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Acceso_Administrador";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.Acceso_Administrador_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.DateTimePicker dateTimePicker1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem comprasToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem artículosToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripMenuItem1;
        private System.Windows.Forms.ToolStripMenuItem proovedoresToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem clientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem inventarioToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem reportesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem salirToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem ventasToolStripMenuItem;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Label lblName;
        private System.Windows.Forms.ToolStripMenuItem verClientesToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem verProvedoresToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem verArticulosToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem verUsuariosToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripMenuItem reporteDeInventarioToolStripMenuItem;
    }
}