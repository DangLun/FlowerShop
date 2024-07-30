using FlowerShop.Helpers;
using FlowerShop.Models;
using FlowerShop.ViewModels;
using Newtonsoft.Json;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace FlowerShop.Areas.Admin.Controllers
{
    public class SanPhamController : Controller
    {
        // GET: Admin/SanPham
        FlowerShopDbContext kn = new FlowerShopDbContext();
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult ContentSP(string searchString, int? page)
        {
            //List<Flowers> flowers = new List<Flowers>();
            //flowers = kn.Flowers.ToList();
            //return View(flowers);
            int pageSize = 10; // Number of items to display per page
            int pageNumber = (page ?? 1); // Default to first page if no page number is specified

            var flowers = from f in kn.Flowers
                          select f;

            if (!String.IsNullOrEmpty(searchString))
            {
                flowers = flowers.Where(f => f.FlowerName.Contains(searchString));
            }

            flowers = flowers.OrderByDescending(f => f.FlowerID);
            var paginatedFlowers = flowers.Skip((pageNumber - 1) * pageSize).Take(pageSize).ToList();

            ViewBag.PageNumber = pageNumber;
            ViewBag.TotalPages = (int)Math.Ceiling((double)flowers.Count() / pageSize);
            ViewBag.SearchString = searchString;

            return View(paginatedFlowers);

        }
        private List<TopicViewModel> getListTopicViewModel()
        {
            List<Topic> list = kn.Topics.ToList();
            List<TopicViewModel> listViewModel = new List<TopicViewModel>();
            foreach(var item in list){
                listViewModel.Add(new TopicViewModel { TopicID = item.TopicID, TopicName = item.TopicName });
            }
            return listViewModel;
        }
        public ActionResult ThemSP()
        {
            ThemSPViewModel model = new ThemSPViewModel();
            model.SelectedTopics = getListTopicViewModel();
            return View(model);
        }
        [HttpPost]
        public ActionResult ThemSP(ThemSPViewModel flowers)
        {
            if (ModelState.IsValid)
            {
                Flower sp = new Flower();
                sp.FlowerName = flowers.FlowerName;
                sp.FlowerQuantity = flowers.FlowerQuantity;
                sp.FlowerPrice = flowers.FlowerPrice;
                sp.FlowerDiscription = flowers.FlowerDiscription;
                sp.FlowerDiscount = flowers.FlowerDiscount;
                sp.CreateDate = DateTime.Now;
                sp.FlowerDVT = flowers.FlowerDVT;
                sp.FlowerNew = true;
                sp.FlowerStatus = true;

                if (flowers.FlowerPictureFile != null && flowers.FlowerPictureFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(flowers.FlowerPictureFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/Assets/Images"), fileName);
                    flowers.FlowerPictureFile.SaveAs(path);

                    // Save the file path to the database
                    sp.FlowerPicture = fileName; // Adjust the path as needed
                }
                kn.Flowers.Add(sp);
                kn.SaveChanges();
                // lưu danh sách hình phụ
                if(flowers.PictureList != null && flowers.FlowerPictureFile.ContentLength > 0)
                {
                    foreach (var item in flowers.PictureList)
                    {
                        string filename = Path.GetFileName(item.FileName);
                        string path = Path.Combine(Server.MapPath("~/Assets/Images"), filename);
                        item.SaveAs(path);
                        kn.Images.Add(new Image { FlowerID = sp.FlowerID, ImageUrl = filename });
                    }
                    kn.SaveChanges();
                }
                // Lưu danh sách chủ đề
                int FlowerID = sp.FlowerID;
                foreach (var item in flowers.SelectedTopics)
                {
                    if(item.IsChecked == true)
                    {
                        int TopicID = item.TopicID;
                        Topics_Flowers tf = new Topics_Flowers { FlowerID = FlowerID, TopicID = TopicID };
                        kn.Topics_Flowers.Add(tf);
                        kn.SaveChanges();
                    }
                }
                return RedirectToAction("ContentSP");
            }
                return View("ThemSP", flowers);
        }
        public HttpPostedFileBase ConvertImageUrlToHttpPostedFileBase(string imageUrl)
        {
            imageUrl = Path.Combine(Server.MapPath("~/Assets/Images"), imageUrl);
            WebClient webClient = new WebClient();
            byte[] imageBytes = webClient.DownloadData(imageUrl);

            MemoryStream stream = new MemoryStream(imageBytes);
            string contentType = "image/jpeg";
            string fileName = Path.GetFileName(imageUrl);

            return new CustomHttpPostedFileBase(stream, contentType, fileName);
        }
        public ActionResult EditSP(int id)
        {
            Flower flowers = kn.Flowers.FirstOrDefault(f => f.FlowerID == id);
            ThemSPViewModel sp = new ThemSPViewModel();
            sp.FlowerName = flowers.FlowerName;
            sp.FlowerQuantity = flowers.FlowerQuantity;
            sp.FlowerPrice = flowers.FlowerPrice;
            sp.FlowerDiscription = flowers.FlowerDiscription;
            sp.FlowerDiscount = flowers.FlowerDiscount;
            sp.CreateDate = flowers.CreateDate;
            sp.FlowerDVT = flowers.FlowerDVT;
            sp.FlowerNew = flowers.FlowerNew;
            sp.FlowerStatus = flowers.FlowerStatus;

            // lấy ra danh sách hình phụ

            List<Image> images = kn.Images.Where(m => m.FlowerID == id).ToList();  
            if(images.Count() != 0)
            {
                List<HttpPostedFileBase> fileImages = new List<HttpPostedFileBase>();
                foreach(var img in images)
                {
                    string src = img.ImageUrl;
                    fileImages.Add(ConvertImageUrlToHttpPostedFileBase(src));
                }
                sp.PictureList = fileImages;
                ViewBag.PictureList = JsonConvert.SerializeObject(fileImages.Select(f => new
                {
                    FileName = f.FileName,
                    ContentType = f.ContentType,
                    URL = Url.Content("~/Assets/Images/" + f.FileName)
                }));
            }

            if (!string.IsNullOrEmpty(flowers.FlowerPicture))
            {
                sp.FlowerPicture = flowers.FlowerPicture;
            }
            var query = (from t in kn.Topics
                                 join tf in kn.Topics_Flowers on t.TopicID equals tf.TopicID
                                 where tf.FlowerID == id
                                 select new
                                 {
                                     TopicID = tf.TopicID,
                                     TopicName = t.TopicName
                                 }).ToList();
            List<TopicViewModel> listTopic = new List<TopicViewModel>();
            List<Topic> listTopicBase = kn.Topics.ToList();
            foreach (var topic in listTopicBase)
            {
                listTopic.Add(new TopicViewModel { TopicID = topic.TopicID, TopicName = topic.TopicName}); ;
            }
            foreach(var item in listTopic)
            {
                foreach (var topic in query)
                {
                    if(item.TopicID == topic.TopicID)
                    {
                        item.IsChecked = true;
                        break;
                    }
                }
            }
            sp.SelectedTopics = listTopic;
            return View(sp);
        }
        [HttpPost]
        public ActionResult EditSP(int id, ThemSPViewModel flowers)
        {
            if (ModelState.IsValid)
            {
                Flower sp = kn.Flowers.FirstOrDefault(f => f.FlowerID == id);
                sp.FlowerName = flowers.FlowerName;
                sp.FlowerQuantity = flowers.FlowerQuantity;
                sp.FlowerPrice = flowers.FlowerPrice;
                sp.FlowerDiscription = flowers.FlowerDiscription;
                sp.FlowerDiscount = flowers.FlowerDiscount;
                sp.CreateDate = flowers.CreateDate;
                sp.FlowerDVT = flowers.FlowerDVT;
                sp.FlowerNew = flowers.FlowerNew;
                sp.FlowerStatus = flowers.FlowerStatus;

                if (flowers.FlowerPictureFile != null && flowers.FlowerPictureFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(flowers.FlowerPictureFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/Assets/Images"), fileName);
                    flowers.FlowerPictureFile.SaveAs(path);

                    // Save the file path to the database
                    sp.FlowerPicture = fileName; // Adjust the path as needed
                }
                int FlowerID = id;
                // xoa hien tai
                List<Topics_Flowers> dataForFlowerID = kn.Topics_Flowers.Where(x => x.FlowerID == FlowerID).ToList();

                foreach(var item in dataForFlowerID)
                {
                    kn.Topics_Flowers.Remove(item);
                    kn.SaveChanges();
                }

                // them moi
                List<TopicViewModel> SelectedTopics = flowers.SelectedTopics;
                foreach (var item in SelectedTopics)
                {
                    if (item.IsChecked == true)
                    {
                        kn.Topics_Flowers.Add(new Topics_Flowers { FlowerID = FlowerID, TopicID = item.TopicID });
                    }
                }
                kn.SaveChanges();

                // xoa hinh hien tai
                List<Image> imagebyFlowerID = kn.Images.Where(x => x.FlowerID == FlowerID).ToList();
                foreach (var item in imagebyFlowerID)
                {
                    kn.Images.Remove(item);
                }

                if (flowers.PictureList[0] != null)
                {
                    // them hinh moi
                    foreach (var item in flowers.PictureList)
                    {
                        kn.Images.Add(new Image { FlowerID = FlowerID, ImageUrl = item.FileName });
                    }
                }
                kn.SaveChanges();
                return RedirectToAction("ContentSP");
            }
            return View("EditSP", flowers);
        }
        public ActionResult DeleteSP(int id)
        {
            Flower sp = new Flower();
            sp = kn.Flowers.SingleOrDefault(x => x.FlowerID == id);
            return View(sp);
        }
        [HttpPost]
        public ActionResult DeleteSP(int id, Flower flowers)
        {
            Flower sp = new Flower();
            sp = kn.Flowers.SingleOrDefault(x => x.FlowerID == id);
            kn.Flowers.Remove(sp);
            kn.SaveChanges();

            return RedirectToAction("ContentSP", "SanPham");
        }
        public ActionResult DetailSP(int id)
        {
            var data = kn.Flowers.SingleOrDefault(x => x.FlowerID == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
        public ActionResult ExportToExcel()
        {
            ExcelPackage.LicenseContext = LicenseContext.NonCommercial;

            var flowers = kn.Flowers.ToList();

            using (ExcelPackage package = new ExcelPackage())
            {
                ExcelWorksheet worksheet = package.Workbook.Worksheets.Add("Flowers");

                worksheet.Cells[1, 1].Value = "ID";
                worksheet.Cells[1, 2].Value = "Tên sản phẩm";
                worksheet.Cells[1, 3].Value = "Số lượng";
                worksheet.Cells[1, 4].Value = "Khuyến mãi";
                worksheet.Cells[1, 5].Value = "Đơn giá";
                worksheet.Cells[1, 6].Value = "Mở bán";
                worksheet.Cells[1, 7].Value = "Mới";

                int row = 2;
                foreach (var flower in flowers)
                {
                    worksheet.Cells[row, 1].Value = flower.FlowerID;
                    worksheet.Cells[row, 2].Value = flower.FlowerName;
                    worksheet.Cells[row, 3].Value = flower.FlowerQuantity;
                    worksheet.Cells[row, 4].Value = flower.FlowerDiscount;
                    worksheet.Cells[row, 5].Value = flower.FlowerPrice;
                    worksheet.Cells[row, 6].Value = flower.FlowerStatus;
                    worksheet.Cells[row, 7].Value = flower.FlowerNew;
                    row++;
                }

                worksheet.Cells[worksheet.Dimension.Address].AutoFitColumns();

                var stream = new MemoryStream();
                package.SaveAs(stream);
                string fileName = "Flowers.xlsx";
                stream.Position = 0;

                return File(stream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", fileName);
            }
        }
        [HttpPost]
        public ActionResult UploadFile(HttpPostedFileBase file) // For traditional ASP.NET MVC
        {
            if (file != null && file.ContentLength > 0)
            {
                // Save the file or process it as needed
                // Example: Save to a folder or database
                string fileName = Path.GetFileName(file.FileName);
                string filePath = Path.Combine(Server.MapPath("~/UploadedFiles"), fileName);
                file.SaveAs(filePath);
            }
            return RedirectToAction("ContentSP");
        }


        public ActionResult GetImage(string fileName)
        {
            var filePath = Path.Combine(Server.MapPath("~/Assets/Images"), fileName);
            if (System.IO.File.Exists(filePath))
            {
                var fileBytes = System.IO.File.ReadAllBytes(filePath);
                return File(fileBytes, "image/jpeg");
            }
            return HttpNotFound();
        }
    }
}