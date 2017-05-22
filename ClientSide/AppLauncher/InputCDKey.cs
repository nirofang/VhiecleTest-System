using AppLauncher.Util;
using Microsoft.Win32;
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
    public partial class InputCDKey : Form
    {
        public bool enterKeyFlag = false;

        public string CDKey { get; internal set; }

        public InputCDKey()
        {
            InitializeComponent();
        }

        private void InputCDKey_Load(object sender, EventArgs e)
        {
            textBox1.Text = "xxxxx-xxxxx-xxxxx-xxxxx";
            textBox1.SelectAll();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            //if (CDKeyUtil.CheckPass(textBox1.Text)==false)
            //{
            //    MessageBox.Show("CDKey格式不对请重新输入");
            //}
            CDKey = textBox1.Text;
            enterKeyFlag = true;
            this.Close();
        }


    }
}
