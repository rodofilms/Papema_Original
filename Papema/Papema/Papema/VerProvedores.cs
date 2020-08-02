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
    public partial class VerProvedores : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public VerProvedores()
        {
            InitializeComponent();
        }

        private void VerProvedores_Load(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "SELECT * FROM provedores ";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridProvedores.DataSource = dv;
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
