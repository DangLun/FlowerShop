using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class RequestOrderVNPAYViewModel
    {
        public long OrderID { get; set; }    
        public double Amount { get; set; } 
        public string Status { get; set; }
        public DateTime CreateDate { get; set; }    
    }
}