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


    }
}
