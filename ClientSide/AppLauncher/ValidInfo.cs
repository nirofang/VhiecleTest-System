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

        private string CDKey;

        private KeyInfo KeyInfo;

        private MyWcfService MyWcf = new MyWcfService();

        public ValidInfo()
        {
            InitializeComponent();
        }

        private void ValidInfo_Load(object sender, EventArgs e)
        {
            CheckKeyStatus();
            LoadKeyInfoOnPanel();
        }

        internal void LoadKeyInfoOnPanel()
        {
            label1.Text = "CDKey:" + CDKey;

            if (KeyInfo == null)
            {
                button1.Enabled = false;
                return;
            }

            if (KeyInfo.Features[0] == true)
                label1.Text += "\n永久密钥";
            label1.Text += "\n剩余天数:" + KeyInfo.DaysLeft + " " + (KeyInfo.IsExpired ? "过期" : "未过期");

            if ((KeyInfo.Features[0] == false && KeyInfo.IsExpired == true)
                || KeyInfo.Features[0] == true)
            {
                button1.Enabled = true;
            }
        }

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

        private void CheckKeyStatus()
        {
            // 检查 "appController" 服务状态
            if (ServiceUtil.checkServiceIsValid("appController") == false)
            {
                // TODO 尝试三次启动服务 如还不行
                // TODO 放到LOGO页面

                MessageBox.Show("软件故障请重新安装");
                return;
            }

            // 检查 Factory Name 是否已经输入
            string facName = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "FacName");


            // 检查 "CDKey" 是否已经输入
            string cdKey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");

            MyWcfService myWcf = new MyWcfService();
            KeyInfo keyInfo, validKeyInfo = null;


            // CDKey 不存在 或者 存在不合法，重新输入
            if (string.IsNullOrEmpty(cdKey))
            {

                InputCDKey inputForm = new InputCDKey();
                inputForm.ShowDialog();
                if (inputForm.enterKeyFlag == false)
                {
                    return;
                }

                cdKey = inputForm.CDKey;

                if (string.IsNullOrEmpty(cdKey))
                {
                    MessageBox.Show("请输入CDKey");
                    return;
                }

            }

            try
            {
                keyInfo = myWcf.GetKeyInfo(cdKey, "hello");

                if (keyInfo.IsValid == true)
                {
                    validKeyInfo = keyInfo;
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

            if (validKeyInfo == null)
            {
                return;
            }

            // CDKey 合法，写注册表
            if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", cdKey) == false)
            {
                MessageBox.Show("由于系统问题无法注册软件");
                return;
            }

            KeyInfo = validKeyInfo;
            MyWcf = myWcf;
            CDKey = cdKey;

        }

    }
}
