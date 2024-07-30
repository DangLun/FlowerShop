using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.CustomValidations
{
    public class IsValidEmail : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                string email = value as string; 
                FlowerShopDbContext db = new FlowerShopDbContext();
                var e = db.Customers.FirstOrDefault(x => x.CustomerEmail == email);    
                if (e != null)
                {
                    return new ValidationResult("Email đã có tài khoản");
                }
            }
            return ValidationResult.Success;
        }
    }
}