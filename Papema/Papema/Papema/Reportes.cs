using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace Papema
{
    public partial class Reportes : Form
    {
        public Reportes()
        {
            InitializeComponent();
        }

        private void volverAlMenúToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Acceso_Administrador acsa = new Acceso_Administrador();
            acsa.Show();
            Visible = false;
            acsa.Visible = true;
        }

        private void button1_Click(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Acceso_Administrador acsa = new Acceso_Administrador();
            acsa.Show();
            Visible = false;
            acsa.Visible = true;
        }
    }
}
