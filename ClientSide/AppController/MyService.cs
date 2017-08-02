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
using System.Net.Sockets;
using AppWcfService.Util;
using System.Runtime.Serialization.Json;

namespace AppController
{
    static class RegConfig
    {
        // Machine code
        public static string mc
        {
            get;
            set;
        }

        // CDKey
        public static string cdkey
        {
            get;
            set;
        }
    }

    public partial class MyService : ServiceBase
    {
        /// <summary>
        /// Host WCF in Windows Service, which can be used by WinForm
        /// </summary>
        private ServiceHost _host = new ServiceHost(typeof(MyWcfService));

        private System.Timers.Timer timer = new System.Timers.Timer();

        private string interval = ConfigurationManager.AppSettings["Interval"];

        //private static bool uploadMachineInfoOnNetConn = true;


        public MyService()
        {
            InitializeComponent();

            ReadReg();

            initTimer();
        }

        private void ReadReg()
        {

            string mc = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "MachineCode");
            if (string.IsNullOrEmpty(mc))
            {
                this.EventLog.WriteEntry(String.Format("Cannot get MachineCode from REG"), EventLogEntryType.Information);
                return;
            }

            // 检查 "CDKey" 是否已经输入
            string cdKey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");
            if (string.IsNullOrEmpty(cdKey))
            {
                this.EventLog.WriteEntry(String.Format("Cannot get CDKey from REG"), EventLogEntryType.Information);
            }
            RegConfig.mc = mc;
            RegConfig.cdkey = cdKey;
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

            //if(isConnect)
            //{
            //    // 通过WebService告知状态
            //    if (uploadMachineInfoOnNetConn)
            //    {
            //        UploadMachineInfoOnNetConn();
            //        uploadMachineInfoOnNetConn = false;
            //    }
            //}
            //else
            //{
            //    uploadMachineInfoOnNetConn = true;
            //}

            if (isConnect)
            {
                UploadMachineInfoOnNetConn();
            }
        }

