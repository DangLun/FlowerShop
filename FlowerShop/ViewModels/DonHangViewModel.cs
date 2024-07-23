using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class DonHangViewModel
    {
        [DisplayName("Mã đơn hàng")]
        public int OrderID { get; set; }
        [DisplayName("Ngày tạo")]
        public DateTime? CreateDate { get; set; }
        [Required(ErrorMessage = "Tên khách hàng là bắt buộc")]
        [DisplayName("Tên khách hàng")]
        public string Fullname { get; set; }
        [Required(ErrorMessage = "Địa chỉ là bắt buộc")]
        [DisplayName("Địa chỉ")]
        public string DeliveryName { get; set; }
        [DisplayName("Trạng thái")]
        public string Status { get; set; }
        [DisplayName("Tổng tiền")]
        public decimal TotalAmount { get; set; }
        [Required(ErrorMessage = "Địa chỉ là bắt buộc")]
        [DisplayName("Địa chỉ")]
        public string Address { get; set; }

    }
    
}