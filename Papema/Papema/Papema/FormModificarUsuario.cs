using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Papema
{
    public partial class FormModificarUsuario : Form
    {
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        public FormModificarUsuario()
        {
            InitializeComponent();
        }
        public FormModificarUsuario(string id)
        {
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }
        public void leerDatos()
        {
            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                string sentenciaSQL = "SELECT * FROM usuarios " +
                    "WHERE id_usuarios = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                textUsu.Text = lector2.GetValue(1).ToString();
                textContra.Text = lector2.GetValue(2).ToString();
                textName.Text = lector2.GetValue(4).ToString();
                textApeP.Text = lector2.GetValue(5).ToString();
                textApeM.Text = lector2.GetValue(6).ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void buttonAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                string sentenciaSQL = "UPDATE usuarios SET " +
                    "usuario         = '" + textUsu.Text + "', " +
                    "contrasenia     = '" + textContra.Text + "', " +
                    "tipo_registro   = '" + comboTipo.SelectedItem.ToString() + "', " +
                    "nombre          = '" + textName.Text + "', " +
                    "a_paterno       = '" + textApeP.Text + "', " +
                    "a_materno       = '" + textApeM.Text + "' " +
                    "WHERE id_usuarios = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                comando2.ExecuteNonQuery();
                MessageBox.Show("Registro Modificado Exitosamente", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);

                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void buttonCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
