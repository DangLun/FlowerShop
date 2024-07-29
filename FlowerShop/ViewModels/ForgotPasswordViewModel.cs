using FlowerShop.CustomValidations;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ForgotPasswordViewModel
    {
        [Required(ErrorMessage = "Không được bỏ trống Email")]
        [RegularExpression(@"^[^@\s]+@[^@\s]+\.[^@\s]+$", ErrorMessage = "Vui lòng nhập đúng định dạng Email")]
        [CheckEmail]
        public string Email { get; set; }
    }
}