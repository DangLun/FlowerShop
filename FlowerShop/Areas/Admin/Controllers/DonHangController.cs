using FlowerShop.Models;
using FlowerShop.ViewModels;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class DonHangController : Controller
    {
        // GET: Admin/DonHang
        FlowerShopDbContext kn = new FlowerShopDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DonHang(int? page, string searchString)
        {
            var orders = (from o in kn.Orders
                          join c in kn.Customers on o.CustomerID equals c.CustomerID
                          join od in kn.OrderDetails on o.OrderID equals od.OrderID
                          join f in kn.Flowers on od.FlowerID equals f.FlowerID
                          join d in kn.Deliveries on o.DeliveryID equals d.DeliveriyID
                          group new { o, od, f, d } by new
                          {
                              o.OrderID,
                              o.CreateDate,
                              d.FullName,
                              o.Status,
                              d.DeliveryName
                          } into g
                          select new DonHangViewModel
                          {
                              OrderID = g.Key.OrderID,
                              CreateDate = g.Key.CreateDate,
                              Fullname = g.Key.FullName,
                              Status = g.Key.Status,
                              DeliveryName = g.Key.DeliveryName,
                              TotalAmount = g.Sum(x => (int)(x.od.Quantity * x.f.FlowerPrice * (1 - (x.f.FlowerDiscount / 100))))
                          }).OrderByDescending(od=>od.OrderID).ToList();

            // Tìm kiếm
            if (!String.IsNullOrEmpty(searchString))
            {
                orders = orders.Where(o => o.Fullname.Contains(searchString)
                                         || o.Address.Contains(searchString)
                                         || o.Status.Contains(searchString)).ToList();
            }

            // Phân trang
            int pageSize = 10; // Số lượng item trên mỗi trang
            int pageNumber = (page ?? 1); // Trang hiện tại (mặc định là trang 1)
            List<DonHangViewModel> pagedOrders = orders.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.SearchString = searchString;
            ViewBag.PageNumber = pageNumber;
            ViewBag.TotalPages = (int)Math.Ceiling((double)orders.Count / pageSize);

            return View(pagedOrders);
        }
        public ActionResult DeleteDH(int id)
        {
            Order o = new Order();
            o = kn.Orders.SingleOrDefault(x => x.OrderID == id);
            return View(o);
        }
        [HttpPost]
        public ActionResult DeleteDH(int id, Order orders)
        {
            Order o = new Order();
            o = kn.Orders.SingleOrDefault(x => x.OrderID == id);
            kn.Orders.Remove(o);
            kn.SaveChanges();

            return RedirectToAction("DonHang", "DonHang");
        }
        public ActionResult DetailDH(int id)
        {
            var orderDetails = (from o in kn.Orders
                                join c in kn.Customers on o.CustomerID equals c.CustomerID
                                join d in kn.Deliveries on c.CustomerID equals d.CustomerID
                                join od in kn.OrderDetails on o.OrderID equals od.OrderID
                                join f in kn.Flowers on od.FlowerID equals f.FlowerID
                                where o.OrderID == id
                                group new { o, c, d, od, f } by new
                                {
                                    o.OrderID,
                                    o.CreateDate,
                                    c.CustomerName,
                                    d.DeliveryName,
                                    d.Phone,
                                    d.FullName
                                } into g
                                select new ChiTietDonHangViewModel
                                {
                                    OrderID = g.Key.OrderID,
                                    CreateDate = g.Key.CreateDate,
                                    CustomerName = g.Key.CustomerName,
                                    DeliveryName = g.Key.DeliveryName,
                                    Phone = g.Key.Phone,
                                    Fullname = g.Key.FullName,
                                    Products = g.Select(x => new SanPhamViewModel
                                    {
                                        FlowerName = x.f.FlowerName,
                                        Quantity = x.od.Quantity,
                                        FlowerPrice = x.f.FlowerPrice,
                                        FlowerDiscount = x.f.FlowerDiscount,
                                        Subtotal = (int)(x.od.Quantity * x.f.FlowerPrice * (1 - ((double)x.f.FlowerDiscount / 100)))
                                    }).ToList(),
                                    TotalAmount = (int)g.Sum(x => (double)x.od.Quantity * (double)x.f.FlowerPrice * (1 - ((double)x.f.FlowerDiscount / 100)))
                                }).FirstOrDefault();

            if (orderDetails == null)
            {
                return HttpNotFound();
            }

            return View(orderDetails);
        }
        public ActionResult ApproveDH(int id)
        {
            Order o = kn.Orders.SingleOrDefault(x => x.OrderID == id);
            if (o == null)
            {
                return HttpNotFound();
            }

            // Chỉnh sửa trạng thái đơn hàng thành đã duyệt (ví dụ: Status = "Approved")
            o.Status = "Delivery";
            kn.SaveChanges();

            // Redirect về trang danh sách đơn hàng
            return RedirectToAction("DonHang", "DonHang");
        }
        // Action to export orders to Excel
        public ActionResult ExportToExcel()
        {
            // Set EPPlus license context
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            // Get orders data
            var orders = (from o in kn.Orders
                          join c in kn.Customers on o.CustomerID equals c.CustomerID
                          join od in kn.OrderDetails on o.OrderID equals od.OrderID
                          join f in kn.Flowers on od.FlowerID equals f.FlowerID
                          join d in kn.Deliveries on c.CustomerID equals d.CustomerID // Join with Deliveries via Customers table
                          group new { o, c, od, f, d } by new
                          {
                              o.OrderID,
                              o.CreateDate,
                              d.FullName,
                              d.DeliveryName,
                              o.Status
                          } into g
                          select new DonHangViewModel
                          {
                              OrderID = g.Key.OrderID,
                              CreateDate = g.Key.CreateDate,
                              Fullname = g.Key.FullName,
                              DeliveryName = g.Key.DeliveryName,
                              Status = g.Key.Status,
                              TotalAmount = (int)g.Sum(x => (double)x.od.Quantity * (double)x.f.FlowerPrice * (1 - ((double)x.f.FlowerDiscount / 100)))
                          }).ToList();

            // Create Excel package
            using (ExcelPackage package = new ExcelPackage())
            {
                // Add a new worksheet
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Orders");

                // Headers
                worksheet.Cells[1, 1].Value = "Order ID";
                worksheet.Cells[1, 2].Value = "Create Date";
                worksheet.Cells[1, 3].Value = "Customer Name";
                worksheet.Cells[1, 4].Value = "Delivery Name";
                worksheet.Cells[1, 5].Value = "Status";
                worksheet.Cells[1, 6].Value = "Total Amount";

                // Data
                int row = 2;
                foreach (var order in orders)
                {
                    worksheet.Cells[row, 1].Value = order.OrderID;
                    worksheet.Cells[row, 2].Value = order.CreateDate.Value.ToString("yyyy/MM/dd HH:mm:ss"); // Ensure CreateDate is DateTime
                    worksheet.Cells[row, 3].Value = order.Fullname;
                    worksheet.Cells[row, 4].Value = order.DeliveryName;
                    worksheet.Cells[row, 5].Value = order.Status;
                    worksheet.Cells[row, 6].Value = order.TotalAmount;
                    row++;
                }

                // Auto-fit columns for better readability
                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                // Prepare Excel file stream
                var stream = new MemoryStream();
                package.SaveAs(stream);
                stream.Position = 0;

                // Return the Excel file as a FileContentResult
                string fileName = "Orders.xlsx";
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }

    }
}
