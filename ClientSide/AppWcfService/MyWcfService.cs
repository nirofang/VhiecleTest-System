using SKGL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;

namespace AppWcfService
{
    // 注意: 使用“重构”菜单上的“重命名”命令，可以同时更改代码和配置文件中的类名“Service1”。

    /// <summary>
    /// Windows Service的时候会调用WCF服务
    /// WCF服务需要连接localhost:3302 端口
    /// 由于防火墙默认设置会组织端口通信
    /// netsh http add urlacl url=http://+:3302/MyWcfService.svc/ user="\Everyone"
    /// </summary>
    public class MyWcfService : IMyWcfService
    {
        
        public KeyInfo GetKeyInfo(string Key, string secretPhase)
        {
            SerialKeyConfiguration skc = new SerialKeyConfiguration();
            Validate validate  = new Validate(skc);

            validate.Key = Key;
            validate.secretPhase = secretPhase;

            KeyInfo keyInfo = new KeyInfo();
            keyInfo.IsExpired = validate.IsExpired;
            keyInfo.SetTime = validate.SetTime;
            keyInfo.DaysLeft = validate.DaysLeft;
            keyInfo.CreationDate = validate.CreationDate;
            keyInfo.IsValid = validate.IsValid;
            keyInfo.Features = validate.Features;
            keyInfo.Key = validate.Key;

            return keyInfo;
        }

        public string GetData(int value)
        {
            return string.Format("You entered: {0}", value);
        }

        public CompositeType GetDataUsingDataContract(CompositeType composite)
        {
            if (composite == null)
            {
                throw new ArgumentNullException("composite");
            }
            if (composite.BoolValue)
            {
                composite.StringValue += "Suffix";
            }
            return composite;
        }
    }
}
