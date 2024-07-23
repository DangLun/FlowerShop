using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class AccountGoogleViewModel
    {
        public string sub {  get; set; }
        public string name { get; set; }
        public string given_name { get; set; }
        public string family_name { get; set; }
        public string picture { get; set; }
        public string email { get; set; }
        public bool email_verified { get; set; }
    }
}