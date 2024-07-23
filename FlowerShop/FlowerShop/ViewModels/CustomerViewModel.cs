using FlowerShop.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class CustomerViewModel
    {
        public int CustomerID { get; set; }

        [StringLength(250)]
        public string CustomerName { get; set; }

        [StringLength(11)]
        public string CustomerPhone { get; set; }

        [StringLength(250)]
        public string CustomerAvatar { get; set; }

        [StringLength(100)]
        public string CustomerEmail { get; set; }

        public int? SelectedDeliveryID {  get; set; }

        public ICollection<Delivery> Deliveries { get; set; }
    }
}