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
    public partial class ModificarArticulos : Form
    {
        
        string llave;
        MySqlConnection con2;
        MySqlCommand comando2;
        MySqlDataReader lector2;
        DataSet ds;
        MySqlDataAdapter da;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                              "Database=" + "papema" + "; " +
                              "User Id=" + "root" + "; " +
                              "Password=";
        public ModificarArticulos()
        {
            InitializeComponent();
        }

        
        public ModificarArticulos(string id)
        {
            InitializeComponent();
            this.llave = id;
            textID.Text = llave;
            leerDatos();
        }

        
        public void leerDatos()
        {
            try
            {
                
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                string sentenciaSQL = "SELECT * FROM articulos " +
                    "WHERE id_articulos = '" + llave + "'";
                comando2 = new MySqlCommand(sentenciaSQL, con2);
                lector2 = comando2.ExecuteReader();
                lector2.Read();
                text_Articulo.Text = lector2.GetValue(1).ToString();
                text_PreMa.Text = lector2.GetValue(2).ToString();
                textPreMenu.Text = lector2.GetValue(3).ToString();
                textPreVen.Text = lector2.GetValue(5).ToString();
                textExistencia.Text = lector2.GetValue(7).ToString();
                llenarCombo();
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

        public void llenarCombo()
        {
            con2 = new MySqlConnection(cadenacon);
            try
            {
                con2.Open();
                string sentenciaSQL = "SELECT *FROM categorias " +
                    "ORDER BY id_categorias";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds, "categorias");
                comboCategoria.DataSource = ds.Tables[0];
                comboCategoria.ValueMember = "id_categorias";   //campo llave que se utilizara segun escoga el usuario
                comboCategoria.DisplayMember = "nombre_categoria"; // es la que mostrara el usuario
            }
            catch (Exception ex2)
            {
                MessageBox.Show("No se conecto: " + ex2.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }
        private void button1_Click(object sender, EventArgs e)
        {
            string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";


            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                
                string sentenciaSQL = "UPDATE articulos SET " +
                    "nombre_articulo = '"       + text_Articulo.Text + "', " +
                    "precio_compra_mayoreo = '" + text_PreMa.Text + "', " +
                    "precio_compra_menudeo = '" + textPreMenu.Text + "', " +
                    "precio_venta = '" + textPreVen.Text + "', " +
                    "existencia = '" + textExistencia.Text + "', " +
                    "id_categorias = '" + comboCategoria.SelectedValue.ToString() + "' " +
                    "WHERE id_articulos = '"    + textID.Text + "'";

                comando2 = new MySqlCommand(sentenciaSQL, con2);
                int nr = comando2.ExecuteNonQuery();
                MessageBox.Show(nr + " Registro Modificado", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
    }
}
