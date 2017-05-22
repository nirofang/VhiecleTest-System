using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using AppLauncher.Util;
using AppWcfService;
using Microsoft.Win32;

namespace AppLauncher
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>
        [STAThread]
        static void Main()
        {
            // 检查 "appController" 服务状态
            if (ServiceUtil.checkServiceIsValid("appController") == false)
            {
                MessageBox.Show("软件故障请重新安装");
                return;
            }

            // 检查 "CDKey" 是已经输入
            string cdKey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");

            MyWcfService myWcf = new MyWcfService();
            KeyInfo keyInfo, validKeyInfo = null;
            bool reEnterCDKey = false;

            // 如果注册表没有CDKEY要用对话框输入
            if (!string.IsNullOrEmpty(cdKey))
            {
                try
                {
                    keyInfo = myWcf.GetKeyInfo(cdKey, "hello");
                    if (keyInfo.IsValid == false)
                    {
                        MessageBox.Show("注册表CDKey:" + cdKey + "内容非法，请重新输入");
                        reEnterCDKey = true;
                    }
                    else
                    {
                        validKeyInfo = keyInfo;
                    }
                }
                catch
                {
                    MessageBox.Show("注册表CDKey" + cdKey + "格式非法，请重新输入");
                    reEnterCDKey = true;
                }
            }

            // CDKey 不存在 或者 存在不合法，重新输入
            if (string.IsNullOrEmpty(cdKey) || reEnterCDKey == true)
            {
                for (int i = 0; i < 3; i++)
                {
                    InputCDKey inputForm = new InputCDKey();
                    inputForm.ShowDialog();
                    if (inputForm.enterKeyFlag == false)
                    {
                        return;
                    }

                    cdKey = inputForm.CDKey;
                    try
                    {
                        keyInfo = myWcf.GetKeyInfo(cdKey, "hello");

                        if (keyInfo.IsValid == true)
                        {
                            validKeyInfo = keyInfo;
                            break;
                        }
                        else
                        {
                            int leftEnterKeyTimes = 3 - i - 1;
                            MessageBox.Show("CDKey内容非法，请重新输入（" + "剩余" + leftEnterKeyTimes.ToString() + "次)");
                        }
                    }
                    catch
                    {
                        int leftEnterKeyTimes = 3 - i - 1;
                        MessageBox.Show("CDKey格式非法，请重新输入（" + "剩余" + leftEnterKeyTimes.ToString() + "次)");
                    }
                }
            }

            if (validKeyInfo ==null)
            {
                MessageBox.Show("无合法CDKey");
                return;
            }

            // CDKey 合法，写注册表
                if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", cdKey) == false)
            {
                MessageBox.Show("由于系统问题无法注册软件");
                return;
            }

            // 打开模态对话框，新线程， 显示CDKey状态
            ValidInfo mainForm = new ValidInfo();
            mainForm.KeyInfo = validKeyInfo;
            mainForm.CDKey = cdKey;
            mainForm.ShowDialog();

            // 结束新线程，为了线程安全使用flag
            if (mainForm.launhFlag == true)
                LaunchUtil.Launch();


            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new MainForm());
        }


    }
}
