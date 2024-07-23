namespace FlowerShop.ViewModels
{
    public class DeliveryViewModel
    {
        public int DeliveriyID { get; set; }

        public string DeliveryName { get; set; }

        public bool DeliveryMain { get; set; }

        public int? CustomerID { get; set; }

        public string FullName { get; set; }

        public string Phone { get; set; }
    }
}