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
    public partial class Acceso_Administrador : Form
    {
        MySqlConnection con;
        MySqlCommand comando;

        DataSet ds;
        MySqlDataAdapter da;
        DataView dv;
        string cadenacon = "Data Source=" + "localhost" + "; " +
                               "Database=" + "papema" + "; " +
                               "User Id=" + "root" + "; " +
                               "Password=";
        string nombre;
        public Acceso_Administrador()
        {
            InitializeComponent();
        }
        public Acceso_Administrador(string nom)
        {
            InitializeComponent();
            this.nombre = nom;
        }

        private void artículosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Registro_articulos ra = new Registro_articulos();
            ra.ShowDialog();
        }

        private void proovedoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Registro_proveedores rp = new Registro_proveedores();
            rp.ShowDialog();
        }

        private void salirToolStripMenuItem_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void reportesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Reportes rep = new Reportes();
            rep.ShowDialog();
        }

        private void clientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Registro_clientes rc = new Registro_clientes();
            rc.ShowDialog();
        }

        private void Acceso_Administrador_Load(object sender, EventArgs e)
        {
            lblName.Text = nombre;
        }

        private void verClientesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Clientes v = new Clientes();
            v.ShowDialog();
        }

        private void verProvedoresToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Provedores v = new Provedores();
            v.ShowDialog();
        }

        private void verArticulosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Articulos v = new Articulos();
            v.ShowDialog();
        }

        private void verUsuariosToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Usuarios v = new Usuarios();
            v.ShowDialog();
        }

        private void reporteDeInventarioToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                string sentenciaSQL = "SELECT id_articulos,nombre_articulo as 'Nombre',"
                    + "existencia,precio_venta as 'Precio de Venta',(existencia*precio_venta) as 'Importe' "
                    + "FROM articulos";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con);
                da.Fill(ds);
                ds.WriteXml(@"C:\Users\Rodolfo Rodarte Jr\Documents\Visual Studio 2015\Projects\Papema\ReporteInvetario.xml", XmlWriteMode.WriteSchema);
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
            // ABRIR LA FORMA QUE ABRE EL REPORTE
            FormReporteInventario v = new FormReporteInventario();
            v.ShowDialog();
        }

        private void ventasToolStripMenuItem_Click(object sender, EventArgs e)
        {
            try
            {
                con = new MySqlConnection(cadenacon);
                con.Open();

                string sentenciaSQL = "SELECT v.id_ventas as 'Venta',c.id_clientes as 'Cliente',"
                    + "v.fecha_venta as 'Fecha',c.nombre as 'Nombre',av.id_articulos as 'ID',"
                    + "a.nombre_articulo as 'Articulo',av.cantidad,a.precio_venta as 'Precio',"
                    + "(a.precio_venta*av.cantidad) as 'Total' "
                    + "FROM ventas v "
                    + "INNER JOIN articulos_ventas av "
                    + "ON v.id_ventas = av.id_ventas "
                    + "INNER JOIN articulos a "
                    + "ON a.id_articulos = av.id_articulos "
                    + "INNER JOIN clientes c "
                    + "ON c.id_clientes = v.id_clientes "
                    + "ORDER BY av.id_ventas ";
                ds = new DataSet();
                da = new MySqlDataAdapter(sentenciaSQL, con);
                da.Fill(ds);
                ds.WriteXml(@"C:\Users\Rodolfo Rodarte Jr\Documents\Visual Studio 2015\Projects\Papema\ReporteTotalVentas.xml", XmlWriteMode.WriteSchema);
            }
            catch (Exception ex)
            {
                MessageBox.Show("ERROR en la conexion: " + ex.Message, "Aviso", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            {
                con.Close();
            }
            // ABRIR LA FORMA QUE ABRE EL REPORTE
            FormReporteVentas v = new FormReporteVentas();
            v.ShowDialog();
        }
    }
}
