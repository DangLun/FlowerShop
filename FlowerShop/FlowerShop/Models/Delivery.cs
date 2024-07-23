namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Delivery
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Delivery()
        {
            Orders = new HashSet<Order>();
        }

        [Key]
        public int DeliveriyID { get; set; }
        [DisplayName("Địa chỉ")]
        [StringLength(250)]
        public string DeliveryName { get; set; }

        public bool DeliveryMain { get; set; }

        public int? CustomerID { get; set; }

        [StringLength(250)]
        public string FullName { get; set; }

        [StringLength(11)]
        public string Phone { get; set; }

        public virtual Customer Customer { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Order> Orders { get; set; }
    }
}
