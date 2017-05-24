using AppWcfService;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Diagnostics;
using System.Linq;
using System.ServiceModel;
using System.ServiceProcess;
using System.Text;
using System.Threading.Tasks;
using System.Timers;

namespace AppController
{
    public partial class MyService : ServiceBase
    {
        /// <summary>
        /// Host WCF in Windows Service, which can be used by WinForm
        /// </summary>
        private ServiceHost _host = new ServiceHost(typeof(MyWcfService));

        private System.Timers.Timer timer = new System.Timers.Timer();

        private string interval = ConfigurationManager.AppSettings["Interval"];

        private static bool uploadMachineInfoOnNetConn = true;


        public MyService()
        {
            InitializeComponent();
            initTimer();
        }

        protected override void OnStart(string[] args)
        {
            _host.Open();

            this.timer.Enabled = true;
        }

        protected override void OnStop()
        {
            _host.Close();

            this.timer.Enabled = false;
        }

        internal void TestStartupAndStop(string[] args)
        {
            this.OnStart(args);
            Console.ReadLine();
            this.OnStop();
        }

        private void initTimer()
        {
            int num;
            if (!int.TryParse(this.interval, out num))
            {
                num = 16000;
            }
            this.timer.Interval = (double)num;
            this.timer.Elapsed += new ElapsedEventHandler(this.timer_Elapsed);
        }


        private void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            // Test: EventLog working Pass
            //this.EventLog.WriteEntry(String.Format("TimeTick: CamAligner"), EventLogEntryType.Information);

            bool isConnect = System.Net.NetworkInformation.NetworkInterface.GetIsNetworkAvailable();

            if(isConnect)
            {
                // 通过WebService告知状态
                if (uploadMachineInfoOnNetConn)
                {
                    UploadMachineInfoOnNetConn();
                    uploadMachineInfoOnNetConn = false;
                }
            }
            else
            {
                uploadMachineInfoOnNetConn = true;
            }

        }

        private void UploadMachineInfoOnNetConn()
        {
            // Test: Get Data from network WCF service
            ServiceReference1.Service1Client srvDataTrans = new ServiceReference1.Service1Client();
            var trans = srvDataTrans.GetTransByID(2);
            if (trans.Count() != 0)
                this.EventLog.WriteEntry(String.Format("UploadMachineInfoOnNetConn success, db record name is {0}", trans[0].Name), EventLogEntryType.Information);

            MyWcfService myWcfService = new MyWcfService();
            string mc = myWcfService.GetMachineCode();
            this.EventLog.WriteEntry(String.Format("GetMachineCode success, value is {0}", mc), EventLogEntryType.Information);

            // Transfer machine code to a table on server side
        }
    }
}
