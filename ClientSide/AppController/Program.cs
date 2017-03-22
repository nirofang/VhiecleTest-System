using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Configuration.Install;
using System.Diagnostics;
using System.Linq;
using System.Reflection;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace AppController
{
    static class Program
    {
        /// <summary>
        /// 应用程序的主入口点。
        /// </summary>


        static void Main(string[] args)
        {
            if (System.Environment.UserInteractive)
            {
                string parameter = string.Concat(args);
                System.ServiceProcess.ServiceInstaller SINST = new System.ServiceProcess.ServiceInstaller();
                ServiceController SCONTROL = new ServiceController();
                SCONTROL.ServiceName = "appController";
                switch (parameter)
                {
                    // http://stackoverflow.com/questions/255056/install-a-net-windows-service-without-installutil-exe
                    case "--install":
                        //ManagedInstallerClass.InstallHelper(new string[] { Assembly.GetExecutingAssembly().Location });
                        ServiceProcessInstaller processInstaller = new ServiceProcessInstaller();
                        processInstaller.Account = ServiceAccount.LocalService;
                        
                        System.Configuration.Install.InstallContext Context = new System.Configuration.Install.InstallContext();
                        string processPath = Process.GetCurrentProcess().MainModule.FileName;
                        if (processPath != null && processPath.Length > 0)
                        {
                            System.IO.FileInfo fi = new System.IO.FileInfo(processPath);

                            String path = String.Format("/assemblypath={0}", fi.FullName);
                            String[] cmdline = { path };
                            Context = new System.Configuration.Install.InstallContext("", cmdline);
                        }

 
                        SINST.Context = Context;
                        //SINST.DisplayName = String.Format("{0} - {1}", "appController", InstanceID);
                        //SINST.Description = String.Format("{0} - {1}", "appController", InstanceID);
                        //SINST.ServiceName = String.Format("{0}_{1}", "appController", InstanceID);

                        SINST.ServiceName = "appController";
                        SINST.StartType = ServiceStartMode.Automatic;
                        SINST.Parent = processInstaller;

                        SINST.ServicesDependedOn = null;
                        System.Collections.Specialized.ListDictionary state = new System.Collections.Specialized.ListDictionary();
                        SINST.Install(state);

                        //// http://www.dotnet247.com/247reference/msgs/43/219565.aspx
                        //using (RegistryKey oKey = Registry.LocalMachine.OpenSubKey(String.Format(@"SYSTEM\CurrentControlSet\Services\{0}_{1}", "", InstanceID), true))
                        //{
                        //    try
                        //    {
                        //        Object sValue = oKey.GetValue("ImagePath");
                        //        oKey.SetValue("ImagePath", sValue);
                        //    }
                        //    catch (Exception Ex)
                        //    {
                        //        MessageBox.Show(Ex.Message);
                        //    }
                        //}
                        break;
                    case "--uninstall":
                        //ManagedInstallerClass.InstallHelper(new string[] { "/u", Assembly.GetExecutingAssembly().Location });
                        //http://www.theblacksparrow.com/


                        SINST.Context = new System.Configuration.Install.InstallContext(
                            Environment.GetEnvironmentVariable("temp") + "\\install.log", 
                            null);
                        //SINST.ServiceName = String.Format("{0}_{1}", ServiceName, InstanceID);
                        SINST.ServiceName = "appController";
                        SINST.Uninstall(null);
                        break;
                    case "--start":
                        if (SCONTROL.Status == ServiceControllerStatus.Stopped)
                        {
                            SCONTROL.Start();
                        }
                        break;
                    case "--stop":
                        if (SCONTROL.Status == ServiceControllerStatus.Running)
                        {
                            SCONTROL.Stop();
                        }
                        break;
                }
            }
            else
            {
                ServiceBase[] ServicesToRun;
                ServicesToRun = new ServiceBase[]
                {
                new MyService()
                };
                ServiceBase.Run(ServicesToRun);
            }
        }

    }
}
