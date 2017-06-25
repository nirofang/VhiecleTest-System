using AppLauncher.Util;
using AppWcfService;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AppLauncher
{
    public partial class ValidInfo : Form
    {
        //private System.Timers.Timer timer = new System.Timers.Timer();

        int countDownLeftNum = 5;

        public bool launhFlag = false;

        public string CDKey { get; internal set; }

        public KeyInfo KeyInfo { get; internal set; }

        public MyWcfService MyWcf { get; internal set; }

        public ValidInfo()
        {
            InitializeComponent();
        }

        private void ValidInfo_Load(object sender, EventArgs e)
        {
            label1.Text = "CDKey:" + CDKey;
            if (KeyInfo.Features[0] == true)
                label1.Text += "\n永久密钥";
            label1.Text += "\n剩余天数:" + KeyInfo.DaysLeft + " " + (KeyInfo.IsExpired ? "过期": "未过期");

            checkBox1.Checked = true;
            button1.Enabled = false;
            linkLabel1.Enabled = false;

            countDownLeft.Text = string.Empty;

            timer1.Start();
        }

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool EndDialog(IntPtr hDlg, out IntPtr nResult);

        private void button1_Click(object sender, EventArgs e)
        {
            launhFlag = true;
            this.Close();
        }



        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            InputCDKey inputForm = new InputCDKey();
            inputForm.ShowDialog();
            if (inputForm.enterKeyFlag == false)
            {
                return;
            }

            string cdKey = inputForm.CDKey;
            try
            {
                KeyInfo = MyWcf.GetKeyInfo(cdKey, "hello");

                if (KeyInfo.IsValid == true)
                {
                    // CDKey 合法，写注册表
                    if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", cdKey) == false)
                    {
                        MessageBox.Show("由于系统问题无法注册软件");
                        return;
                    }
                    CDKey = cdKey;

                    ValidInfo_Load(this, e);
                }
                else
                {
                    MessageBox.Show("CDKey内容非法");
                }
            }
            catch
            {
                MessageBox.Show("CDKey格式非法");
            }

            return;
        }

        private void ValidInfo_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Escape)
            {
                this.Close();
            }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            
            if (checkBox1.Checked == false)
            {
                if (KeyInfo.Features[0] == false &&
                    KeyInfo.IsExpired == true)
                    button1.Enabled = false;
                else
                    button1.Enabled = true;

                this.timer1.Enabled = false;
            }
            else
            {
                button1.Enabled = false;
                this.timer1.Enabled = true;
            }
        }

        delegate void CallBackHandle1();
        private void timer1_Tick(object sender, EventArgs e)
        {
            countDownLeft.Text = "自动启动剩余:" + (countDownLeftNum--).ToString() + "秒";
            if (countDownLeftNum < 0)
            {
                timer1.Enabled = false;
                this.Close();
                launhFlag = true;

            }
        }
    }
}
