using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AppLauncher
{
    public partial class InputFacName : Form
    {
        public bool enterKeyFlag = false;

        public string FacName { get; internal set; }

        public InputFacName()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            FacName = textBox1.Text;
            enterKeyFlag = true;
            this.Close();
        }

        private void InputFacName_Load(object sender, EventArgs e)
        {
            textBox1.Text = "xxxxx测试厂";
            textBox1.SelectAll();
        }
    }
}
