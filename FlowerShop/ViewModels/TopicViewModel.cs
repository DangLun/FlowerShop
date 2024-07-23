using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class TopicViewModel
    {
        public int TopicID { get; set; }
        public string TopicName { get; set; }
        public bool IsChecked {  get; set; }
    }
}