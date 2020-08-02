using System;
using System.Data;
using System.Windows.Forms;
using MySql.Data.MySqlClient;

namespace Papema
{
    public partial class Acceso_Usuario : Form
    {
        MySqlConnection con;
        MySqlCommand comando;
        int idAux;

        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;

        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        string nombre;
        double aux;
        public Acceso_Usuario()
        {
            InitializeComponent();
        }
        public Acceso_Usuario(string nom)
        {
            InitializeComponent();
            this.nombre = nom;
        }
        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Acceso_Usuario_Load(object sender, EventArgs e)
        {
            lblName.Text = nombre;
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                string sentenciaSQL = "SELECT id_articulos as 'ID',nombre_articulo as 'Nombre',"
                    + "precio_venta as 'Precio' "
                    + "FROM articulos";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridArticulos.DataSource = dv;
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }

        private void buttonAgrega_Click(object sender, EventArgs e)
        {
            try
            {  
                con = new MySqlConnection(cadenacon);
                con.Open();

                comando = new MySqlCommand("ProVentas_Articulos", con);
                comando.CommandType = CommandType.StoredProcedure;
                //PARAMETROS DE ENTRADA
                comando.Parameters.Add(new MySqlParameter("idArticulos", textArticulo.Text));
                comando.Parameters.Add(new MySqlParameter("idVentas", idAux));
                comando.Parameters.Add(new MySqlParameter("cantidad", textCantidad.Text));
                //PARAMETROS DE SALIDA
                comando.Parameters.Add(new MySqlParameter("@msj", ""));
                comando.Parameters["@msj"].Direction = ParameterDirection.Output;
                //EJECUTAR EL PROCEDIMIENTO ALMACENADO
                comando.ExecuteNonQuery();
                //TOMAR LOS PARAMETROS QUE DEVOLVIO EL PROCE.ALM.
                MessageBox.Show(comando.Parameters["@msj"].Value.ToString(), "Aviso",MessageBoxButtons.OK,MessageBoxIcon.Information);
                if(comando.Parameters["@msj"].Value.ToString() != "Insertar no permitido")
                {
                    llenarGrid();
                }
                textCantidad.Text = "";
                textArticulo.Text = "";

            }
            catch (Exception)
            {
                MessageBox.Show("Ese producto no existe","Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            finally
            {
                con.Close();
            }
           
        }
        public void llenarGrid()
        {
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                string sentenciaSQL = "SELECT av.id_ventas as 'Venta',a.nombre_articulo as 'Articulo',av.id_articulos as 'ID', "
                    + "a.precio_venta as 'Precio',av.cantidad,a.iva,c.nombre_categoria as 'Categoria', "
                    + "(a.precio_venta*av.cantidad) as 'Importe' "
                    + "FROM articulos_ventas av " 
                    +"INNER JOIN articulos a "
                    +"ON a.id_articulos = av.id_articulos "
                    +"INNER JOIN categorias c "
                    +"ON a.id_categorias = c.id_categorias "
                    +"WHERE av.id_ventas = '"+idAux+"'";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con);
                da.Fill(ds);
                dv = new DataView();
                dv.Table = ds.Tables[0];
                gridVentas.DataSource = dv;
                //LLENAR EL CAMPO DE TOTAL TOMANDO COMO REFERENCIA LA COLUMNA DE PAGO * CANTIDAD
                double res = double.Parse(gridVentas[3, gridVentas.RowCount-1].Value.ToString()) * double.Parse(gridVentas[4, gridVentas.RowCount-1].Value.ToString());
                aux = aux + res +(res*double.Parse(gridVentas[5, gridVentas.RowCount - 1].Value.ToString()));
                textTotal.Text = aux.ToString();
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message,"Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }

        private void buttonPagar_Click(object sender, EventArgs e)
        {
            string pago;
            pago = Microsoft.VisualBasic.Interaction.InputBox("Con cuanto pagara?: ", "Pago", "0.0", 50, 50);
            if(double.Parse(pago) > double.Parse(textTotal.Text))
            {
                double cambio = double.Parse(pago) - double.Parse(textTotal.Text);
                MessageBox.Show("Su cambio es: "+ cambio,"Papema", MessageBoxButtons.OK, MessageBoxIcon.Information);
                try
                {
                    con = new MySqlConnection(cadenacon);
                    con.Open();
                    string sentenciaSQL = "UPDATE ventas SET " +
                        "total_venta         = '" + double.Parse(textTotal.Text) + "' " +
                        "WHERE id_ventas = '" + idAux + "'";

                    comando = new MySqlCommand(sentenciaSQL, con);
                    comando.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    MessageBox.Show("No se conecto: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
                finally
                {
                    con.Close();
                }
                //GENERA XML
                generaXML();
                FormTicket v = new FormTicket();
                v.ShowDialog();
            }
            else
            {
                MessageBox.Show("No se completa el pago", "Avertencia", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            
        }
        public void generaXML()
        {
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                string sentenciaSQL = "SELECT av.id_articulos,a.nombre_articulo,"
                    + "a.precio_venta,av.cantidad,v.total_venta,(a.precio_venta*av.cantidad) as 'Importe' "
                    + "FROM articulos_ventas av "
                    + "INNER JOIN articulos a "
                    + "ON a.id_articulos = av.id_articulos "
                    + "INNER JOIN ventas v "
                    + "ON v.id_ventas = '" + idAux + "' "
                    + "WHERE av.id_ventas = '" + idAux + "'";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con);
                da.Fill(ds);
                ds.WriteXml(@"C:\Users\Rodolfo Rodarte Jr\Documents\Visual Studio 2015\Projects\Papema\prueba.xml", XmlWriteMode.WriteSchema);
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }
        
        private void buttonIniciar_Click(object sender, EventArgs e)
        {
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                comando = new MySqlCommand("ProVentas", con);
                comando.CommandType = CommandType.StoredProcedure;
                //PARAMETROS DE ENTRADA
                comando.Parameters.Add(new MySqlParameter("total", 0.ToString()));
                comando.Parameters.Add(new MySqlParameter("fecha", dateTime.Value.ToString()));
                comando.Parameters.Add(new MySqlParameter("idCliente", textCliente.Text));
                //PARAMETROS DE SALIDA
                comando.Parameters.Add(new MySqlParameter("@idVenta", 0));
                comando.Parameters["@idVenta"].Direction = ParameterDirection.Output;
                //EJECUTAR EL PROCEDIMIENTO ALMACENADO
                comando.ExecuteNonQuery();
                //TOMAR LOS PARAMETROS QUE DEVOLVIO EL PROCE.ALM.
                idAux = int.Parse(comando.Parameters["@idVenta"].Value.ToString());
                if (idAux == -1)
                {
                    MessageBox.Show("No se encontro el cliente", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    idAux = 0;
                }
                else
                {
                    MessageBox.Show("Venta Iniciada", "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
        }

        private void gridArticulos_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                textArticulo.Text = gridArticulos[0, e.RowIndex].Value.ToString();
            }
        }

        private void ventasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            FormReporteVentas v = new FormReporteVentas();
            v.ShowDialog();
        }
    }
}
