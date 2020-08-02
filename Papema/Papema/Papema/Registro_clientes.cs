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
    public partial class Registro_clientes : Form
    {
        MySqlConnection con2;
        MySqlCommand comando2;

        public Registro_clientes()
        {
            InitializeComponent();
        }

        private void volverAlMenúToolStripMenuItem1_Click(object sender, EventArgs e)
        {
            Acceso_Administrador acsa = new Acceso_Administrador();
            acsa.Show();
            Visible = false;
            acsa.Visible = true;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
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
                string sentenciaSQL = "INSERT INTO clientes VALUES('', '" +
                    textNombre.Text + "','" +
                    textApePaterno.Text + "','" +
                    textApeMaterno.Text + "', '" +
                    textTelefono.Text + "', '" +
                    textCalle.Text + "', '" +
                    textCol.Text + "', '" +
                    textNum.Text + "', '" +
                    textEstado.Text + "', '"+
                    textMunicipio.Text + "', '" +
                    textCorreo.Text + "')";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro insertado");
                textNombre.Text = "";
                textApePaterno.Text = "";
                textApeMaterno.Text = "";
                textTelefono.Text = "";
                textCalle.Text = "";
                textCol.Text = "";
                textNum.Text = "";
                textEstado.Text = "";
                textMunicipio.Text = "";
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

        private void volverAlMenúToolStripMenuItem_Click(object sender, EventArgs e)
        {
            VerClientes v = new VerClientes();
            v.ShowDialog();
        }
    }
}
