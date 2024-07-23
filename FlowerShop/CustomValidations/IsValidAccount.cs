using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.CustomValidations
{
    public class IsValidAccount : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if(value != null)
            {
                AccountViewModel account = value as AccountViewModel; 
                FlowerShopDbContext db = new FlowerShopDbContext(); 
                var ac = db.Accounts.SingleOrDefault(x => x.Username == account.Username && x.Password == account.Password);
                if (ac == null)
                {
                    return new ValidationResult("Sai tài khoản hoặc mật khẩu");
                }
            }
            return ValidationResult.Success;
        }
    }
}