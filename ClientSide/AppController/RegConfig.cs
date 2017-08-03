using AppWcfService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppController
{
    static class RegConfig
    {
        static MyWcfService myWcfService;

        // Machine code
        public static string MachineCode { get; internal set; }
        // CDKey
        public static string Cdkey { get; internal set; }

        public static string HostLink { get; internal set; }

        // Web contact interval, in millisecond
        public static int webContactInterval { get; internal set; }
        public static MyWcfService MyWcfService {
            get
            {
                if (myWcfService == null)
                {
                    myWcfService = new MyWcfService();
                }
                return myWcfService;
            }
        }
        public static KeyInfo ValidKeyInfo { get; internal set; }
        public static string FacName { get; internal set; }
    }
}
