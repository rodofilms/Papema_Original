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
    public partial class Login : Form
    {
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        public Login()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            
            con2 = new MySqlConnection(cadenacon);
            try
            {
                con2.Open();

                string sentenciaSQL = "select * from usuarios ";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                int b = 0;
                string tipo = "";
                string nom = "";
                while (lector2.Read())
                {
                    string nombre = lector2.GetValue(1).ToString();
                    nom = lector2.GetValue(4).ToString()+" "+ lector2.GetValue(5).ToString();
                    string contrasenia = lector2.GetValue(2).ToString();
                    tipo = lector2.GetValue(3).ToString();
                    if(nombre == textUsu.Text && contrasenia == textContra.Text)
                    {
                        b = 1;
                        break;
                    }
                }
                if (b == 1 && tipo == "Administrador")
                {
                    Acceso_Administrador acceso1 = new Acceso_Administrador(nom);
                    acceso1.ShowDialog();
                    textUsu.Text = ""; textContra.Text = "";
                }
                else if (b == 1 && tipo == "Usuario")
                {
                    Acceso_Usuario acceso2 = new Acceso_Usuario(nom);
                    acceso2.ShowDialog();
                    textUsu.Text = ""; textContra.Text = "";
                }
                else if (textUsu.Text != "" && textContra.Text == "")
                {
                    MessageBox.Show("No has escrito la contrasenia", "Avertencia",MessageBoxButtons.OK,MessageBoxIcon.Exclamation);
                }
                else if (textUsu.Text == "" && textContra.Text != "")
                {
                    MessageBox.Show("El usuario no ha sido escrito", "Avertencia", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
                else if (textUsu.Text == "" && textContra.Text == "")
                {
                    MessageBox.Show("Es necesario rellenar todos los campos", "Avertencia", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
                else if(b == 0)
                {
                    MessageBox.Show("El usuario y/o contrasenia son incorrectos", "Avertencia", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                }
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

        private void acercaDeToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Acerca v = new Acerca();
            v.ShowDialog();
        }

        private void registrarseToolStripMenuItem_Click(object sender, EventArgs e)
        {
            SignUp_usuario v = new SignUp_usuario();
            v.ShowDialog();
        }

        private void textContra_KeyPress(object sender, KeyPressEventArgs e)
        {
            if ((int)e.KeyChar == (int)Keys.Enter)
            {
                button1_Click(null, null);
            }
        }
    }
}
