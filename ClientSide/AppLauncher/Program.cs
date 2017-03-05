using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using AppLauncher.Util;
using AppWcfService;

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
            // MPMVL-YGXOL-QQWMM-PZZFF

            // 检查 "CDKey" 是否合法， 提示剩余时间
            MyWcfService myWcf = new MyWcfService();
            var keyInfo = myWcf.GetKeyInfo("MPMVL-YGXOL-QQWMM-PZZFF", string.Empty);

            ValidInfo mainForm = new ValidInfo();
            mainForm.KeyInfo = keyInfo;
            mainForm.ShowDialog();

            LaunchUtil.Launch();
            


            //Application.EnableVisualStyles();
            //Application.SetCompatibleTextRenderingDefault(false);
            //Application.Run(new MainForm());
        }
    }
}
