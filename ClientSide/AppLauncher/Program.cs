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
            if(ServiceUtil.checkServiceIsValid("appController") == false)
            {
                MessageBox.Show("软件故障请重新安装");
                return;
            }

            // 检查 "CDKey" 是已经输入，如没有用要用对话框输入
            string cdKey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");

            // MPMVL-YGXOL-QQWMM-PZZFF
            if (string.IsNullOrEmpty(cdKey))
            {
                InputCDKey inputForm = new InputCDKey();
                inputForm.ShowDialog();

                if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", inputForm.CDKey) == false)
                {
                    MessageBox.Show("由于系统问题无法注册软件");
                    return;
                }
            }


            // 检查 "CDKey" 是否合法， 提示剩余时间
            MyWcfService myWcf = new MyWcfService();
            var keyInfo = myWcf.GetKeyInfo(cdKey, "hello");

            ValidInfo mainForm = new ValidInfo();
            mainForm.KeyInfo = keyInfo;
            mainForm.ShowDialog();

            
            


            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new MainForm());
        }


    }
}
