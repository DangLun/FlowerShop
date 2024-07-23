using FlowerShop.Models;
using PagedList;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace FlowerShop.Controllers
{
    public class HomeController : Controller
    {
        private FlowerShopDbContext db = new FlowerShopDbContext();
        public async Task<ActionResult> Index()
        {
            List<Flower> flowers = await GetListFlower();
            flowers = flowers.Take(8).ToList();
            return View(flowers);
        }

        public async Task<List<Flower>> GetListFlower()
        {
            List<Flower> flowers = await db.Flowers.ToListAsync();
            return flowers;
        }

        public ActionResult Products(string search, int? page)
        {
            var products = db.Flowers.AsQueryable();

            if (!string.IsNullOrEmpty(search))
            {
                products = products.Where(f => f.FlowerName.ToLower().Contains(search.ToLower()));
            }

            int pageSize = 8;
            int pageNumber = (page ?? 1);

            var pagedList = products.OrderBy(f => f.FlowerName).ToPagedList(pageNumber, pageSize);

            ViewBag.CurrentSearch = search;
            return View(pagedList);
        }

        [HttpPost]
        public ActionResult Search(string search)
        {
            return RedirectToAction("Products", new { search });
        }

        [HttpPost]
        public ActionResult SearchProductPage(string search, int? id)
        {
            return RedirectToAction("ProductPage", new { search, id });
        }
        public ActionResult ProductPage(int? id, int? page, string search)
        {
            if (id == null) return RedirectToAction("Products", "Home");
            Topic topic = db.Topics.Find(id);
            ViewBag.BannerTitle = topic.TopicName;

            List<Flower> products = new List<Flower>();
            var querystring = (from f in db.Flowers
                               join tf in db.Topics_Flowers on f.FlowerID equals tf.FlowerID
                               where tf.TopicID == id
                               select new
                               {
                                   FlowerID = f.FlowerID,
                                   FlowerName = f.FlowerName,
                                   FlowerQuantity = f.FlowerQuantity,
                                   FlowerDiscount = f.FlowerDiscount,
                                   FlowerPrice = f.FlowerPrice,
                                   FlowerPicture = f.FlowerPicture,
                                   FlowerDiscription = f.FlowerDiscription,
                                   FlowerStatus = f.FlowerStatus,
                                   FlowerNew = f.FlowerNew,
                                   FlowerDVT = f.FlowerDVT,
                                   CreateDate = f.CreateDate,
                               }).ToList();


            foreach (var f in querystring)
            {
                products.Add(new Flower
                {
                    FlowerID = f.FlowerID,
                    FlowerName = f.FlowerName,
                    FlowerQuantity = f.FlowerQuantity,
                    FlowerDiscount = f.FlowerDiscount,
                    FlowerPrice = f.FlowerPrice,
                    FlowerPicture = f.FlowerPicture,
                    FlowerDiscription = f.FlowerDiscription,
                    FlowerStatus = f.FlowerStatus,
                    FlowerNew = f.FlowerNew,
                    FlowerDVT = f.FlowerDVT,
                    CreateDate = f.CreateDate,
                });
            }
            if (!string.IsNullOrEmpty(search))
            {
                products = products.Where(f => f.FlowerName.ToLower().Contains(search.ToLower())).ToList();
            }

            int pageSize = 8;
            int pageNumber = (page ?? 1);

            var pagedList = products.OrderBy(f => f.FlowerName).ToPagedList(pageNumber, pageSize);

            ViewBag.CurrentSearch = search;
            ViewBag.id = id;
            return View(pagedList);
        }

        public ActionResult AddtoCart(int? id)
        {
            if (id == null) return RedirectToAction("Index", "Home");
            if (Session["CustomerID"] != null)
            {
                int customerid = (int)Session["CustomerID"];
                Cart cart = new Cart();
                cart = db.Carts.SingleOrDefault(x => x.FlowerID == id && x.CustomerID == customerid);
                if(cart != null)
                {
                    cart.Quantity++;
                }else
                {
                    cart = new Cart();
                    cart.FlowerID = (int)id;
                    cart.Quantity = 1;
                    cart.CustomerID = customerid;
                    Session["QuantityCart"] = (int)Session["QuantityCart"] + 1;
                    db.Carts.Add(cart);
                }
                db.SaveChanges();
                Session["AlertAddToCart"] = true;
                
            }
            if (Request.UrlReferrer != null) return Redirect(Request.UrlReferrer.ToString());
            return RedirectToAction("Index", "Home");
        }
    }
}