namespace FlowerShop.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    public partial class Image
    {
        public int ImageID { get; set; }

        [StringLength(250)]
        public string ImageUrl { get; set; }

        public int FlowerID { get; set; }

        public virtual Flower Flower { get; set; }
    }
}
