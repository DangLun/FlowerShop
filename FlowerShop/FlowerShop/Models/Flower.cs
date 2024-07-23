namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Flower
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Flower()
        {
            Carts = new HashSet<Cart>();
            Topics_Flowers = new HashSet<Topics_Flowers>();
            Images = new HashSet<Image>();
            OrderDetails = new HashSet<OrderDetail>();
        }

        public int FlowerID { get; set; }

        [StringLength(250)]
        public string FlowerName { get; set; }

        public int? FlowerQuantity { get; set; }

        public double? FlowerDiscount { get; set; }

        public int? FlowerPrice { get; set; }

        [StringLength(250)]
        public string FlowerPicture { get; set; }

        [StringLength(4000)]
        public string FlowerDiscription { get; set; }

        public bool? FlowerStatus { get; set; }

        public bool? FlowerNew { get; set; }

        [StringLength(50)]
        public string FlowerDVT { get; set; }

        public DateTime? CreateDate { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Cart> Carts { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Topics_Flowers> Topics_Flowers { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Image> Images { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<OrderDetail> OrderDetails { get; set; }
    }
}
