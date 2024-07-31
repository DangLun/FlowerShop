using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class BannerViewModel {
        public int BannerID { get; set; }
        public string BannerName {  get; set; }
        public HttpPostedFileBase BannerPictureFile { get; set; }
    }
}