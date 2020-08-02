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
    public partial class Articulos : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public Articulos()
        {
            InitializeComponent();
        }

        private void Articulos_Load(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                              "Database=" + "papema" + "; " +
                              "User Id=" + "root" + "; " +
                              "Password=";

            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "SELECT * FROM articulos ";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridArticulos.DataSource = dv;
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message,"Aviso",MessageBoxButtons.OK,MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void textBuscar_TextChanged(object sender, EventArgs e)
        {
            dv.RowFilter = "nombre_articulo LIKE '%" + textBuscar.Text + "%'";
        }

        //Boton para las modificaciones de articulos:
        private void button1_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            ModificarArticulos v = new ModificarArticulos(id);
            v.ShowDialog();
            Articulos_Load(null, null);
        }

        private void gridArticulos_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textID.Text = gridArticulos[0, e.RowIndex].Value.ToString();
            }
        }

        private void gridArticulos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textID.Text = gridArticulos[0, e.RowIndex].Value.ToString();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            EliminarArticulos v = new EliminarArticulos(id);
            v.ShowDialog();
            Articulos_Load(null, null);
        }
    }
}
