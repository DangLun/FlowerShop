using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.Models
{
    public partial class Banner
    {
        public int BannerID { get; set; }
        [StringLength(200)]
        [DisplayName("Banner URL")]
        public string BannerName { get; set; }
    }
}