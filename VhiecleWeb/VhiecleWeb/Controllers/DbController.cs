using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using VhiecleWeb.Models;


namespace VhiecleWeb.Controllers
{
    public class DbController : Controller
    {
        // GET: Db
        public ActionResult Index()
        {
            ServiceReference1.Service1Client srvDataTrans = new ServiceReference1.Service1Client();
            //string status = srvDataTrans.WriteNameWithID(1, "Cola");

            //status += srvDataTrans.GetNameByID(2);

            var trans = srvDataTrans.GetTransByID(2);

            return View(trans.ToList());
        }
    }
}