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
        public bool launhFlag = false;

        public string CDKey { get; internal set; }

        public KeyInfo KeyInfo { get; internal set; }

        public ValidInfo()
        {
            InitializeComponent();
        }

        private void ValidInfo_Load(object sender, EventArgs e)
        {
            label1.Text = "CDKey:" + CDKey;
            if (KeyInfo.Features[0] == true)
                label1.Text += "\n永久密钥";
            label1.Text += "\n剩余时间:" + KeyInfo.DaysLeft + " " + (KeyInfo.IsExpired ? "过期": "未过期");

            if (KeyInfo.Features[0] == false &&
                KeyInfo.IsExpired == true
                )
                button1.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            launhFlag = true;
            this.Close();
            
        }
    }
}
