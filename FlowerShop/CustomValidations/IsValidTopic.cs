using FlowerShop.Models;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace FlowerShop.CustomValidations
{
	public class IsValidTopic : ValidationAttribute
    {
        protected override ValidationResult IsValid(object value, ValidationContext validationContext)
        {
            if (value != null)
            {
                string topicName = value as string;
                FlowerShopDbContext db = new FlowerShopDbContext();
                var e = db.Topics.FirstOrDefault(x => x.TopicName == topicName);
                if (e != null)
                {
                    return new ValidationResult("Chủ đề đã tồn tại");
                }
            }
            return ValidationResult.Success;
        }
    }
}