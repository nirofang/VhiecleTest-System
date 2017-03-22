using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppLauncher.Util
{
    class RegUtil
    {
        public static string GetRegValue(string key, string name)
        {
            string value = "";
            RegistryKey regKey = null;
            if (key.ToUpper().StartsWith("HKLM"))
            {
                regKey = Registry.LocalMachine;
            }
            if (key.ToUpper().StartsWith("HKCU"))
            {
                regKey = Registry.CurrentUser;
            }
            if (regKey == null)
            {
                throw new Exception(string.Format("Reg key '{0}' needs to start with either HKLM or HKCU", key));
            }
            try
            {
                regKey = regKey.OpenSubKey(key.Substring(5, key.Length - 5));
                if (regKey != null)
                {
                    value = regKey.GetValue(name).ToString();
                }
                else
                {
                    Console.WriteLine("Can't find Regsitry Key: {0}", key);
                }

                return value;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}
