using System;
using System.ServiceProcess;

namespace AppLauncher.Util
{
    internal class ServiceUtil
    {
        #region 判断window服务是否存在  
        static internal bool ServiceIsExisted(string serviceName)
        {
            ServiceController[] services = ServiceController.GetServices();
            foreach (ServiceController s in services)
            {
                if (s.ServiceName == serviceName)
                {
                    return true;
                }
            }
            return false;
        }
        #endregion


        #region 判断window服务是否启动  
        /// <summary>  
        /// 判断某个Windows服务是否启动  
        /// </summary>  
        /// <returns></returns>  
        public static bool IsServiceStart(string serviceName)
        {
            ServiceController psc = new ServiceController(serviceName);
            bool bStartStatus = false;
            try
            {
                if (!psc.Status.Equals(ServiceControllerStatus.Stopped))
                {
                    bStartStatus = true;
                }

                return bStartStatus;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
        #endregion

        #region 启动服务  
        static internal bool StartService(System.ServiceProcess.ServiceController service)
        {
            bool flag = true;
            try
            {
                service.Start();
                for (int i = 0; i < 60; i++)
                {
                    service.Refresh();
                    System.Threading.Thread.Sleep(1000);
                    if (service.Status == System.ServiceProcess.ServiceControllerStatus.Running)
                    {
                        break;
                    }
                    if (i == 59)
                    {
                        flag = false;
                    }
                }
                return flag;
            }
            catch
            {
                return false;
            }
        }
        #endregion


        public static bool checkServiceIsValid(string serviceName)
        {
            if (ServiceIsExisted(serviceName))
            {
                System.ServiceProcess.ServiceController service = new System.ServiceProcess.ServiceController(serviceName);

                if (service.Status != System.ServiceProcess.ServiceControllerStatus.Running && service.Status != System.ServiceProcess.ServiceControllerStatus.StartPending)
                {
                    return StartService(service);
                }
                else
                {
                    return true;
                }

            }
            else
            {
                return false;
            }
        }
    }
}