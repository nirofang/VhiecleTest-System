using AppLauncher.Util;
using AppWcfService;
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
    public partial class ValidInfo : Form
    {
        public KeyInfo KeyInfo { get; internal set; }
        public ValidInfo()
        {
            InitializeComponent();
        }

        private void ValidInfo_Load(object sender, EventArgs e)
        {
            label1.Text += KeyInfo.DaysLeft + " " + (KeyInfo.IsExpired ? "过期": "未过期");
        }

        private void button1_Click(object sender, EventArgs e)
        {
            this.Close();
            LaunchUtil.Launch();
        }
    }
}
