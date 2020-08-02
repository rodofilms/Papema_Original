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
    public partial class Registro_proveedores : Form
    {
        MySqlConnection con2;
        MySqlCommand comando2;

        public Registro_proveedores()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            con2 = new MySqlConnection(cadenacon);
            try
            {
                con2.Open();
                string sentenciaSQL = "INSERT INTO provedores values('" +
                    textClaveProvedor.Text + "','" +
                    textNombre.Text + "','" +
                    textApePaterno.Text + "','" +
                    textApeMaterno.Text + "', '" +
                    textAgencia.Text + "', '" +
                    textCalle.Text + "', '" +
                    textColonia.Text + "', '" +
                    textTelefono.Text + "', '" +
                    textCorreo.Text + "')";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro insertado");
                textClaveProvedor.Text = "";
                textNombre.Text = "";
                textApePaterno.Text = "";
                textApeMaterno.Text = "";
                textAgencia.Text = "";
                textCalle.Text = "";
                textColonia.Text = "";
                textTelefono.Text = "";
                textCorreo.Text = "";
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message);
            }
            finally
            {
                con2.Close();
            }
        }

        private void buttonCalcular_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void verRegistroDeProvedoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            VerProvedores v = new VerProvedores();
            v.ShowDialog();
        }
    }
}