        private void UploadMachineInfoOnNetConn()
        {
            // Test: Get Data from network WCF service
            //ServiceReference1.Service1Client srvDataTrans = new ServiceReference1.Service1Client();
            //var trans = srvDataTrans.GetTransByID(2);

            ////if (trans.Count() != 0)
            ////    this.EventLog.WriteEntry(String.Format("UploadMachineInfoOnNetConn success, db record name is {0}", trans[0].Name), EventLogEntryType.Information);

            //this.EventLog.WriteEntry(String.Format("Net connected"), EventLogEntryType.Information);


            //this.EventLog.WriteEntry(String.Format("CDKey:{0}, MachineCode:{1}", cdKey, mc), EventLogEntryType.Information);

            MyWcfService myWcfService = new MyWcfService();
            //string mc = myWcfService.GetMachineCode();
            //this.EventLog.WriteEntry(String.Format("GetMachineCode success, value is {0}", mc), EventLogEntryType.Information);
            try
            {
                var validKeyInfo = myWcfService.GetKeyInfo(RegConfig.cdkey, "hello");


                string CreationDate = validKeyInfo.CreationDate.ToShortDateString();
                string ValidDate = validKeyInfo.CreationDate.AddDays(validKeyInfo.DaysLeft).ToShortDateString();

                const string HOST_LINK = "http://nirovm2-pc:3000";
                //this.EventLog.WriteEntry(String.Format("Check web table"), EventLogEntryType.Information);

                //DateTime now = DateTime.Now;
                //string nowToNodeJs = now.ToString("s") + "Z";

                var customerData = GetNewCustomer(String.Format("{0}/GetCustomerInfo?MachineCode={1}", HOST_LINK, RegConfig.mc));
                if (customerData == null)
                {
                    return;
                }



                if (customerData.result.Count == 0)
                {
                    //this.EventLog.WriteEntry(String.Format("Check web table finished"), EventLogEntryType.Information);

                    // No customer rocord found from db table "Customers", need to upload

                    //GetUrltoHtml("http://nirovm2-pc:3000/UploadCustomerInfo?MachineCode=92040&CDKey=KTZEY-UBGPZ-REXIG-INWXB&CreationDate=2017-06-08&ValidDate=2017-07-08");

                    string uploadCustomerInfo = string.Format("{0}/UploadCustomerInfo?MachineCode={1}&CDKey={2}&CreationDate={3}&ValidDate={4}", HOST_LINK, RegConfig.mc, RegConfig.cdkey, CreationDate, ValidDate);

                    customerData = GetNewCustomer(uploadCustomerInfo);
                    if (customerData.result.Count == 0)
                    {
                        this.EventLog.WriteEntry(String.Format("Upload Customer data failed"), EventLogEntryType.Information);
                    }
                }
                else
                {
                    //need to update test status every 30 seconds
                    DateTime lastLogTime = DateTime.Parse(customerData.result[0].LastLogTime);

                    this.EventLog.WriteEntry(String.Format("Update Logon time after 30 seconds"), EventLogEntryType.Information);

                    // Run http://nirovm2-pc:3000/UpdateLastLogTime?MachineCode=92040 to update
                    string updateCustomerLogInfo = string.Format("{0}/UpdateLastLogTime?MachineCode={1}", HOST_LINK, RegConfig.mc);

                    var updateResult = GetNewUpdateResult(updateCustomerLogInfo);
                    if (updateResult.result.ok != 1)
                    {
                        this.EventLog.WriteEntry(String.Format("Update Logon Time failed"), EventLogEntryType.Information);
                    }


                    // Check if CDKey need to be updated
                    DateTime webValidDate = DateTime.Parse(customerData.result[0].ValidDate);
                    DateTime webCreationDate = DateTime.Parse(customerData.result[0].CreationDate);
                    if (webCreationDate.ToShortDateString() != CreationDate || webValidDate.ToShortDateString() != ValidDate)
                    {
                        this.EventLog.WriteEntry(String.Format("Re-generate CDKey"), EventLogEntryType.Information);

                        int lefDays = (int)(webValidDate - webCreationDate).TotalDays;
                        // Re-generate CDKey
                        string newCDKey = myWcfService.GetNewCDKey(lefDays, webCreationDate, int.Parse(RegConfig.mc));

                        // update cdkey to web database
                        // Run http://nirovm2-pc:3000/UpdateCDKey?MachineCode=92040&CDKey=KTZEY-UBGPZ-REXIG-INWXB to update
                        string updateCDKeyInfo = string.Format("{0}/UpdateCDKey?MachineCode={1}&CDKey={2}", HOST_LINK, RegConfig.mc, newCDKey);

                        this.EventLog.WriteEntry(String.Format("Re-generate CDKey"), EventLogEntryType.Information);

                        // Update local Registry
                        ReadReg();


                        updateResult = GetNewUpdateResult(updateCDKeyInfo);
                        if (updateResult.result.ok != 1)
                        {
                            this.EventLog.WriteEntry(String.Format("Update CDKey failed"), EventLogEntryType.Information);
                        }
                    }
                }


            }
            catch(Exception ex)
            {
                this.EventLog.WriteEntry(ex.ToString(), EventLogEntryType.Information);
            }
        }

        public NewCustomer GetNewCustomer(string Url)
        {
            try
            {
                System.Net.WebRequest wReq = System.Net.WebRequest.Create(Url);
                // Get the response instance.
                System.Net.WebResponse wResp = wReq.GetResponse();
                using (System.IO.Stream respStream = wResp.GetResponseStream())
                { 
                    DataContractJsonSerializer deseralizer = new DataContractJsonSerializer(typeof(NewCustomer));
                   return (NewCustomer)deseralizer.ReadObject(respStream);// //反序列化ReadObject
                }

            }
            catch (System.Exception ex)
            {
                this.EventLog.WriteEntry(String.Format("Get Web Data Message {0}", ex.Message), EventLogEntryType.Information);
            }
            return null;
        }

        public UpdateDb GetNewUpdateResult(string Url)
        {
            try
            {
                System.Net.WebRequest wReq = System.Net.WebRequest.Create(Url);
                // Get the response instance.
                System.Net.WebResponse wResp = wReq.GetResponse();
                using (System.IO.Stream respStream = wResp.GetResponseStream())
                {
                    DataContractJsonSerializer deseralizer = new DataContractJsonSerializer(typeof(UpdateDb));
                    return (UpdateDb)deseralizer.ReadObject(respStream);// //反序列化ReadObject
                }

            }
            catch (System.Exception ex)
            {
                this.EventLog.WriteEntry(String.Format("Get Web Data Message {0}", ex.Message), EventLogEntryType.Information);
            }
            return null;
        }
    }
}
