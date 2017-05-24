using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

using TransService;

namespace TransService
{
    // NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "Service1" in code, svc and config file together.
    // NOTE: In order to launch WCF Test Client for testing this service, please select Service1.svc or Service1.svc.cs at the Solution Explorer and start debugging.
    public class Service1 : IService1
    {
        public string GetNameByID(int id)
        {
            string name;
            using (var db = new TransData())
            {
                var entity = db.MyEntities.Where(c => c.Id == id);
                if (entity.Count() != 0)
                {
                     name = entity.ElementAt(0).Name;
                }
                else
                {
                    name =  "NULL";
                }
            }
            return string.Format("You get: id = {0} name = {1}", id, name);
        }

        public MyEntity[] GetTransByID(int id)
        {
            using (var db = new TransData())
            {
                var entity = db.MyEntities.Where(c => c.Id == id);
                return entity.ToArray();
            }
        }

        public string WriteNameWithID(int id, string name)
        {
            using (var db = new TransData())
            {
                db.MyEntities.Add(new MyEntity()
                {
                    Id = id,
                    Name = name
                });
                db.SaveChanges();
            }
            
            return string.Format("You wrote: id = {0}, name = {1}", id ,  name);
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
