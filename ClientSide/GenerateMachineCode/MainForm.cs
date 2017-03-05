using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace GenerateMachineCode
{
    public partial class MainForm : Form
    {
        //Dim skc As SKGL.SerialKeyConfiguration = New SKGL.SerialKeyConfiguration()
        //Dim generate As SKGL.Generate = New SKGL.Generate(skc)



        public MainForm()
        {
            InitializeComponent();
        }

        private void GetCodeBtn_Click(object sender, EventArgs e)
        {
            SKGL.SerialKeyConfiguration skc = new SKGL.SerialKeyConfiguration();
            SKGL.Generate generate = new SKGL.Generate(skc);
            MachineCode.Text = generate.MachineCode.ToString();
        }
    }
}
