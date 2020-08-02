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
    public partial class Eliminar : Form
    {
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        public Eliminar()
        {
            InitializeComponent();
        }

        //Constructor
        public Eliminar(string id)
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
                //Abrir la conexión:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "SELECT * FROM usuarios " +
                                      "WHERE id_usuarios = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();

                //Parámetros que se va a traer de la base de datos para realizar la lectura:
                textUsu.Text = lector2.GetValue(1).ToString();
                textContra.Text = lector2.GetValue(2).ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message,"Aviso",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                con2 = new MySqlConnection(cadenacon);
                //Abrir la conexión:
                con2.Open();

                //Sentencia SQL que se va a encargar de eliminar los datos del cliente:
                string sentenciaSQL = "DELETE  FROM usuarios " +
                    "WHERE id_usuarios = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro Eliminado");

                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message,"Aviso",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
