using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class CartItemViewModel
    {
        public int CustomerID { get; set; }
        public bool IsChecked { get; set; }
        public int FlowerID { get; set; }
        public string FlowerName { get; set; }
        public string FlowerDVT { get; set; }
        public int FlowerPrice { get; set; }
        public int FlowerQuantity { get; set; }
        public int TotalQuantity { get; set; }
        public double FlowerDiscount { get; set; }
        public string FlowerPicture { get; set; }
    }
}