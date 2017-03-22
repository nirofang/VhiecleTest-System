using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace AppLauncher.Util
{
    class ProcessUtil
    {
        public static void EndProcess(string processName)
        {
            Thread.Sleep(2000);
            string name = Path.GetFileNameWithoutExtension(processName);
            foreach (Process process in Process.GetProcesses())
            {
                if (process.ProcessName.ToLower() == name.ToLower() && !process.HasExited)
                {
                    process.Kill();
                    Thread.Sleep(3000);
                }
            }
        }
    }
}
