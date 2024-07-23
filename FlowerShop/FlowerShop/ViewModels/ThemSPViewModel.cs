using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ThemSPViewModel
    {
        
        [DisplayName("Tên sản phẩm")]
        public string FlowerName { get; set; }
        [Required(ErrorMessage = "Không được bỏ trống số lượng")]
        [DisplayName("Số lượng")]
        public int? FlowerQuantity { get; set; }
        //[Required(ErrorMessage = "Không được bỏ trống khuyến mãi")]
        [DisplayName("Khuyến mãi")]
        public double? FlowerDiscount { get; set; }
        //[Required(ErrorMessage = "Không được bỏ trống đơn giá")]
        [DisplayName("Đơn giá")]
        public int? FlowerPrice { get; set; }
        //[Required(ErrorMessage = "Chưa chọn hình sản phẩm")]
        [DisplayName("Hình sản phẩm")]
        public string FlowerPicture { get; set; }
        //[Required(ErrorMessage = "Không được bỏ trống miêu tả")]
        [DisplayName("Mô tả")]
        public string FlowerDiscription { get; set; }
        [DisplayName("Trạng thái")]
        public bool? FlowerStatus { get; set; }
        [DisplayName("Sản phẩm mới")]
        public bool? FlowerNew { get; set; }
        //[Required(ErrorMessage = "Không được bỏ trống đơn vị tính")]
        [DisplayName("Đơn vị tính")]
        public string FlowerDVT { get; set; }
        
        public List<TopicViewModel> SelectedTopics { get; set; }

        [DisplayName("Ngày tạo")]
        public DateTime? CreateDate { get; set; }
        [DisplayName("Tên chủ đề")]
        [StringLength(250)]
        public string TopicName { get; set; }
        public HttpPostedFileBase FlowerPictureFile { get; set; }

        public List<HttpPostedFileBase> PictureList { get; set; }
    }
}