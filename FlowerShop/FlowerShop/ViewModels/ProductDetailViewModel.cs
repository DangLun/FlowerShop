using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ProductDetailViewModel
    {
        public Flower flower {  get; set; }
        public List<Flower> flowerRelates { get; set; }
    }
}