using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.CustomValidations
{
    public class CheckEmail : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                string email = value as string;
                FlowerShopDbContext db = new FlowerShopDbContext();
                var e = (from ac in db.Accounts join cs in db.Customers on ac.CustomerID equals cs.CustomerID where cs.CustomerEmail == email select cs).FirstOrDefault();
                if (e == null)
                {
                    return new ValidationResult("Email chưa được tạo tài khoản hoặc được đăng nhập bằng Google");
                }
            }
            return ValidationResult.Success;
        }
    }
}