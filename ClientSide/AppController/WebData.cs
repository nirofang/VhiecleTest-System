using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AppController
{

    public class Customer
    {
        public string _id { get; set; }
        public int CustomerId { get; set; }
        public int __v { get; set; }
        public string target { get; set; }
        public string Desp { get; set; }
        public string ValidDate { get; set; }
        public string MachineStatus { get; set; }
        public string LastLogTime { get; set; }
        public string CreationDate { get; set; }
        public string CDKey { get; set; }
        public string MachineCode { get; set; }
        public string CustomerName { get; set; }
        public string WebCommand { get; set; }
    }

    public class NewCustomer
    {
        public List<Customer> result { get; set; }
    }

    public class UpdateResult
    {
        public int n { get; set; }
        public int nModified { get; set; }
        public int ok { get; set; }
    }

    public class UpdateDb
    {
        public UpdateResult result { get; set; }
    }

}
