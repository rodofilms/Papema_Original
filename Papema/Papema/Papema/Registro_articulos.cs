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
    public partial class Registro_articulos : Form
    {
        MySqlConnection con2;
        MySqlCommand comando2;
        DataSet ds;
        MySqlDataAdapter da;
        
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";

        public Registro_articulos()
        {
            InitializeComponent();
            llenarCombo();
        }
        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void buttonRegistrar_Click(object sender, EventArgs e)
        {
            if(textNombreArticulo.Text == "" || textPreVenta.Text == "" || textExistencia.Text == "")
            {
                MessageBox.Show("Le falta escribir campos obligatorios", "Atencion", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            }
                
            
            try
            {
                con2 = new MySqlConnection(cadenacon);
                con2.Open();
                comando2 = new MySqlCommand("ProNoRepetirArticulos", con2);
                comando2.CommandType = CommandType.StoredProcedure;
                //PARAMETROS DE ENTRADA
                comando2.Parameters.Add(new MySqlParameter("nombre", textNombreArticulo.Text));
                //PARAMETROS DE SALIDA
                comando2.Parameters.Add(new MySqlParameter("@msj", 0));
                comando2.Parameters["@msj"].Direction = ParameterDirection.Output;
                //EJECUTAR EL PROCEDIMIENTO ALMACENADO
                comando2.ExecuteNonQuery();
                //TOMAR LOS PARAMETROS QUE DEVOLVIO EL PROCE.ALM.

                if (int.Parse(comando2.Parameters["@msj"].Value.ToString()) == 0)
                {
                    MessageBox.Show("El Articulo ya existe", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    textNombreArticulo.Text = "";
                    textPreMay.Text = "";
                    textPreMen.Text = "";
                    textDesc.Text = "";
                    textPreVenta.Text = "";
                    textExistencia.Text = "";
                }
                else
                {
                    string sentenciaSQL = "INSERT INTO articulos VALUES('','" +
                    textNombreArticulo.Text + "','" +
                    textPreMay.Text + "','" +
                    textPreMen.Text + "','" +
                    textDesc.Text + "', '" +
                    textPreVenta.Text + "', '" +
                    iva.Text +"', '"+
                    textExistencia.Text + "', '" +
                    comboCategoria.SelectedValue.ToString() + "','" +
                    comboProvedor.SelectedValue.ToString() + "')";

                    comando2 = new MySqlCommand(sentenciaSQL, con2);
                    comando2.ExecuteNonQuery();
                    MessageBox.Show("Registro Insertado Exitosamente", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    textNombreArticulo.Text = "";
                    textPreMay.Text = "";
                    textPreMen.Text = "";
                    textDesc.Text = "";
                    textPreVenta.Text = "";
                    textExistencia.Text = "";
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("No se conecto: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
               //PROVEEDORES
                sentenciaSQL = "SELECT *FROM provedores " +
                    "ORDER BY id_provedores";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con2);
                da.Fill(ds, "provedores"); 
                comboProvedor.DataSource = ds.Tables[0];
                comboProvedor.ValueMember = "id_provedores";
                comboProvedor.DisplayMember = "agencia";
            }
            catch (Exception ex2)
            {
                MessageBox.Show("No se conecto: " + ex2.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con2.Close();
            }
        }

        private void verArticulosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            VerArticulos v = new VerArticulos();
            v.ShowDialog();
        }
    }
}
