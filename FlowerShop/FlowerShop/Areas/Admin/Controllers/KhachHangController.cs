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
    public class KhachHangController : Controller
    {
        // GET: Admin/KhachHang
        FlowerShopDbContext kn = new FlowerShopDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ContentKH(string searchString, int? page)

        {
            //List<Accounts> accounts = new List<Accounts>();
            //accounts = kn.Accounts.ToList();
            //return View(accounts);
            int pageSize = 10; // Số mục trên mỗi trang
            int pageNumber = (page ?? 1); // Trang hiện tại, mặc định là trang 1 nếu không có tham số page

            var customer = kn.Customers.AsQueryable();

            // Tìm kiếm nếu có chuỗi tìm kiếm
            if (!string.IsNullOrEmpty(searchString))
            {
                customer = customer.Where(t => t.CustomerName.Contains(searchString) || t.CustomerEmail.Contains(searchString));
            }

            var model = customer.OrderByDescending(cs=>cs.CustomerID).ToList();

            // Lấy số lượng tổng cộng của các mục và tính toán số trang
            ViewBag.TotalPages = (int)Math.Ceiling((double)model.Count / pageSize);

            // Lấy chỉ mục của các mục hiển thị trên trang hiện tại
            model = model.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.PageNumber = pageNumber; // Lưu trữ số trang hiện tại để sử dụng cho phân trang

            ViewBag.SearchString = searchString; // Lưu chuỗi tìm kiếm để hiển thị lại trong form tìm kiếm

            return View(model);
        }
        public ActionResult ThemKH()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ThemKH(ThemKHViewModel customers)
        {
            using (var transaction = kn.Database.BeginTransaction())
            {
                try
                {
                    Customer cs = new Customer();
                    cs.CustomerName = customers.CustomerName;
                    cs.CustomerEmail = customers.CustomerEmail;
                    cs.CustomerPhone = customers.CustomerPhone;
                    cs.CustomerAvatar = customers.CustomerAvatar;

                    if (customers.CustomerPictureFile != null && customers.CustomerPictureFile.ContentLength > 0)
                    {
                        string fileName = Path.GetFileName(customers.CustomerPictureFile.FileName);
                        string path = Path.Combine(Server.MapPath("~/Assets/Images"), fileName);
                        customers.CustomerPictureFile.SaveAs(path);

                        // Save the file path to the database
                        cs.CustomerAvatar = fileName; // Adjust the path as needed
                    }

                    kn.Customers.Add(cs);
                    kn.SaveChanges();

                    Account ac = new Account();
                    ac.Username = customers.Username;
                    ac.QuantityLog = 0;
                    ac.Password = customers.Password;
                    ac.CreateDate = DateTime.Now;
                    ac.Status = true;
                    ac.TypeAccountID = 2;
                    ac.LogDate = null;
                    ac.CustomerID = cs.CustomerID;
                    kn.Accounts.Add(ac);
                    kn.SaveChanges();

                    transaction.Commit();
                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    ViewBag.Error = ex.InnerException?.Message ?? ex.Message;
                    return View(customers);
                }
            }
            return RedirectToAction("ContentKH");
        }

        public ActionResult Edit(int id)
        {
            //Customers cs = new Customers();
            //cs = kn.Customers.SingleOrDefault(x => x.CustomerID == id);
            Customer customers = kn.Customers.FirstOrDefault(f => f.CustomerID == id);
            ThemKHViewModel cs = new ThemKHViewModel();

            cs.CustomerPhone = customers.CustomerPhone;
            cs.CustomerEmail = customers.CustomerEmail;
            cs.CustomerName = customers.CustomerName;
            if (!string.IsNullOrEmpty(customers.CustomerAvatar))
            {
                cs.CustomerAvatar = customers.CustomerAvatar;
            }
            //kn.SaveChanges();
            //return RedirectToAction("ContentKH", "KhachHang");
            return View(cs);
           
        }
        [HttpPost]
        public ActionResult Edit(int id, ThemKHViewModel customer)
        {
            Customer cs = kn.Customers.FirstOrDefault(c => c.CustomerID == id);
            //cs = kn.Customers.SingleOrDefault(x => x.CustomerID == id);
            cs.CustomerPhone = customer.CustomerPhone;
            cs.CustomerEmail = customer.CustomerEmail;
            cs.CustomerName = customer.CustomerName;

            if (customer.CustomerPictureFile != null && customer.CustomerPictureFile.ContentLength > 0)
            {
                string fileName = Path.GetFileName(customer.CustomerPictureFile.FileName);
                string path = Path.Combine(Server.MapPath("~/Assets/Images"), fileName);
                customer.CustomerPictureFile.SaveAs(path);

                // Save the file path to the database
                cs.CustomerAvatar = fileName; // Adjust the path as needed
            }

            kn.SaveChanges();
            return RedirectToAction("ContentKH");

        }
        public ActionResult Delete(int id)
        {
            Customer cs = new Customer();
            cs = kn.Customers.SingleOrDefault(x => x.CustomerID == id);
            return View(cs);
           
        }
        [HttpPost]
        public ActionResult Delete(int id, Customer customers)
        {
            Customer cs = new Customer();
            cs = kn.Customers.SingleOrDefault(x => x.CustomerID == id);
            kn.Customers.Remove(cs);
            kn.SaveChanges();
            return RedirectToAction("ContentKH", "KhachHang"); 
            
        }
        public ActionResult DetailKH(int id)
        {
            var data = kn.Customers.SingleOrDefault(x => x.CustomerID == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
        // Action to export customers to Excel
        public ActionResult ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            List<Customer> customers = kn.Customers.ToList();

            using (ExcelPackage package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Customers");

                worksheet.Cells[1, 1].Value = "Customer ID";
                worksheet.Cells[1, 2].Value = "Customer Name";
                worksheet.Cells[1, 3].Value = "Customer Email";
                worksheet.Cells[1, 4].Value = "Customer Phone";
                worksheet.Cells[1, 5].Value = "Customer Avatar";

                int row = 2;
                foreach (var customer in customers)
                {
                    worksheet.Cells[row, 1].Value = customer.CustomerID;
                    worksheet.Cells[row, 2].Value = customer.CustomerName;
                    worksheet.Cells[row, 3].Value = customer.CustomerEmail;
                    worksheet.Cells[row, 4].Value = customer.CustomerPhone;
                    worksheet.Cells[row, 5].Value = customer.CustomerAvatar;
                    row++;
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                var stream = new MemoryStream();
                package.SaveAs(stream);
                stream.Position = 0;

                string fileName = "Customers.xlsx";

                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }
    }
    
}