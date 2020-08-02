namespace Papema
{
    partial class ModificarClientes
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ModificarClientes));
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.textID = new System.Windows.Forms.TextBox();
            this.text_Nombre = new System.Windows.Forms.TextBox();
            this.text_APaterno = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.text_AMaterno = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.textTelefono = new System.Windows.Forms.TextBox();
            this.label5 = new System.Windows.Forms.Label();
            this.textCorreo = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.BackColor = System.Drawing.Color.CadetBlue;
            this.button1.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button1.Location = new System.Drawing.Point(50, 227);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(132, 46);
            this.button1.TabIndex = 0;
            this.button1.Text = "Aceptar";
            this.button1.UseVisualStyleBackColor = false;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.BackColor = System.Drawing.Color.CadetBlue;
            this.button2.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.button2.Location = new System.Drawing.Point(188, 227);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(132, 46);
            this.button2.TabIndex = 1;
            this.button2.Text = "Cancelar";
            this.button2.UseVisualStyleBackColor = false;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // textID
            // 
            this.textID.Enabled = false;
            this.textID.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.Location = new System.Drawing.Point(116, 12);
            this.textID.Multiline = true;
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(135, 26);
            this.textID.TabIndex = 2;
            this.textID.TextAlign = System.Windows.Forms.HorizontalAlignment.Center;
            // 
            // text_Nombre
            // 
            this.text_Nombre.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.text_Nombre.Location = new System.Drawing.Point(197, 54);
            this.text_Nombre.Multiline = true;
            this.text_Nombre.Name = "text_Nombre";
            this.text_Nombre.Size = new System.Drawing.Size(159, 26);
            this.text_Nombre.TabIndex = 3;
            // 
            // text_APaterno
            // 
            this.text_APaterno.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.text_APaterno.Location = new System.Drawing.Point(197, 86);
            this.text_APaterno.Multiline = true;
            this.text_APaterno.Name = "text_APaterno";
            this.text_APaterno.Size = new System.Drawing.Size(159, 26);
            this.text_APaterno.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(98, 53);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(93, 25);
            this.label2.TabIndex = 6;
            this.label2.Text = "Nombre:";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(15, 85);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(176, 25);
            this.label3.TabIndex = 7;
            this.label3.Text = "Apellido Paterno:";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(11, 117);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(180, 25);
            this.label1.TabIndex = 9;
            this.label1.Text = "Apellido Materno:";
            // 
            // text_AMaterno
            // 
            this.text_AMaterno.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.text_AMaterno.Location = new System.Drawing.Point(197, 118);
            this.text_AMaterno.Multiline = true;
            this.text_AMaterno.Name = "text_AMaterno";
            this.text_AMaterno.Size = new System.Drawing.Size(159, 26);
            this.text_AMaterno.TabIndex = 8;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(89, 150);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(102, 25);
            this.label4.TabIndex = 11;
            this.label4.Text = "Telefono:";
            // 
            // textTelefono
            // 
            this.textTelefono.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textTelefono.Location = new System.Drawing.Point(197, 150);
            this.textTelefono.Multiline = true;
            this.textTelefono.Name = "textTelefono";
            this.textTelefono.Size = new System.Drawing.Size(159, 26);
            this.textTelefono.TabIndex = 10;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(108, 183);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(83, 25);
            this.label5.TabIndex = 13;
            this.label5.Text = "Correo:";
            // 
            // textCorreo
            // 
            this.textCorreo.Font = new System.Drawing.Font("Microsoft Sans Serif", 12.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textCorreo.Location = new System.Drawing.Point(197, 182);
            this.textCorreo.Multiline = true;
            this.textCorreo.Name = "textCorreo";
            this.textCorreo.Size = new System.Drawing.Size(159, 26);
            this.textCorreo.TabIndex = 12;
            // 
            // ModificarClientes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(374, 285);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.textCorreo);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.textTelefono);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.text_AMaterno);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.text_APaterno);
            this.Controls.Add(this.text_Nombre);
            this.Controls.Add(this.textID);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ModificarClientes";
            this.Text = "ModificarClientes";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.TextBox textID;
        private System.Windows.Forms.TextBox text_Nombre;
        private System.Windows.Forms.TextBox text_APaterno;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox text_AMaterno;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.TextBox textTelefono;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox textCorreo;
    }
}