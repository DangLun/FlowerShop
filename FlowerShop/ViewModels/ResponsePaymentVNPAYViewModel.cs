using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ResponsePaymentVNPAYViewModel
    {
        public string vnp_TmnCode { get; set; }
        public double vnp_Amount { get; set; }
        public string vnp_BankCode { get; set; }
        public string vnp_TransactionNo { get; set; }
        public string vnp_ResponseCode { get; set; }
        public string vnp_TransactionStatus { get; set; }
        public string vnp_TxnRef { get; set; }
        public string vnp_SecureHash { get; set; }
    }
}