using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class InfoUserViewModel
    {
        public CustomerViewModel customerviewmodel { get; set; }
        public List<OrderUserViewModel> orderUserViewModels { get; set; }
        public List<UserAddressViewModel> listAddress {  get; set; }
        public DeliveryInfoViewModel delivery { get; set; }
    }
}