namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Order
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Order()
        {
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int OrderID { get; set; }
        [DisplayName("Ngày tạo")]
        public DateTime? CreateDate { get; set; }

        [DisplayName("Trạng thái")]
        [StringLength(10)]
        public string Status { get; set; }

        public int? CustomerID { get; set; }

        public int? DeliveryID { get; set; }

        public virtual Customer Customer { get; set; }

        public virtual Delivery Delivery { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
