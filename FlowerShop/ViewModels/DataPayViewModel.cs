using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class DataPayViewModel
    {
        public List<CartItemViewModel> CartItems { get; set; }
        public CustomerViewModel customer { get; set; }
        public bool IsPaymentOnVNPAY { get; set; }
    }
}