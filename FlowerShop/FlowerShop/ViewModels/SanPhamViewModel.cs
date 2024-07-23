using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class SanPhamViewModel
    {
        [DisplayName("Tên sản phẩm")]
        public string FlowerName { get; set; }
        [DisplayName("Số lượng")]
        public int? Quantity { get; set; }
        [DisplayName("Đơn giá")]
        public int? FlowerPrice { get; set; }
        [DisplayName("Giảm giá")]
        public double? FlowerDiscount { get; set; }
        [DisplayName("Tổng tiền sản phẩm")]
        public int Subtotal { get; set; }
    }
}