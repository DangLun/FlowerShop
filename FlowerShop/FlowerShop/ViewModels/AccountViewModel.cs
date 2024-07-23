using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel;
using System.Linq;
using System.Web;
using FlowerShop.CustomValidations;

namespace FlowerShop.ViewModels
{
    [IsValidAccount]
    public class AccountViewModel
    {
        public int AccountID { get; set; }

        [Required(ErrorMessage = "Không được để trống tên tài khoản")]
        [DisplayName("Tài khoản")]
        public string Username { get; set; }

        [Required(ErrorMessage = "Không được để trống mật khẩu")]
        [DisplayName("Mật khẩu")]
        public string Password { get; set; }
    }
}
