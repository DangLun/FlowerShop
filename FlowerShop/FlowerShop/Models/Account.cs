namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Account
    {
        public int AccountID { get; set; }
        [DisplayName("Tên tài khoản")]
        [Required]
        [StringLength(100)]
        public string Username { get; set; }
        [DisplayName("Mật khẩu")]
        [Required]
        [StringLength(100)]
        public string Password { get; set; }
        [DisplayName("Ngày tạo")]
        public DateTime? CreateDate { get; set; }
        [DisplayName("Số lần đăng nhập")]
        public int? QuantityLog { get; set; }
        [DisplayName("Lần đăng nhập gần nhất")]
        public DateTime? LogDate { get; set; }
        [DisplayName("Trạng thái")]
        public bool? Status { get; set; }
        [DisplayName("Quyền")]
        public int? TypeAccountID { get; set; }

        public int? CustomerID { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual TypeAccount TypeAccount { get; set; }
    }
}
