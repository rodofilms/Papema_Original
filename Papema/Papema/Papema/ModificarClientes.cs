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
    public partial class ModificarClientes : Form
    {
        //Objetos y variable que se va a traer a la llave primaria de la base de datos:
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;

        public ModificarClientes()
        {
            InitializeComponent();
        }

        public ModificarClientes(string id)
        {
            //Constructos con parámetros que se va a encargar de traerse los datos de la llave primaria de la
            //base de datos:
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }

        //Método que se va a encargar de hacer la lectura de los datos correspondientes:
        public void leerDatos()
        {
            //Cadena que va a recibir lo de la base de datos:
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            //Excepciones:
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
                text_Nombre.Text = lector2.GetValue(1).ToString();
                text_APaterno.Text = lector2.GetValue(2).ToString();
                text_AMaterno.Text = lector2.GetValue(3).ToString();
                textTelefono.Text = lector2.GetValue(4).ToString();
                textCorreo.Text = lector2.GetValue(10).ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }

            finally
            {
                con2.Close();
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //Cadena de conexión:
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            //Se inicializan las excepciones:
            try
            {
                //Se abren las conexiones:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "UPDATE clientes SET " +
                    "nombre = '" + text_Nombre.Text + "', " +
                    "a_paterno = '" + text_APaterno.Text + "', " +
                    "a_materno = '" + text_AMaterno.Text + "', " +
                    "telefono = '" + textTelefono.Text + "', " +
                    "correo = '" + textCorreo.Text + "' " +
                    "WHERE id_clientes = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " Registro Modificado", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);

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
