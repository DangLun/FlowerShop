using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.CustomValidations
{
    public class IsValidUsername : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                string username = (string)value;    
                FlowerShopDbContext db = new FlowerShopDbContext();
                var ac = db.Accounts.SingleOrDefault(x => x.Username == username);
                if (ac != null)
                {
                    return new ValidationResult("Tên tài khoản đã tồn tại");
                }
            }
            return ValidationResult.Success;
        }
    }
}