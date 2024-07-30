using FlowerShop.Models;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class ChuDeController : Controller
    {
        // GET: Admin/ChuDe
        FlowerShopDbContext kn = new FlowerShopDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ContentCD(string searchString, int? page)
        {
            //List<Topics> topics = new List<Topics>();
            //topics = kn.Topics.ToList();
            //return View(topics);
            int pageSize = 10; // Số mục trên mỗi trang
            int pageNumber = (page ?? 1); // Trang hiện tại, mặc định là trang 1 nếu không có tham số page

            var topics = kn.Topics.AsQueryable();

            // Tìm kiếm nếu có chuỗi tìm kiếm
            if (!string.IsNullOrEmpty(searchString))
            {
                topics = topics.Where(t => t.TopicName.Contains(searchString));
            }

            var model = topics.OrderByDescending(tp=>tp.TopicID).ToList();

            // Lấy số lượng tổng cộng của các mục và tính toán số trang
            ViewBag.TotalPages = (int)Math.Ceiling((double)model.Count / pageSize);

            // Lấy chỉ mục của các mục hiển thị trên trang hiện tại
            model = model.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.PageNumber = pageNumber; // Lưu trữ số trang hiện tại để sử dụng cho phân trang

            ViewBag.SearchString = searchString; // Lưu chuỗi tìm kiếm để hiển thị lại trong form tìm kiếm

            return View(model);
        }
     
        public ActionResult ThemCD()
        {
            return View();
        }
        [HttpPost]
        public ActionResult ThemCD(Topic topics)
        {
            if (!ModelState.IsValid) { return View("ThemCD", topics); }
            kn.Topics.Add(topics);
            kn.SaveChanges();
            return RedirectToAction("ContentCD");
        }
        public ActionResult EditCD(int id)
        {
            var data = kn.Topics.Single(x => x.TopicID == id);
            return View(data);
        }
        [HttpPost]
        public ActionResult EditCD(int id, Topic topics)
        {
            if (!ModelState.IsValid) { return View("EditCD", topics); }
            Topic data = kn.Topics.Single(x => x.TopicID == id);
            data.TopicName = topics.TopicName;
            kn.SaveChanges();
            return RedirectToAction("ContentCD", "ChuDe");
        }
        public ActionResult DeleteCD(int id)
        {
            var data = kn.Topics.Single(x => x.TopicID == id);
            return View(data);
        }
        [HttpPost]
        public ActionResult DeleteCD(int id, Topic topics)
        {
            Topic cs = new Topic();
            cs = kn.Topics.SingleOrDefault(x => x.TopicID == id);
            kn.Topics.Remove(cs);
            kn.SaveChanges();
            return RedirectToAction("ContentCD", "ChuDe");
        }
        public ActionResult DetailCD(int id)
        {
            var data = kn.Topics.SingleOrDefault(x => x.TopicID == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
        public ActionResult ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            // Load topics from database
            var topics = kn.Topics.ToList();

            // Create Excel package
            using (ExcelPackage package = new ExcelPackage())
            {

                // Add a new worksheet to the package
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Topics");

                // Set headers
                worksheet.Cells[1, 1].Value = "ID";
                worksheet.Cells[1, 2].Value = "Tên chủ đề";

                // Populate data rows
                int row = 2;
                foreach (var topic in topics)
                {
                    worksheet.Cells[row, 1].Value = topic.TopicID;
                    worksheet.Cells[row, 2].Value = topic.TopicName;
                    row++;
                }

                // Auto-fit columns based on content
                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                // Prepare the Excel file stream for download
                MemoryStream stream = new MemoryStream(package.GetAsByteArray());
                stream.Position = 0;

                // Return the Excel file as a FileResult
                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "Topics.xlsx");
            }
        }

    }
}