using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class AdminController : Controller
    {
        // GET: Admin/Admin
        private FlowerShopDbContext db = new FlowerShopDbContext(); 

        private double getTotalIncome()
        {
            double res = (double)(from o in db.Orders
                         join od in db.OrderDetails on o.OrderID equals od.OrderID
                         join f in db.Flowers on od.FlowerID equals f.FlowerID
                         where o.Status.Trim() == "Completed"
                         select od.Quantity * (f.FlowerPrice - (f.FlowerPrice * f.FlowerDiscount / 100))).Sum();
            return res;
        }

        private double getTotalIncomeInMonth(int month)
        {
            double res = (double)(from o in db.Orders
                                  join od in db.OrderDetails on o.OrderID equals od.OrderID
                                  join f in db.Flowers on od.FlowerID equals f.FlowerID
                                  where o.Status.Trim() == "Completed" && o.CreateDate.Value.Month == month
                                  select od.Quantity * (f.FlowerPrice - (f.FlowerPrice * f.FlowerDiscount / 100))).Sum();
            return res;
        }

        private int getTotalCustomer()
        {
            int res = db.Customers.Count();
            return res;
        }

        private int getTotalCustomerInMonth(int month)
        {
            return db.Accounts.Where(ac => ac.CreateDate.Value.Month == month).Count();
        }

        private int getTotalOrder()
        {
            return db.Orders.Count();
        }

        private int getTotalOrderInMonth(int month) {
            return db.Orders.Where(o => o.CreateDate.Value.Month == month).Count();
        }



        public ActionResult Index()
        {
            HomeAdminViewModel viewModel = new HomeAdminViewModel();

            viewModel.TotalIncome = getTotalIncome();
            viewModel.TotalIncomeInMonth = getTotalIncomeInMonth(DateTime.Now.Month);
            viewModel.TotalCustomer = getTotalCustomer();
            viewModel.TotalCustomerInMonth = getTotalCustomerInMonth(DateTime.Now.Month);
            viewModel.TotalOrder = getTotalOrder();
            viewModel.TotalOrderInMonth = getTotalOrderInMonth(DateTime.Now.Month);

            var incomeChartBar = (from o in db.Orders
                                  join od in db.OrderDetails on o.OrderID equals od.OrderID
                                  join f in db.Flowers on od.FlowerID equals f.FlowerID
                                  where o.Status.Trim() == "Completed"
                                  group new { od, f } by o.CreateDate.Value.Year into g
                                  select new
                                  {
                                      Year = g.Key,
                                      TotalAmount = g.Sum(x => x.od.Quantity * (x.f.FlowerPrice - (x.f.FlowerPrice * x.f.FlowerDiscount / 100)))
                                  }).ToList();
            var pieChartData = (from t in db.Topics
                                join tf in db.Topics_Flowers on t.TopicID equals tf.TopicID
                                join f in db.Flowers on tf.FlowerID equals f.FlowerID
                                group f by t.TopicName into g
                                select new
                                {
                                    TopicName = g.Key,
                                    TotalQuantity = g.Sum(f => f.FlowerQuantity)
                                }).ToList();
            // init
            viewModel.Charts = new List<ChartViewModel>();
            viewModel.Charts.Add(new ChartViewModel{ Data = new List<double>(), Labels = new List<string>()});
            viewModel.Charts.Add(new ChartViewModel { Data = new List<double>(), Labels = new List<string>()});
            // assign
            foreach (var item in incomeChartBar)
            {
                viewModel.Charts[0].Labels.Add(item.Year.ToString());
                viewModel.Charts[0].Data.Add((double)item.TotalAmount);
            }

            foreach(var item in pieChartData)
            {
                viewModel.Charts[1].Labels.Add(item.TopicName.ToString());
                viewModel.Charts[1].Data.Add((double)item.TotalQuantity);
            }
            return View(viewModel);
        }
    }
}