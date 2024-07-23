using FlowerShop.CustomValidations;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class RegisterFormViewModel
    {
        [Required(ErrorMessage = "Không được để trống tên tài khoản")]
        [DisplayName("Tài khoản")]
        [IsValidUsername]
        public string Username { get; set; }

        [Required(ErrorMessage = "Không được để trống mật khẩu")]
        [DisplayName("Mật khẩu")]
        [MinLength(8, ErrorMessage = "Độ dài mật khẩu ít nhất 8 kí tự")]
        public string Password { get; set; }

        [Required(ErrorMessage = "Không được để trống nhập lại mật khẩu")]
        [DisplayName("Nhập lại mật khẩu")]
        [MinLength(8, ErrorMessage = "Độ dài mật khẩu ít nhất 8 kí tự")]
        [Compare("Password", ErrorMessage = "Nhập lại mật khẩu không trùng với mật khẩu")]
        public string RePassword { get; set; }

        [Required(ErrorMessage = "Không được để trống họ và tên")]
        [DisplayName("Họ và tên")]
        [StringLength(250, ErrorMessage = "Độ dài tối đa 250 kí tự")]
        public string CustomerName { get; set; }

        [Required(ErrorMessage = "Không được để trống số điện thoại")]
        [DisplayName("Số điện thoại")]
        [StringLength(10, ErrorMessage = "Độ dài số điện thoại là 10 kí tự")]
        [RegularExpression(@"^\d{10}$", ErrorMessage = "Vui lòng nhập đúng định dạng số điện thoại")]
        public string CustomerPhone { get; set; }

        [StringLength(250)]
        public string CustomerAvatar { get; set; }

        [Required(ErrorMessage = "Không được để trống Email")]
        [DisplayName("Email")]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", ErrorMessage = "Vui lòng nhập đúng định dạng Email")]
        [StringLength(100)]
        [IsValidEmail]
        public string CustomerEmail { get; set; }
    }
}