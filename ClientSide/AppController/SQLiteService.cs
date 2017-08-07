using AppController.Util;
using System.Data.SQLite;
using System.Data;

namespace AppController
{
    internal class SQLiteService
    {
        SQLiteConnection conn;

        internal SQLiteConnection Conn {
            get { return conn; }
            //set { conn = value; }
        }

        internal ConnectionState ConnectToDB(string filename)
        {

            conn = SQLiteUtil.ConnectToDB(filename);
            return conn.State;
        }

        internal string JsonOfSQL(string sql)
        {
            return SQLiteUtil.GetTableFromSqlite(conn, sql);
        }
    }
}