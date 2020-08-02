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
    public partial class Provedores : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public Provedores()
        {
            InitializeComponent();
        }

        private void textBuscar_TextChanged(object sender, EventArgs e)
        {
            dv.RowFilter = "nombre LIKE '%" + textBuscar.Text + "%'";
        }

        private void Provedores_Load(object sender, EventArgs e)
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

        private void button1_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            //Método que se va a traer el botón para la posterior ejecución de la sentencia:
            ModificarProvedores v = new ModificarProvedores(id);
            v.ShowDialog();
            Provedores_Load(null, null);
        }

        private void gridProvedores_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            //Condición que determina que clave o id se va a tomar de la base de datos:
            if (e.RowIndex >= 0)
            {
                textID.Text = gridProvedores[0, e.RowIndex].Value.ToString();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            //Método que se va a traer el botón para la posterior ejecución de la sentencia:
            EliminarProvedores v = new EliminarProvedores(id);
            v.ShowDialog();
            Provedores_Load(null, null);
        }
    }
}
