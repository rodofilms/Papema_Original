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
    public partial class Usuarios : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public Usuarios()
        {
            InitializeComponent();
        }

        private void Usuarios_Load(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                              "Database=" + "papema" + "; " +
                              "User Id=" + "root" + "; " +
                              "Password=";

            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();

                string sentenciaSQL = "SELECT * FROM usuarios ";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridUsuarios.DataSource = dv;
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

        private void textBuscar_TextChanged(object sender, EventArgs e)
        {
            dv.RowFilter = "nombre LIKE '%" + textBuscar.Text + "%'";
        }

        private void buttonModificar_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            FormModificarUsuario v = new FormModificarUsuario(id);
            v.ShowDialog();
            Usuarios_Load(null, null);
        }

        private void gridUsuarios_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textID.Text = gridUsuarios[0, e.RowIndex].Value.ToString();
            }
        }

        private void buttonEliminar_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            Eliminar v = new Eliminar(id);
            v.ShowDialog();
            Usuarios_Load(null, null);
        }

       
    }
}
