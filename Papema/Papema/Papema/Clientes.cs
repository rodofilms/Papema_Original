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
    public partial class Clientes : Form
    {
        MySqlConnection con2;
        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        public Clientes()
        {
            InitializeComponent();
        }

        private void Clientes_Load(object sender, EventArgs e)
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
                MessageBox.Show("ERROR en la conexion: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
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

        private void button1_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            ModificarClientes mc = new ModificarClientes(id);
            mc.ShowDialog();
            Clientes_Load(null, null);
        }

        //Evento que sirve para pasar las claves al textBox
        private void gridClientes_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textID.Text = gridClientes[0, e.RowIndex].Value.ToString();
            }
        }

        private void gridClientes_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textID.Text = gridClientes[0, e.RowIndex].Value.ToString();
            }
        }

        //Boton que se va a traer la ventana de eliminacion:
        private void button2_Click(object sender, EventArgs e)
        {
            string id = textID.Text;

            //Mandar llamar al método que se encarga de hacer las eliminaciones:
            EliminarClientes elc = new EliminarClientes(id);
            elc.ShowDialog();
            Clientes_Load(null, null);
        }
    }
}
