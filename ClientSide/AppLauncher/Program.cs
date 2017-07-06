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
            string facName = string.Empty;
            if (EnterFacName(ref facName) == false)
                return;
            
            
            // 打开模态对话框，新线程， 显示CDKey状态
            ValidInfo mainForm = new ValidInfo();
            mainForm.ShowDialog();


            // 结束新线程，为了线程安全使用flag
            if (mainForm.launhFlag == true)
                LaunchUtil.Launch();


            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new MainForm());
        }


        private static bool EnterFacName(ref string facName)
        {
            // 检查 Factory Name 是否已经输入
            facName = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "FacName");

            if (string.IsNullOrEmpty(facName))
            {

                InputFacName inputForm = new InputFacName();
                inputForm.ShowDialog();
                if (inputForm.enterKeyFlag == false)
                {
                    MessageBox.Show("未正常输入，请重新启动程序并输入厂商名字");

                    return false;
                }

                facName = inputForm.FacName;

                if (string.IsNullOrEmpty(facName))
                {
                    MessageBox.Show("输入为空，请重新启动程序并输入厂商名字");

                    return false;
                }


                // FacName 合法，写注册表
                if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", "FacName", facName) == false)
                {
                    MessageBox.Show("由于系统问题无法注册软件");
                    return false;
                }
                    
            }

            return true;
        }

    }
}
