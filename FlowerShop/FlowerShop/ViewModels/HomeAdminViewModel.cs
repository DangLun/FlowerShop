using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace FlowerShop.ViewModels
{
    public class HomeAdminViewModel
    {
        public double TotalIncome { get; set; }
        public double TotalIncomeInMonth { get; set; }
        public int TotalCustomer {  get; set; }
        public int TotalCustomerInMonth {  get; set; }
        public int TotalOrder { get; set; }
        public int TotalOrderInMonth {  get; set; }
        public List<ChartViewModel> Charts { get; set; }
    }
}