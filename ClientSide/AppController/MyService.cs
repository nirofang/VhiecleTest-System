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


        public MyService()
        {
            InitializeComponent();
            this.initTimer();
        }

        protected override void OnStart(string[] args)
        {
            _host.Open();
        }

        protected override void OnStop()
        {
            _host.Close();
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
            bool isConnect = System.Net.NetworkInformation.NetworkInterface.GetIsNetworkAvailable();

            if(isConnect)
            {
                // 通过WebService告知状态

            }
        }
    }
}
