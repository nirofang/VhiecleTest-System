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


    public partial class MyService : ServiceBase
    {
        /// <summary>
        /// Host WCF in Windows Service, which can be used by WinForm
        /// </summary>
        private ServiceHost _host = new ServiceHost(typeof(MyWcfService));

        private System.Timers.Timer timer = new System.Timers.Timer();


        public MyService()
        {
            InitializeComponent();

            InitReadReg();

            InitReadConfig();

            InitDefaultVals();

            initTimer();
        }

        private void InitDefaultVals()
        {
            RegConfig.ValidKeyInfo = null;
        }

        private void InitReadConfig()
        {
            int webContactInterval;
            if (!int.TryParse(ConfigurationManager.AppSettings["Interval"], out webContactInterval))
            {
                webContactInterval = 16000;
            }
            RegConfig.webContactInterval = webContactInterval;
        }

        private void InitReadReg()
        {

            string mc = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "MachineCode");
            if (string.IsNullOrEmpty(mc))
            {
                //this.EventLog.WriteEntry(String.Format("Cannot get MachineCode from REG"), EventLogEntryType.Information);
                return;
            }
            RegConfig.MachineCode = mc;
            

            string facName = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "FacName");
            if (string.IsNullOrEmpty(facName))
            {
                //this.EventLog.WriteEntry(String.Format("Cannot get FacName from REG"), 
                //    EventLogEntryType.Information);
                return;
            }

            RegConfig.FacName = facName;


            // 检查 "CDKey" 是否已经输入
            string cdkey = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "CDKey");
            if (string.IsNullOrEmpty(cdkey))
            {
                //this.EventLog.WriteEntry(String.Format("Cannot get CDKey from REG"), 
                //    EventLogEntryType.Information);
                return;
            }
            RegConfig.Cdkey = cdkey;


            // 检查 "CDKey" 是否已经输入
            string hostlink = RegUtil.GetRegValue(@"HKLM\SOFTWARE\Wow6432Node\CamAligner", "HostLink");
            if (string.IsNullOrEmpty(cdkey))
            {
                //this.EventLog.WriteEntry(String.Format("Cannot get HostLink from REG"),
                //    EventLogEntryType.Information);
                //return;

                hostlink = "http://nirovm2-pc:3000";
            }
            RegConfig.HostLink = hostlink;

        }


        private void UpdateValidKeyInfoByCDKey()
        {
            RegConfig.ValidKeyInfo = RegConfig.MyWcfService.GetKeyInfo(RegConfig.Cdkey, "hello");
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
            this.timer.Interval = (double)RegConfig.webContactInterval;
            this.timer.Elapsed += new ElapsedEventHandler(this.timer_Elapsed);
        }


        private void timer_Elapsed(object sender, ElapsedEventArgs e)
        {
            // Test: EventLog working Pass
            //this.EventLog.WriteEntry(String.Format("TimeTick: CamAligner"), EventLogEntryType.Information);

            bool isConnect = System.Net.NetworkInformation.NetworkInterface.GetIsNetworkAvailable();

            if (isConnect)
            {
                UploadMachineInfoOnNetConn();
            }
        }

        private void UploadMachineInfoOnNetConn()
        {

            //this.EventLog.WriteEntry(String.Format("CDKey:{0}, MachineCode:{1}", cdKey, mc), EventLogEntryType.Information);

            //string mc = myWcfService.GetMachineCode();
            //this.EventLog.WriteEntry(String.Format("GetMachineCode success, value is {0}", mc), EventLogEntryType.Information);
            try
            {

                // checked if all infomration are available
                if (string.IsNullOrEmpty(RegConfig.Cdkey) ||
                    string.IsNullOrEmpty(RegConfig.MachineCode) ||
                    string.IsNullOrEmpty(RegConfig.FacName) ||
                    string.IsNullOrEmpty(RegConfig.HostLink)
                    )
                {
                    InitReadReg();
                    return;
                }

                var customerData = GetNewCustomer(String.Format("{0}/GetCustomerInfo?MachineCode={1}", RegConfig.HostLink, RegConfig.MachineCode));
                if (customerData == null)
                {
                    return;
                }


                if (RegConfig.ValidKeyInfo == null)
                {
                    //this.EventLog.WriteEntry(String.Format("Calling UpdateValidKeyInfoByCDKey"), EventLogEntryType.Information);
                    try
                    {
                        UpdateValidKeyInfoByCDKey();
                    }
                    catch (Exception ex)
                    {
                        this.EventLog.WriteEntry(String.Format("After Calling UpdateValidKeyInfoByCDKey, Excpetoin: {0}", ex.Message), EventLogEntryType.Information);
                    }
                    
                }

                if (RegConfig.ValidKeyInfo == null)
                {
                    RegConfig.KeyStatus = "密钥格式错误";
                }
                else if (RegConfig.ValidKeyInfo.Features[0])
                {
                    RegConfig.KeyStatus = "永久密钥";
                }
                else if (!RegConfig.ValidKeyInfo.IsValid || !RegConfig.ValidKeyInfo.IsOnRightMachine || RegConfig.ValidKeyInfo.IsExpired)
                {
                    this.EventLog.WriteEntry(String.Format("Fail to get info from cdkey {0}, IsValid: {1}, IsOnRightMachine: {2}", RegConfig.Cdkey,
                        RegConfig.ValidKeyInfo.IsValid,
                        RegConfig.ValidKeyInfo.IsOnRightMachine),
                        EventLogEntryType.Error
                        );

                    RegConfig.KeyStatus = "密钥失效";
                    
                }
                else
                {
                    RegConfig.KeyStatus = "密钥正常";
                }


                //this.EventLog.WriteEntry(String.Format("After judage ValidKeyInfo"), EventLogEntryType.Information);


                string CreationDate = null;
                string ValidDate = null;
                // Update RegConfig.ValidKeyInfo by read new cdkey from Reg
                try
                {
                    if (RegConfig.ValidKeyInfo != null)
                    {
                        // This coversion may cause issue
                        CreationDate = RegConfig.ValidKeyInfo.CreationDate.ToShortDateString();
                        ValidDate = RegConfig.ValidKeyInfo.CreationDate.AddDays(RegConfig.ValidKeyInfo.SetTime).ToShortDateString();
                    }
                }
                catch(Exception ex)
                {
                    this.EventLog.WriteEntry(String.Format("Convert Date string excption: {0}", ex.Message), EventLogEntryType.Information);
                }

                //this.EventLog.WriteEntry(String.Format("CreationDate: {0}", CreationDate), EventLogEntryType.Information);
                //this.EventLog.WriteEntry(String.Format("ValidDate: {0}", ValidDate), EventLogEntryType.Information);

                //this.EventLog.WriteEntry(String.Format("Check web table"), EventLogEntryType.Information);

                //DateTime now = DateTime.Now;
                //string nowToNodeJs = now.ToString("s") + "Z";

                //this.EventLog.WriteEntry(String.Format("After judge CreationDate"), EventLogEntryType.Information);


                if (customerData.result.Count == 0)
                {
                    //this.EventLog.WriteEntry(String.Format("Check web table finished"), EventLogEntryType.Information);

                    // No customer rocord found from db table "Customers", need to upload

                    //GetUrltoHtml("http://nirovm2-pc:3000/UploadCustomerInfo?MachineCode=92040&CDKey=KTZEY-UBGPZ-REXIG-INWXB&CreationDate=2017-06-08&ValidDate=2017-07-08");

                    string uploadCustomerInfo = string.Format("{0}/UploadCustomerInfo?MachineCode={1}&CDKey={2}&CreationDate={3}&ValidDate={4}&MachineStatus={5}", RegConfig.HostLink, RegConfig.MachineCode, RegConfig.Cdkey, CreationDate, ValidDate, RegConfig.KeyStatus);

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

                    //this.EventLog.WriteEntry(String.Format("Send heartbeat message UpdateLastLogTime"), EventLogEntryType.Information);

                    // Run http://nirovm2-pc:3000/UpdateLastLogTime?MachineCode=92040 to update
                    string updateCustomerLogInfo = string.Format("{0}/UpdateLastLogTime?MachineCode={1}", RegConfig.HostLink, RegConfig.MachineCode);

                    var updateResult = GetNewUpdateResult(updateCustomerLogInfo);
                    if (updateResult.result.ok != 1)
                    {
                        this.EventLog.WriteEntry(String.Format("Update Logon Time failed"), EventLogEntryType.Information);
                    }


                    string webValidDate = null;
                    if (customerData.result[0].ValidDate != null)
                    {
                        webValidDate = DateTime.Parse(customerData.result[0].ValidDate).ToShortDateString();
                    }
                    string webCreationDate = null;
                    if (customerData.result[0].CreationDate != null)
                    {
                        webCreationDate = DateTime.Parse(customerData.result[0].CreationDate).ToShortDateString();
                    }

                    //this.EventLog.WriteEntry(String.Format("webCreationDate: {0}", webCreationDate), EventLogEntryType.Information);
                    //this.EventLog.WriteEntry(String.Format("webValidDate: {0}", webValidDate), EventLogEntryType.Information);

                    //this.EventLog.WriteEntry(String.Format("CreationDate: {0}", CreationDate), EventLogEntryType.Information);
                    //this.EventLog.WriteEntry(String.Format("ValidDate: {0}", ValidDate), EventLogEntryType.Information);
                    //this.EventLog.WriteEntry(String.Format("RegConfig.FacName: {0}", RegConfig.FacName), EventLogEntryType.Information);
                    //this.EventLog.WriteEntry(String.Format("customerData.result[0].CustomerName: {0}", customerData.result[0].CustomerName), EventLogEntryType.Information);
                    this.EventLog.WriteEntry(String.Format("RegConfig.KeyStatus: {0}", RegConfig.KeyStatus), EventLogEntryType.Information);

                    // Check if CDKey not need to be updated
                    if (string.IsNullOrEmpty(customerData.result[0].WebCommand))
                    {
                        // Check if CDKey != webCDKey, need to udpate the webCDKey
                        if (RegConfig.Cdkey != customerData.result[0].CDKey || RegConfig.KeyStatus != customerData.result[0].MachineStatus || webCreationDate != CreationDate || webValidDate != ValidDate || customerData.result[0].CustomerName != RegConfig.FacName)
                        {
                            // update cdkey to web database
                            // Run http://nirovm2-pc:3000/UpdateCustomer?MachineCode=92040&CDKey=KTZEY-UBGPZ-REXIG-INWXB to update
                            string updateCDKeyInfo = string.Format("{0}/UpdateCustomer?MachineCode={1}&CDKey={2}&CreationDate={3}&ValidDate={4}&MachineStatus={5}&&CustomerName={6}", RegConfig.HostLink, RegConfig.MachineCode, RegConfig.Cdkey, CreationDate, ValidDate, RegConfig.KeyStatus, RegConfig.FacName);

                            // Update cdkey on web mongo db
                            updateResult = GetNewUpdateResult(updateCDKeyInfo);
                            if (updateResult.result.ok != 1)
                            {
                                this.EventLog.WriteEntry(String.Format("Update CDKey failed"), EventLogEntryType.Information);
                            }

                        }
                        return;
                    }


                    if (webCreationDate != CreationDate || webValidDate != ValidDate)
                    {

                        //this.EventLog.WriteEntry(String.Format("Re-generate CDKey"), EventLogEntryType.Information);
                        var webCreationDateObj = DateTime.Parse(customerData.result[0].CreationDate);
                        var webValidDateObj = DateTime.Parse(customerData.result[0].ValidDate);


                        int lefDays = (int)(webValidDateObj - webCreationDateObj).TotalDays;

                        bool foreverWork = false;
                        if (customerData.result[0].WebCommand == "ForeverCDKey")
                        {
                            lefDays = 0;
                            foreverWork = true;
                        }
                        

                        //this.EventLog.WriteEntry(String.Format("Re-generate CDKey, leftdays {0}", lefDays), EventLogEntryType.Information);

                        // Re-generate CDKey
                        // TODO: add a param to pass secret phrase to GetNewCDKey

                        string newCDKey = RegConfig.MyWcfService.GetNewCDKey(lefDays, webCreationDateObj, int.Parse(RegConfig.MachineCode), "hello", foreverWork);
  
                        // CDKey 合法，写注册表
                        if (RegUtil.CreateKeyValue(@"SOFTWARE\Wow6432Node\CamAligner", "CDKey", newCDKey) == false)
                        {
                            this.EventLog.WriteEntry(String.Format("CDKey write to reg Fail"), EventLogEntryType.Error);
                        }

                        // Reload Config and Reg
                        InitReadReg();
                        this.EventLog.WriteEntry(String.Format("After Re-generate CDKey, cdkey {0}, machinecode {1}", RegConfig.Cdkey, int.Parse(RegConfig.MachineCode)), EventLogEntryType.Information);


                        UpdateValidKeyInfoByCDKey();

                        this.EventLog.WriteEntry(String.Format("After Rereload cdkey and get key info"), EventLogEntryType.Information);


                        // update cdkey to web database
                        // Run http://nirovm2-pc:3000/UpdateCDKey?MachineCode=92040&CDKey=KTZEY-UBGPZ-REXIG-INWXB to update
                        string updateCDKeyInfo = string.Format("{0}/UpdateCDKey?MachineCode={1}&CDKey={2}&MachineStatus={3}", RegConfig.HostLink, RegConfig.MachineCode, newCDKey, RegConfig.KeyStatus);

                        // Update cdkey on web mongo db
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
