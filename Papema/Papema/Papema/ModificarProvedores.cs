using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using MySql.Data.MySqlClient;//Parámetros a modificar.

namespace Papema
{
    public partial class ModificarProvedores : Form
    {
        //Objetos y variables que se van a modificar:
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;

        public ModificarProvedores()
        {
            InitializeComponent();
        }

        //Constructor:
        public ModificarProvedores(string id)
        {
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }

        public void leerDatos()
        {
            //Cadena que va a recibir, la cual es la que se va a la base de datos:
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            //Inicio de las excepciones:
            try
            {
                //Inicio de las conexiones a la base de datos:
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                //Sentencia SQL que se va a encargar de mostrar todo en los datos:
                string sentenciaSQL = "SELECT * FROM provedores " +
                    "WHERE id_provedores = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                text_Nombre.Text = lector2.GetValue(1).ToString();
                text_APaterno.Text = lector2.GetValue(2).ToString();
                text_AMaterno.Text = lector2.GetValue(3).ToString();
                textAgencia.Text = lector2.GetValue(4).ToString();
                textTelefono.Text = lector2.GetValue(7).ToString();
                textCorreo.Text = lector2.GetValue(8).ToString();
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

                string sentenciaSQL = "UPDATE provedores SET " +
                    "nombre = '" + text_Nombre.Text + "', " +
                    "a_paterno = '" + text_APaterno.Text + "', " +
                    "a_materno = '" + text_AMaterno.Text + "', " +
                    "agencia = '" + text_APaterno.Text + "', " +
                    "telefono = '" + textTelefono.Text + "', " +
                    "correo = '" + textCorreo.Text + "' " +
                    "WHERE id_provedores = '" + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show("Registro Modificado exitosamente","Aviso",MessageBoxButtons.OK,MessageBoxIcon.Information);

                this.Close();
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

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }
    }
}
