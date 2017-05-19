using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace VhiecleApp.Util
{
    class CDKeyUtil
    {
        public static bool CheckPass(string pwd)
        {
            if (string.IsNullOrEmpty(pwd))
            {
                return false;
            }
            else
            {
                Regex reg = new Regex(@"^[a-zA-Z][0-9a-zA-Z]{4}-[a-zA-Z][0-9a-zA-Z]{4}-[a-zA-Z][0-9a-zA-Z]{4}-[a-zA-Z][0-9a-zA-Z]{4}$");
                return reg.IsMatch(pwd);
            }
        }
    }
}
