using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class RequestResultVNPAYViewModel
    {
        public string Message { get; set; }
        public string terminalID { get; set; }
        public string orderID { get; set; }
        public string vnpayTranId { get; set; }
        public string vnp_Amount { get; set; }
        public string bankCode {  get; set; }
    }
}