using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ThemKHViewModel
    {
        [Required(ErrorMessage = "Không được bỏ trống tên tài khoản")]
        //[UniqueUsername(ErrorMessage = "Không được bỏ trống tên khách hàng")]
        
        [DisplayName("Tên tài khoản")]
        public string Username { get; set; }
        [Required(ErrorMessage = "Không được bỏ trống mật khẩu")]
        [DisplayName("Mật khẩu")]
        public string Password { get; set; }
        [Required(ErrorMessage = "Không được bỏ trống tên khách hàng")]
        [DisplayName("Tên khách hàng")]
        public string CustomerName { get; set; }
        [DisplayName("Số điện thoại")]
        [Required(ErrorMessage = "Số điện thoại là bắt buộc")]
        [RegularExpression(@"^\d{1,10}$", ErrorMessage = "Số điện thoại không được nhập chữ và không quá 10 số")]
        public string CustomerPhone { get; set; }
        [Required(ErrorMessage = "Chưa chọn ảnh")]
        [DisplayName("Ảnh")]
        public string CustomerAvatar { get; set; }
        [Required(ErrorMessage = "Không được bỏ trống email")]
        [DisplayName("Email")]
        public string CustomerEmail { get; set; }

        public int CustomerID { get; set; }
        public HttpPostedFileBase CustomerPictureFile { get; set; }
    }
}