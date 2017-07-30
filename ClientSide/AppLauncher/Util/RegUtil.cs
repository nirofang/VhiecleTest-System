using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppLauncher.Util
{
    //class RegUtil
    //{
    //    public static string GetRegValue(string key, string name)
    //    {
    //        string value = "";
    //        RegistryKey regKey = null;
    //        if (key.ToUpper().StartsWith("HKLM"))
    //        {
    //            regKey = Registry.LocalMachine;
    //        }
    //        if (key.ToUpper().StartsWith("HKCU"))
    //        {
    //            regKey = Registry.CurrentUser;
    //        }
    //        if (regKey == null)
    //        {
    //            throw new Exception(string.Format("Reg key '{0}' needs to start with either HKLM or HKCU", key));
    //        }
    //        try
    //        {
    //            regKey = regKey.OpenSubKey(key.Substring(5, key.Length - 5));
    //        }
    //        catch
    //        {
    //            return null;
    //        }
            
    //        try
    //        {
    //            if (regKey != null)
    //            {
    //                value = regKey.GetValue(name).ToString();
    //            }
    //            else
    //            {
    //                Console.WriteLine("Can't find Regsitry Key: {0}", key);
    //            }

    //            return value;
    //        }
    //        catch
    //        {
    //            return null;
    //        }
    //    }


    //    public static bool CreateKeyValue(string keyPath, string subKeyName, string keyValue)
    //    {
    //        RegistryKey subKey;
    //        try
    //        {
    //            subKey = Registry.LocalMachine.OpenSubKey(keyPath, true);
    //        }
    //        catch
    //        {
    //            return false;
    //        }
    //        if (subKey == null)
    //        {
    //            try
    //            {
    //                // Strange thing:
    //                // 32 bit app will write to here
    //                // HKEY_CLASSES_ROOT\VirtualStore\MACHINE\SOFTWARE\WOW6432Node\CVA10001

    //                // If use the following code ,will write
    //                // HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\WOW6432Node\CVA10001

    //                //RegistryKey software = Registry.LocalMachine.OpenSubKey("SOFTWARE", true);
    //                //string softsub = keyPath.Replace(@"SOFTWARE\", "");
    //                //subKey = software.CreateSubKey(softsub);
    //                subKey = Registry.LocalMachine.CreateSubKey(keyPath);
    //            }
    //            catch
    //            {
    //                return false;
    //            }
    //        }
    //        if (subKey == null)
    //        {
    //            return false;
    //        }
    //        try
    //        {
    //            subKey.SetValue(subKeyName, keyValue);
    //        }
    //        catch
    //        {
    //            return false;
    //        }
    //        return true;
    //    }
    //}
}
