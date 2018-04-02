using AppController.Util;
using AppWcfService;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.SQLite;

namespace AppController
{
    static class RegConfig
    {
        static SQLiteService mySQLiteService;

        public static SQLiteService MySQLiteService
        {
            get
            {
                if (mySQLiteService == null)
                {
                    SQLiteConnection conn = SQLiteUtil.ConnectToDB(SQLiteUtil.GetVehiecleDBPath());
                    if (conn!=null && conn.State == ConnectionState.Open)
                    {
                        mySQLiteService = new SQLiteService();
                        mySQLiteService.Conn = conn;
                    }
                    else
                    {
                        mySQLiteService = null;
                    }

                }
                return mySQLiteService;
            }
            set { }
        }

        static MyWcfService myWcfService;

        // Machine code
        public static string MachineCode { get; internal set; }
        // CDKey
        public static string Cdkey { get; internal set; }
        // InstallUserPath
        public static string InstallUserPath { get; internal set; }

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
        public static string KeyStatus { get; internal set; }
    }
}
