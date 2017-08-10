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
using System.Runtime.InteropServices;
using AppWcfService.Util;

namespace AppLauncher
{
    public partial class ValidInfo : Form
    {
        const int COUNT_DOWN_NUM = 10;

        int countDownLeftNum = COUNT_DOWN_NUM;

        public bool launhFlag = false;

        private string cdKey = string.Empty;

        private KeyInfo validKeyInfo = null;

        private MyWcfService myWcf = new MyWcfService();

        public ValidInfo()
        {
            InitializeComponent();
        }

        [DllImport("user32.dll", SetLastError = true)]
        public static extern bool EndDialog(IntPtr hDlg, out IntPtr nResult);

        private void ValidInfo_Load(object sender, EventArgs e)
        {
            button1.Enabled = false;
            checkBox1.Enabled = false;
            countDownLeft.Text = string.Empty;
            checkBox1.Text = checkBox1.Text.Replace("n", COUNT_DOWN_NUM.ToString());

            CheckSoftStatus(sender);
            
        }

        private void LoadValidKeyOnPanel()
        {
            label1.Text = "CDKey:" + cdKey;
            

            if (validKeyInfo.Features[0] == true)
                label1.Text += "\n永久密钥";
            label1.Text += "\n剩余天数:" + validKeyInfo.DaysLeft + " " + (validKeyInfo.IsExpired ? "过期" : "未过期");
           
        }

        private void button1_Click(object sender, EventArgs e)
        {
            QuitPanelByCode(sender);
        }

        private void QuitPanelByCode(object sender)
        {
            this.DialogResult = DialogResult.OK;
            this.Close();
        }

        private void linkLabel1_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {

            EnterNewCDKey(ref cdKey, myWcf, ref validKeyInfo, true);

            return;
        }

        private void JudgeCDKeyStillWorks()
        {

            // 密钥非永久且未过期或密钥永久 都会启动程序
            if ((validKeyInfo.Features[0] == false && validKeyInfo.IsExpired == false)
                || validKeyInfo.Features[0] == true)

            {
                timer1.Start();
                launhFlag = true;


                checkBox1.Enabled = true;
                checkBox1.Checked = true;

                linkLabel1.Enabled = false;

            }
            else
            {
                checkBox1.Enabled = false;
                
                linkLabel1.Enabled = true;
            }
        }

        private void ValidInfo_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (e.KeyChar == (char)Keys.Escape)
            {
                QuitPanelByCode(sender);
            }
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            
            if (checkBox1.Checked == false)
            {
                if (validKeyInfo.Features[0] == false &&
                    validKeyInfo.IsExpired == true)
                    button1.Enabled = false;
                else
                    button1.Enabled = true;

                this.timer1.Stop();
                countDownLeft.Text = string.Empty;
            }
            else
            {
                button1.Enabled = false;
                countDownLeftNum = COUNT_DOWN_NUM;
                this.timer1.Start();
                //this.timer1.Enabled = true;

            }
        }

        private void timer1_Tick(object sender, EventArgs e)
        {
            countDownLeft.Text = "自动启动剩余:" + (countDownLeftNum--).ToString() + "秒";
            if (countDownLeftNum < 0)
            {
                timer1.Enabled = false;
                //this.Close();
                QuitPanelByCode(sender);
            }
        }

        /// <summary>
        ///检查windows服务
        ///检查注册表CDKey
        ///检查注册表FacName
        /// </summary>
        private void CheckSoftStatus(object sender)
        {
            // 检查 "appController" 服务状态
            if (ServiceUtil.checkServiceIsValid("appController") == false)
            {

                MessageBox.Show("软件故障请重新安装");
                QuitPanelByCode(sender);
                return;
            }


            // 检查 "CDKey" 是否已经输入
            cdKey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");

            EnterNewCDKey(ref cdKey, myWcf, ref validKeyInfo);

        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="cdKey"></param>
        /// <param name="myWcf"></param>
        /// <param name="validKeyInfo"></param>
        /// <param name="reEnterCDKey"></param>
        private void EnterNewCDKey(ref string cdKey, MyWcfService myWcf, ref KeyInfo validKeyInfo, bool reEnterCDKey =false)
        {
            // KXXNR-OCMGT-SOFQO-WBJRY
            // ICFXR - YDZOG - LDPLB - NMODN
            // MachineCode
            // ProcessorId
            // "178BFBFF00600F12"
            // Win32_BIOS
            // "To be filled by O.E.M."
            // Win32_BaseBoard
            // "MB-1234567890"
            // join 3 part togeter and cal 8byte hash
            // result like 83628

            string machineCode = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "MachineCode");

            if (string.IsNullOrEmpty(machineCode))
            {
                try
                {
                    machineCode = myWcf.GetMachineCode();
                }
                catch
                {
                    MessageBox.Show("计算机器码错误");
                    this.Close();
                    return;
                }
            }



            // CDKey 不存在 或者 需要重新输入（因为过期），重新输入
            if (string.IsNullOrEmpty(cdKey) || reEnterCDKey)
            {

                InputCDKey inputForm = new InputCDKey();

                inputForm.MachineCode = machineCode;
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
                validKeyInfo = myWcf.GetKeyInfo(cdKey, "hello");

                if (validKeyInfo.IsValid == true && validKeyInfo.IsOnRightMachine == true)
                {
                    JudgeCDKeyStillWorks();
                    LoadValidKeyOnPanel();
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
                button1.Enabled = false;
                timer1.Enabled = false;

            }


            // CDKey 合法，写注册表
            if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", "CDKey", cdKey) == false)
            {
                MessageBox.Show("由于系统问题无法注册软件");
                return;
            }

            // Machine Code 合法，写注册表
            if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", "MachineCode", machineCode) == false)
            {
                MessageBox.Show("机器码写入注册表失败");
                return;
            }

        }

        private void ValidInfo_FormClosed(object sender, FormClosedEventArgs e)
        {

        }

        private void ValidInfo_FormClosing(object sender, FormClosingEventArgs e)
        {
            //if (this.DialogResult == DialogResult.OK)
            //    return;
            if (this.DialogResult == DialogResult.Cancel)
                launhFlag = false;
        }
    }
}
