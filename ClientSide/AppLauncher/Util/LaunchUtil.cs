using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace AppLauncher.Util
{
    internal class LaunchUtil
    {
        internal static void Launch()
        {
            //string result = string.Empty;
            
            using (Stream stream = typeof(LaunchUtil).Assembly.
                       GetManifestResourceStream("AppLauncher.Data.MFCApplication1.xml"))
            {
                string exePath = @"d:\temp\embedded.exe";

                byte[] bytes = new byte[(int)stream.Length];
                stream.Read(bytes, 0, bytes.Length);
                if (File.Exists(exePath) == false)
                    File.WriteAllBytes(exePath, bytes);
                ProcessStartInfo startInfo = new ProcessStartInfo();
                startInfo.WorkingDirectory = @"D:\dev\task\zhukai\codepro\MFCApplication1\Debug";
                startInfo.FileName = exePath;

                Process exep = new Process();
                exep.StartInfo = startInfo;
                exep.Start();

                Process.Start(startInfo);
                exep.WaitForExit();

                File.Delete(exePath);
            }
            return;
        }
    }
}
