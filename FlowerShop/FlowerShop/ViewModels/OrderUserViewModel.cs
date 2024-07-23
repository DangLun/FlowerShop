using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class OrderUserViewModel
    {
        public int OrderID {  get; set; }
        public string FlowerName {  get; set; }
        public int FlowerID {  get; set; }
        public string FlowerPicture {  get; set; }
        public double FlowerDiscount {  get; set; }
        public double FlowerQuantity { get; set; }
        public int FlowerPrice {  get; set; }
        public DateTime? CreateDate {  get; set; }
        public string Status {  get; set; }
        public int CustomerID {  get; set; }
    }
}