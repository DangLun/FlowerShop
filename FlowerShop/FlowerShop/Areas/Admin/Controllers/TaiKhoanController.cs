using FlowerShop.Models;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class TaiKhoanController : Controller
    {
        // GET: Admin/TaiKhoantopics
        FlowerShopDbContext kn = new FlowerShopDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ContentTK(string searchString, int? page)

        {
            //List<Accounts> accounts = new List<Accounts>();
            //accounts = kn.Accounts.ToList();
            //return View(accounts);
            int pageSize = 10; // Số mục trên mỗi trang
            int pageNumber = (page ?? 1); // Trang hiện tại, mặc định là trang 1 nếu không có tham số page

            var account = kn.Accounts.AsQueryable();

            // Tìm kiếm nếu có chuỗi tìm kiếm
            if (!string.IsNullOrEmpty(searchString))
            {
                account = account.Where(t => t.Username.Contains(searchString));
            }

            var model = account.OrderByDescending(ac => ac.AccountID).ToList();

            // Lấy số lượng tổng cộng của các mục và tính toán số trang
            ViewBag.TotalPages = (int)Math.Ceiling((double)model.Count / pageSize);

            // Lấy chỉ mục của các mục hiển thị trên trang hiện tại
            model = model.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.PageNumber = pageNumber; // Lưu trữ số trang hiện tại để sử dụng cho phân trang

            ViewBag.SearchString = searchString; // Lưu chuỗi tìm kiếm để hiển thị lại trong form tìm kiếm

            return View(model);
        }
        //public ActionResult ThemTK()
        //{
        //    return View();
        //}
        //[HttpPost]
        //public ActionResult ThemTK(Accounts account)
        //{
        //    kn.Accounts.Add(account);
        //    kn.SaveChanges();
        //    return RedirectToAction("ContentTK");
        //}
        public ActionResult EditTK(int id)
        {
            //var data = kn.Accounts.Single(x => x.AccountID == id);
            //return View(data);
            var data = kn.Accounts
                 .Include(a => a.Customer)
                 .Include(a => a.TypeAccount)
                 .Single(x => x.AccountID == id);

            ViewBag.Customers = kn.Customers.ToList();
            ViewBag.TypeAccounts = kn.TypeAccounts.ToList();
            return View(data);
        }
        [HttpPost]
        public ActionResult EditTK(int id, Account accounts)
        {
            //Accounts data = kn.Accounts.Single(x => x.AccountID == id);
            //data.Username = accounts.Username;
            //data.Password = accounts.Password;
            //data.TypeAccountID = accounts.TypeAccountID;
            //data.CustomerID = accounts.CustomerID;
            //data.LogDate = accounts.LogDate;
            //kn.SaveChanges();
            //return RedirectToAction("ContentTK", "TaiKhoan");
            if (ModelState.IsValid)
            {
                Account data = kn.Accounts.Single(x => x.AccountID == id);
                data.Username = accounts.Username;
                data.Password = accounts.Password;
                data.TypeAccountID = accounts.TypeAccountID;
                data.CustomerID = accounts.CustomerID;
                data.LogDate = accounts.LogDate; // Ensure LogDate is included here
                kn.SaveChanges();
                return RedirectToAction("ContentTK", "TaiKhoan");
            }
            ViewBag.Customers = kn.Customers.ToList();
            ViewBag.TypeAccounts = kn.TypeAccounts.ToList();
            return View(accounts);
        }
        public ActionResult DeleteTK(int id)
        {
            var data = kn.Accounts.Single(x => x.AccountID == id);
            return View(data);
        }
        [HttpPost]
        public ActionResult DeleteTK(int id, Account accounts)
        {
            Account data = kn.Accounts.Single(x => x.AccountID == id);
            kn.Accounts.Remove(data);

            kn.SaveChanges();
            return RedirectToAction("ContentTK", "TaiKhoan");
        }
        public ActionResult ChiTietTK(int id)
        {
            var data = kn.Accounts.SingleOrDefault(x => x.AccountID == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
        public ActionResult ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            List<Account> accounts = kn.Accounts.ToList();

            using (ExcelPackage package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Accounts");

                worksheet.Cells[1, 1].Value = "ID";
                worksheet.Cells[1, 2].Value = "Username";
                worksheet.Cells[1, 3].Value = "Password";
                worksheet.Cells[1, 4].Value = "TypeAccounts";

                int row = 2;
                foreach (var account in accounts)
                {
                    worksheet.Cells[row, 1].Value = account.AccountID;
                    worksheet.Cells[row, 2].Value = account.Username;
                    worksheet.Cells[row, 3].Value = account.Password;
                    worksheet.Cells[row, 4].Value = account.TypeAccount.TypeAccountName;
                    row++;
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                var stream = new MemoryStream();
                package.SaveAs(stream);
                string fileName = "Accounts.xlsx";
                stream.Position = 0;

                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }
    }
}