using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ChartViewModel
    {
        public List<string> Labels { get; set; }
        public List<double> Data { get; set; }
    }
}