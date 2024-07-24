using FlowerShop.CustomValidations;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    [IsValidPassword]
    public class ChangepasswordViewModel
    {
        public string Username { get; set; }
        [DisplayName("Mật khẩu cũ")]
        [Required(ErrorMessage = "Không được để trống mật khẩu cũ")]
        public string oldPassword { get; set; }
        [DisplayName("Mật khẩu mới")]
        [Required(ErrorMessage = "Không được để trống mật khẩu mới")]
        [MinLength(8, ErrorMessage = "Độ dài mật khẩu ít nhất 8 kí tự")]
        public string newPassword { get; set; }
        [DisplayName("Nhập lại mật khẩu mới")]
        [Required(ErrorMessage = "Không được để trống nhập lại mật khẩu mới")]
        [Compare("newPassword", ErrorMessage = "Nhập lại mật khẩu mới không khớp")]
        public string confirmNewPassword { get; set; }
    }
}