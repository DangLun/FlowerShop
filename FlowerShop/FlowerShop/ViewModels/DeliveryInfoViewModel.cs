using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace FlowerShop.ViewModels
{
    public class DeliveryInfoViewModel
    {
        public int DeliveriyID { get; set; }
        [DisplayName("Tên địa chỉ giao hàng")]
        public string DeliveryName { get; set; }
        [DisplayName("Đặt làm địa chỉ mặc định")]
        public bool DeliveryMain { get; set; }
        [DisplayName("Tên người nhận")]
        public string Fullname {  get; set; }
        [StringLength(11)]
        [DisplayName("Số điện thoại")]
        public string Phone { get; set; }
    }
}