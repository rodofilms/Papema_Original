namespace Papema
{
    partial class FormModificarUsuario
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(FormModificarUsuario));
            this.textID = new System.Windows.Forms.TextBox();
            this.textUsu = new System.Windows.Forms.TextBox();
            this.textContra = new System.Windows.Forms.TextBox();
            this.comboTipo = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.label2 = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.buttonCancelar = new System.Windows.Forms.Button();
            this.buttonAceptar = new System.Windows.Forms.Button();
            this.label4 = new System.Windows.Forms.Label();
            this.label5 = new System.Windows.Forms.Label();
            this.textApeP = new System.Windows.Forms.TextBox();
            this.textName = new System.Windows.Forms.TextBox();
            this.label6 = new System.Windows.Forms.Label();
            this.textApeM = new System.Windows.Forms.TextBox();
            this.SuspendLayout();
            // 
            // textID
            // 
            this.textID.Enabled = false;
            this.textID.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.Location = new System.Drawing.Point(300, 12);
            this.textID.Multiline = true;
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(100, 34);
            this.textID.TabIndex = 0;
            // 
            // textUsu
            // 
            this.textUsu.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textUsu.Location = new System.Drawing.Point(179, 63);
            this.textUsu.Multiline = true;
            this.textUsu.Name = "textUsu";
            this.textUsu.Size = new System.Drawing.Size(121, 34);
            this.textUsu.TabIndex = 1;
            // 
            // textContra
            // 
            this.textContra.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textContra.Location = new System.Drawing.Point(179, 114);
            this.textContra.Multiline = true;
            this.textContra.Name = "textContra";
            this.textContra.Size = new System.Drawing.Size(121, 34);
            this.textContra.TabIndex = 2;
            // 
            // comboTipo
            // 
            this.comboTipo.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.comboTipo.FormattingEnabled = true;
            this.comboTipo.Items.AddRange(new object[] {
            "Administrador",
            "Usuario"});
            this.comboTipo.Location = new System.Drawing.Point(179, 163);
            this.comboTipo.Name = "comboTipo";
            this.comboTipo.Size = new System.Drawing.Size(121, 37);
            this.comboTipo.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(45, 66);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(100, 29);
            this.label1.TabIndex = 4;
            this.label1.Text = "Usuario";
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label2.Location = new System.Drawing.Point(21, 117);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(149, 29);
            this.label2.TabIndex = 5;
            this.label2.Text = "Contrasenia";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label3.Location = new System.Drawing.Point(12, 163);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(163, 29);
            this.label3.TabIndex = 6;
            this.label3.Text = "Tipo Registro";
            // 
            // buttonCancelar
            // 
            this.buttonCancelar.BackColor = System.Drawing.Color.Crimson;
            this.buttonCancelar.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonCancelar.Location = new System.Drawing.Point(492, 231);
            this.buttonCancelar.Name = "buttonCancelar";
            this.buttonCancelar.Size = new System.Drawing.Size(133, 46);
            this.buttonCancelar.TabIndex = 7;
            this.buttonCancelar.Text = "Cancelar";
            this.buttonCancelar.UseVisualStyleBackColor = false;
            this.buttonCancelar.Click += new System.EventHandler(this.buttonCancelar_Click);
            // 
            // buttonAceptar
            // 
            this.buttonAceptar.BackColor = System.Drawing.Color.CadetBlue;
            this.buttonAceptar.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.buttonAceptar.Location = new System.Drawing.Point(76, 231);
            this.buttonAceptar.Name = "buttonAceptar";
            this.buttonAceptar.Size = new System.Drawing.Size(133, 46);
            this.buttonAceptar.TabIndex = 8;
            this.buttonAceptar.Text = "Aceptar";
            this.buttonAceptar.UseVisualStyleBackColor = false;
            this.buttonAceptar.Click += new System.EventHandler(this.buttonAceptar_Click);
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label4.Location = new System.Drawing.Point(332, 114);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(199, 29);
            this.label4.TabIndex = 12;
            this.label4.Text = "Apellido Paterno";
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label5.Location = new System.Drawing.Point(384, 63);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(103, 29);
            this.label5.TabIndex = 11;
            this.label5.Text = "Nombre";
            // 
            // textApeP
            // 
            this.textApeP.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textApeP.Location = new System.Drawing.Point(537, 114);
            this.textApeP.Multiline = true;
            this.textApeP.Name = "textApeP";
            this.textApeP.Size = new System.Drawing.Size(121, 34);
            this.textApeP.TabIndex = 10;
            // 
            // textName
            // 
            this.textName.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textName.Location = new System.Drawing.Point(537, 63);
            this.textName.Multiline = true;
            this.textName.Name = "textName";
            this.textName.Size = new System.Drawing.Size(121, 34);
            this.textName.TabIndex = 9;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label6.Location = new System.Drawing.Point(328, 163);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(203, 29);
            this.label6.TabIndex = 14;
            this.label6.Text = "Apellido Materno";
            // 
            // textApeM
            // 
            this.textApeM.Font = new System.Drawing.Font("Microsoft Sans Serif", 18.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textApeM.Location = new System.Drawing.Point(537, 163);
            this.textApeM.Multiline = true;
            this.textApeM.Name = "textApeM";
            this.textApeM.Size = new System.Drawing.Size(121, 34);
            this.textApeM.TabIndex = 13;
            // 
            // FormModificarUsuario
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.SystemColors.GradientInactiveCaption;
            this.ClientSize = new System.Drawing.Size(679, 289);
            this.Controls.Add(this.label6);
            this.Controls.Add(this.textApeM);
            this.Controls.Add(this.label4);
            this.Controls.Add(this.label5);
            this.Controls.Add(this.textApeP);
            this.Controls.Add(this.textName);
            this.Controls.Add(this.buttonAceptar);
            this.Controls.Add(this.buttonCancelar);
            this.Controls.Add(this.label3);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.comboTipo);
            this.Controls.Add(this.textContra);
            this.Controls.Add(this.textUsu);
            this.Controls.Add(this.textID);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "FormModificarUsuario";
            this.Text = "FormModificarUsuario";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.TextBox textID;
        private System.Windows.Forms.TextBox textUsu;
        private System.Windows.Forms.TextBox textContra;
        private System.Windows.Forms.ComboBox comboTipo;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Button buttonCancelar;
        private System.Windows.Forms.Button buttonAceptar;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.TextBox textApeP;
        private System.Windows.Forms.TextBox textName;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.TextBox textApeM;
    }
}