namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Topic
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Topic()
        {
            Topics_Flowers = new HashSet<Topics_Flowers>();
        }

        public int TopicID { get; set; }
        [DisplayName("Tên chủ đề")]
        [StringLength(250)]
        public string TopicName { get; set; }

        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Topics_Flowers> Topics_Flowers { get; set; }
    }
}
