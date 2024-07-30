using FlowerShop.Models;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class BannerController : Controller
    {
        // GET: Admin/Banner
        FlowerShopDbContext db = new FlowerShopDbContext();
        public List<Banner> getListBanner()
        {
            List<Banner> list = new List<Banner>(); 
            list = db.Banners.ToList();
            return list;
        }

        public List<Banner> Paging(string searchString, int? page)
        {
            int pageSize = 10; // Số mục trên mỗi trang
            int pageNumber = (page ?? 1); // Trang hiện tại, mặc định là trang 1 nếu không có tham số page

            var banners = db.Banners.AsQueryable();

            // Tìm kiếm nếu có chuỗi tìm kiếm
            if (!string.IsNullOrEmpty(searchString))
            {
                banners = banners.Where(t => t.BannerName.Contains(searchString));
            }

            var model = banners.OrderByDescending(tp => tp.BannerID).ToList();

            // Lấy số lượng tổng cộng của các mục và tính toán số trang
            ViewBag.TotalPages = (int)Math.Ceiling((double)model.Count / pageSize);

            // Lấy chỉ mục của các mục hiển thị trên trang hiện tại
            model = model.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.PageNumber = pageNumber; // Lưu trữ số trang hiện tại để sử dụng cho phân trang

            ViewBag.SearchString = searchString; // Lưu chuỗi tìm kiếm để hiển thị lại trong form tìm kiếm
            return model;
        }
        public ActionResult Index(string searchString, int? page)
        {
            List<Banner> banners = Paging(searchString, page);
            return View(banners);
        }

        public ActionResult AddBanner()
        {
            return View();
        }
        [HttpPost]
        public ActionResult AddBanner(Banner banner)
        {
            Banner item = new Banner { BannerName = banner.BannerName };
            db.Banners.Add(item);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult EditBanner(int id)
        {
            Banner banner = db.Banners.FirstOrDefault(b => b.BannerID == id);
            return View(banner);
        }
        [HttpPost]
        public ActionResult EditBanner(int id, Banner banner)
        {
            Banner item = db.Banners.FirstOrDefault(b => b.BannerID == banner.BannerID);
            if (item == null) return RedirectToAction("Index");
            item.BannerName = banner.BannerName;
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public ActionResult DeleteBanner(int id) {
            Banner banner = db.Banners.FirstOrDefault(b => b.BannerID == id);
            return View(banner);
        }
        [HttpPost]
        public ActionResult DeleteBanner(int id, Banner banner)
        {
            Banner item = db.Banners.FirstOrDefault(b => b.BannerID == id);
            if (item == null) return RedirectToAction("Index");
            db.Banners.Remove(item);
            db.SaveChanges();
            return RedirectToAction("Index");
        }
        public ActionResult ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            // Load topics from database
            var banners = db.Banners.ToList();

            // Create Excel package
            using (ExcelPackage package = new ExcelPackage())
            {
                // Add a new worksheet to the package
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Topics");

                // Set headers
                worksheet.Cells[1, 1].Value = "ID";
                worksheet.Cells[1, 2].Value = "Banner URL";

                // Populate data rows
                int row = 2;
                foreach (var banner in banners)
                {
                    worksheet.Cells[row, 1].Value = banner.BannerID;
                    worksheet.Cells[row, 2].Value = banner.BannerName;
                    row++;
                }

                // Auto-fit columns based on content
                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                // Prepare the Excel file stream for download
                MemoryStream stream = new MemoryStream(package.GetAsByteArray());
                stream.Position = 0;

                // Return the Excel file as a FileResult
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Banners.xlsx");
            }
        }


    }
}