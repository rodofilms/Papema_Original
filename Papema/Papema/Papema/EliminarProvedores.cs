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
    public partial class EliminarProvedores : Form
    {
        //Objetos y variable que se va a traer a la llave primaria de la base de datos:
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        public EliminarProvedores()
        {
            InitializeComponent();
        }

        public EliminarProvedores(string id)
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
                //Inicializar la variable con la conexión y abrir la conexión respectivamente:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                //Sentencia SQL de selección de los datos:
                string sentenciaSQL = "SELECT * FROM provedores " +
                    "WHERE id_provedores = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                textUsu.Text = lector2.GetValue(1).ToString();
                textContra.Text = lector2.GetValue(2).ToString();
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


        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "DELETE  FROM provedores " +
                    "WHERE id_provedores = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show("Registro Eliminado exitosamente", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);

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

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
