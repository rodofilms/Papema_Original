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
    public partial class EliminarClientes : Form
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

        public EliminarClientes()
        {
            InitializeComponent();
        }

        public EliminarClientes(string id)
        {
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }

        //Método que se va a encargar de hacer la lectura de los datos correspondientes:
        public void leerDatos()
        {
            try
            {
                //Inicializar la variable con la conexión y abrir la conexión respectivamente:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                //Sentencia SQL de selección de los datos:
                string sentenciaSQL = "SELECT * FROM clientes " +
                    "WHERE id_clientes = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                textUsu.Text = lector2.GetValue(1).ToString();
                textContra.Text = lector2.GetValue(2).ToString();
               
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
        private void EliminarClientes_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Abrir la excepción para mostrar los datos:
            try
            {
                //Abrir la conexión.
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "DELETE  FROM clientes " +
                    "WHERE id_clientes = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro Eliminado","Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);

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

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
