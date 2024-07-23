using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class UserAddressViewModel
    {
        public int DeliveriyID { get; set; }

        public string DeliveryName { get; set; }

        public bool DeliveryMain { get; set; }

        public string CustomerName { get; set; }

        public string CustomerPhone { get; set; }

        public string FullName { get; set; }

        public string Phone { get; set; }
    }
}