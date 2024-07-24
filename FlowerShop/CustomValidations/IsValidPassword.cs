using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.CustomValidations
{
    public class IsValidPassword : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                ChangepasswordViewModel model = value as ChangepasswordViewModel;
                FlowerShopDbContext db = new FlowerShopDbContext();
                var e = db.Accounts.FirstOrDefault(a => a.Username == model.Username && a.Password == model.oldPassword);
                if (e == null)
                {
                    return new ValidationResult("Mật khẩu cũ không đúng");
                }
            }
            return ValidationResult.Success;
        }
    }
}