using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;



namespace AppLauncher.Util
{
    internal class LaunchUtil
    {
        const string fileName = "CVA 1000.exe";

        internal static void Launch()
        {
                        
            using (Stream stream = typeof(LaunchUtil).Assembly.
                       GetManifestResourceStream("AppLauncher.Data.app.bin"))
            {
                // Kill the process if its still running.
                ProcessUtil.EndProcess(fileName);



                // Binary copy the exe file to %temp% fodler

                // Judge the %temp% folder exist, if not warning to reinsntall OS
                string tempPath = Environment.GetEnvironmentVariable("temp");
                if (Directory.Exists(tempPath) == false)
                {
                    MessageBox.Show("操作系统故障请重新安装");
                    return;
                }


                string exePath = tempPath + "\\" + fileName;
                
                // Copy bype stream to %temp%\***.exe
                byte[] bytes = new byte[(int)stream.Length];
                stream.Read(bytes, 0, bytes.Length);
                if (File.Exists(exePath) == false)
                    File.WriteAllBytes(exePath, bytes);
                ProcessStartInfo startInfo = new ProcessStartInfo();

                // Read registry to get install location info
                string workDir = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CVA1000", "InstallPath");

                if (string.IsNullOrEmpty(workDir))
                {
                    MessageBox.Show("软件故障请重新安装");
                    return;
                }
                


                startInfo.WorkingDirectory = workDir;
                startInfo.FileName = exePath;

                Process exep = new Process();
                exep.StartInfo = startInfo;
                exep.Start();
                exep.WaitForExit();

                File.Delete(exePath);
            }
            return;
        }
    }
}
