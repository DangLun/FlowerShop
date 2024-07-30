using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class HomeViewModel
    {
        public List<Flower> Flowers { get; set; }
        public List<Banner> Banners { get; set; }
    }
}