using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class ChiTietDonHangViewModel
    {
        [DisplayName("Mã đơn hàng")]
        public int OrderID { get; set; }
        [DisplayName("Ngày tạo")]
        public DateTime? CreateDate { get; set; }
        [DisplayName("Tên khách hàng")]
        public string CustomerName { get; set; }
        [DisplayName("Địa chỉ giao")]
        public string DeliveryName { get; set; }
        [DisplayName("Số điện thoại")]
        public string Phone { get; set; }
        [DisplayName("Tên khách hàng")]
        public string Fullname { get; set; }
        public List<SanPhamViewModel> Products { get; set; }
        [DisplayName("Tổng tiền")]
        public int TotalAmount { get; set; }
    }
}