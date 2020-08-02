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
    public partial class VerClientes : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public VerClientes()
        {
            InitializeComponent();
        }

        private void VerClientes_Load(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "SELECT * FROM clientes ";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridClientes.DataSource = dv;
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message);
            }
            finally
            {
                con2.Close();
            }
        }

        
    }

}
