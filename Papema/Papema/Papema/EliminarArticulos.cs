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
    public partial class EliminarArticulos : Form
    {
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        public EliminarArticulos()
        {
            InitializeComponent();
        }

        //Método que se va a encargar de traerse componentes
        public EliminarArticulos(string id)
        {
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }

        //Método que realiza la lectura de información
        public void leerDatos()
        {

            //Excepciones para iniciar el programa:
            try
            {
                //Abrir la conexión:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                string sentenciaSQL = "SELECT * FROM articulos " +
                    "WHERE id_articulos = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                //textID.Text = lector2.GetValue(0).ToString();
                textUsu.Text = lector2.GetValue(1).ToString();
                textContra.Text = lector2.GetValue(2).ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
                con2.Open();

                string sentenciaSQL = "DELETE  FROM articulos " +
                    "WHERE id_articulos = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro Eliminado","Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);

                this.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void anteriorToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
