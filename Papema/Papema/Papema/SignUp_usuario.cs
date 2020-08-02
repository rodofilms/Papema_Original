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
    public partial class SignUp_usuario : Form
    {
        MySqlConnection con2;
        MySqlCommand comando2;

        public SignUp_usuario()
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
                string sentenciaSQL = "INSERT INTO usuarios VALUES('', '" +
                    textUsu.Text + "','" +
                    textContra.Text + "','" +
                    comboTipo.SelectedItem.ToString() + "','" +
                    textName.Text + "','" +
                    textApP.Text + "','" +
                    textApM.Text + "','" +
                    textTel.Text + "','" +
                    textEst.Text + "','" +
                    textCiud.Text + "','" +
                    textCalle.Text + "','" +
                    textCol.Text + "')"; 

                MessageBox.Show(sentenciaSQL);
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " registro insertado");

                textUsu.Text = "";
                textContra.Text = "";
                textName.Text = "";
                textApP.Text = "";
                textApM.Text = "";
                textTel.Text = "";
                textCiud.Text = "";
                textEst.Text = "";
                textCalle.Text = "";
                textCol.Text = "";
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
    }
}
