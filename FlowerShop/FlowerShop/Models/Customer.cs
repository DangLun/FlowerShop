namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Customer
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Customer()
        {
            Accounts = new HashSet<Account>();
            Carts = new HashSet<Cart>();
            Orders = new HashSet<Order>();
            Deliveries = new HashSet<Delivery>();
        }

        public int CustomerID { get; set; }
        [DisplayName("Tên khách hàng")]
        [StringLength(250)]
        public string CustomerName { get; set; }
        [DisplayName("Số điện thoại khách hàng")]
        [StringLength(11)]
        public string CustomerPhone { get; set; }
        [DisplayName("Ảnh đại diện")]
        [StringLength(250)]
        public string CustomerAvatar { get; set; }
        [DisplayName("Email")]
        [StringLength(100)]
        public string CustomerEmail { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Account> Accounts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cart> Carts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Delivery> Deliveries { get; set; }
    }
}
