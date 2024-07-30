using FlowerShop.Helpers;
using FlowerShop.Models;
using FlowerShop.ViewModels;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Mvc;
using System.Web.Services.Description;

namespace FlowerShop.Controllers
{
    public class ActionUserController : Controller
    {
        private FlowerShopDbContext db = new FlowerShopDbContext();

        private InfoUserViewModel getInfoUserByAccount()
        {
            InfoUserViewModel info = new InfoUserViewModel();
            var listAddress = new List<UserAddressViewModel>();
            string username = Session["username"].ToString();
            var customer = (from cs in db.Customers
                            join ac in db.Accounts on cs.CustomerID equals ac.CustomerID
                            where ac.Username == username
                            select new CustomerViewModel
                            {
                                CustomerID = cs.CustomerID,
                                CustomerAvatar = cs.CustomerAvatar,
                                CustomerEmail = cs.CustomerEmail,
                                CustomerName = cs.CustomerName,
                                CustomerPhone = cs.CustomerPhone,
                            }).FirstOrDefault();

            var result = (from dt in db.OrderDetails
                          join o in db.Orders on dt.OrderID equals o.OrderID
                          join cs in db.Customers on o.CustomerID equals cs.CustomerID
                          join f in db.Flowers on dt.FlowerID equals f.FlowerID
                          where cs.CustomerID == customer.CustomerID
                          group new { o, f } by new { o.OrderID, f.FlowerName, f.FlowerID, f.FlowerPicture, f.FlowerDiscount, f.FlowerPrice, o.CreateDate, o.Status, cs.CustomerID } into g
                          select new OrderUserViewModel
                          {
                              OrderID = g.Key.OrderID,
                              FlowerName = g.Key.FlowerName,
                              FlowerID = g.Key.FlowerID,
                              FlowerPicture = g.Key.FlowerPicture,
                              FlowerDiscount = (double)g.Key.FlowerDiscount,
                              FlowerPrice = (int)g.Key.FlowerPrice,
                              CreateDate = g.Key.CreateDate,
                              Status = g.Key.Status,
                              CustomerID = g.Key.CustomerID
                          }).ToList();
            listAddress = (from d in db.Deliveries
                           join c in db.Customers on d.CustomerID equals c.CustomerID
                           where c.CustomerID == customer.CustomerID
                           select new UserAddressViewModel
                           {
                               DeliveriyID = d.DeliveriyID,
                               DeliveryMain = d.DeliveryMain,
                               DeliveryName = d.DeliveryName,
                               CustomerName = c.CustomerName,
                               CustomerPhone = c.CustomerPhone,
                               FullName = d.FullName,
                               Phone = d.Phone
                           }).ToList();
            info.customerviewmodel = customer;
            info.orderUserViewModels = result;
            info.listAddress = listAddress;
            return info;
        }

        private InfoUserViewModel getInfoUserByAccountGoogle()
        {
            InfoUserViewModel info = new InfoUserViewModel();
            var listAddress = new List<UserAddressViewModel>();
            string email = Session["Google"].ToString();
            var kh = (from cs in db.Customers
                      where cs.CustomerEmail == email
                      select new CustomerViewModel
                      {
                          CustomerID = cs.CustomerID,
                          CustomerAvatar = cs.CustomerAvatar,
                          CustomerEmail = cs.CustomerEmail,
                          CustomerName = cs.CustomerName,
                          CustomerPhone = cs.CustomerPhone,
                      }).FirstOrDefault();
            var listOrder = (from dt in db.OrderDetails
                             join o in db.Orders on dt.OrderID equals o.OrderID
                             join cs in db.Customers on o.CustomerID equals cs.CustomerID
                             join f in db.Flowers on dt.FlowerID equals f.FlowerID
                             where cs.CustomerID == kh.CustomerID
                             group new { o, f } by new { o.OrderID, f.FlowerName, f.FlowerID, f.FlowerPicture, f.FlowerDiscount, f.FlowerPrice, o.CreateDate, o.Status, cs.CustomerID } into g
                             select new OrderUserViewModel
                             {
                                 OrderID = g.Key.OrderID,
                                 FlowerName = g.Key.FlowerName,
                                 FlowerID = g.Key.FlowerID,
                                 FlowerPicture = g.Key.FlowerPicture,
                                 FlowerDiscount = (double)g.Key.FlowerDiscount,
                                 FlowerPrice = (int)g.Key.FlowerPrice,
                                 CreateDate = g.Key.CreateDate,
                                 Status = g.Key.Status,
                                 CustomerID = g.Key.CustomerID
                             }).ToList();
            listAddress = (from d in db.Deliveries
                           join c in db.Customers on d.CustomerID equals c.CustomerID
                           where c.CustomerID == kh.CustomerID
                           select new UserAddressViewModel
                           {
                               DeliveriyID = d.DeliveriyID,
                               DeliveryMain = d.DeliveryMain,
                               DeliveryName = d.DeliveryName,
                               CustomerName = c.CustomerName,
                               CustomerPhone = c.CustomerPhone,
                               FullName = d.FullName,
                               Phone = d.Phone
                           }).ToList();

            info.customerviewmodel = kh;
            info.orderUserViewModels = listOrder;
            info.listAddress = listAddress;
            return info;
        }

        public ActionResult Infomation()
        {
            InfoUserViewModel info = new InfoUserViewModel();
            if (Session["username"] == null)
            {
                if (Session["Google"] != null)
                {
                    info = getInfoUserByAccountGoogle();
                    return View(info);
                }
                return RedirectToAction("Index", "Home");
            }
            info = getInfoUserByAccount();
            return View(info);
        }

        public List<CartItemViewModel> getListCartItem(int customerID)
        {
            var result = (from c in db.Carts
                          join cs in db.Customers on c.CustomerID equals cs.CustomerID
                          join f in db.Flowers on c.FlowerID equals f.FlowerID
                          where c.CustomerID == customerID
                          select new CartItemViewModel
                          {
                              IsChecked = true,
                              FlowerName = f.FlowerName,
                              FlowerDiscount = (double)f.FlowerDiscount,
                              FlowerDVT = f.FlowerDVT,
                              FlowerPicture = f.FlowerPicture,
                              FlowerPrice = (int)f.FlowerPrice,
                              FlowerQuantity = (int)c.Quantity,
                              FlowerID = (int)f.FlowerID,
                              CustomerID = customerID,
                              TotalQuantity = (int)db.Flowers.FirstOrDefault(x => x.FlowerID == f.FlowerID).FlowerQuantity,
                          }).ToList();
            return result;
        }

        public ActionResult Cart()
        {
            if (Session["CustomerID"] != null)
            {
                int id = int.Parse(Session["CustomerID"].ToString());
                var result = getListCartItem(id);
                return View(result);
            }
            return RedirectToAction("Login", "Sign");
        }
        public ActionResult Pay()
        {
            if (Session["Pay"] != null)
            {
                CustomerViewModel customerInfo = new CustomerViewModel();
                if (Session["CustomerID"] != null && int.TryParse(Session["CustomerID"].ToString(), out int id))
                {
                    Customer cs = db.Customers.Include(c => c.Deliveries).SingleOrDefault(c => c.CustomerID == id);

                    if (cs != null)
                    {
                        customerInfo.CustomerID = cs.CustomerID;
                        customerInfo.CustomerName = cs.CustomerName;
                        customerInfo.CustomerPhone = cs.CustomerPhone;
                        customerInfo.CustomerEmail = cs.CustomerEmail;
                        customerInfo.Deliveries = cs.Deliveries;
                    }
                }
                List<CartItemViewModel> items = (List<CartItemViewModel>)Session["Pay"];
                return View(new DataPayViewModel { CartItems = items , customer = customerInfo });
            }
            return View(new DataPayViewModel());
        }

        public bool DeleteCartItem(ref List<CartItemViewModel> items, DeleteItemCartViewModel item)
        {
            try
            {
                int index = item.Index;
                int customerid = items[index].CustomerID;
                int flowerid = items[index].FlowerID;
                Cart c = db.Carts.FirstOrDefault(x => x.FlowerID == flowerid && x.CustomerID == customerid);
                
                if (c != null)
                {
                    db.Carts.Remove(c);
                    items.RemoveAt(index);
                    db.SaveChanges();
                    return true;
                }
            }catch(Exception ex)
            {
                return false;
            }
            return false;
        }

        [HttpPost]
        public ActionResult HandleDeleteCartItem(List<CartItemViewModel> items, List<DeleteItemCartViewModel> Chooses)
        {
            DeleteItemCartViewModel item = Chooses.FirstOrDefault(x => x.IsChooseDelete == true);
            if (item != null)
            {
                bool IsDelete = DeleteCartItem(ref items, item);
                if (IsDelete)
                {
                    Session["DeleteCartItem"] = true;
                    Session["QuantityCart"] = (int)Session["QuantityCart"] - 1;
                }
                return RedirectToAction("Cart", "ActionUser", items);
            }

            return RedirectToAction("Cart", "ActionUser", items);
        }

        [HttpPost]
        public ActionResult HandleUpdateCart(List<CartItemViewModel> items)
        {
            return View("Cart", items);
        }

        [HttpPost]
        public ActionResult HandleCart(List<CartItemViewModel> items)
        {
            if(items == null)
            {
                Session["NoItemInCart"] = true;
                return View("Cart", items);
            }
            var cartItemViewModels = items.Where(x => x.IsChecked == true);
            if(cartItemViewModels != null)
            {
                List<CartItemViewModel> cartItems = cartItemViewModels.ToList();
                if (cartItems.FirstOrDefault(x=>x.FlowerQuantity > x.TotalQuantity) != null)
                {
                    Session["overQuantity"] = true;
                    return View("Cart", items);
                }
                Session["Pay"] = cartItems.ToList();
                return RedirectToAction("Pay", "ActionUser");
            }
            Session["NoItemChecked"] = true;
            return View("Cart", items);
        }

        private bool HandleSavePayment(DataPayViewModel dataPayViewModel)
        {
            try
            {
                Order order = new Order();
                order.CreateDate = DateTime.Now;
                order.Status = "Pending";
                order.CustomerID = dataPayViewModel.customer.CustomerID;
                order.DeliveryID = dataPayViewModel.customer.SelectedDeliveryID;
                db.Orders.Add(order);
                db.SaveChanges();

                foreach (var item in dataPayViewModel.CartItems)
                {
                    // xóa giỏ hàng
                    Cart cart = new Cart();
                    cart = db.Carts.FirstOrDefault(x => x.CustomerID == dataPayViewModel.customer.CustomerID);
                    db.Carts.Remove(cart);

                    // Trừ số lượng sản phẩm hiện có

                    Flower flower = db.Flowers.FirstOrDefault(f => f.FlowerID == item.FlowerID);
                    flower.FlowerQuantity -= item.FlowerQuantity;

                    // thêm vào orderdetail
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.OrderID = order.OrderID;
                    orderDetail.FlowerID = item.FlowerID;
                    orderDetail.Quantity = item.FlowerQuantity;
                    db.OrderDetails.Add(orderDetail);
                    db.SaveChanges();
                }
                Session["QuantityCart"] = 0;
                return true;
            }catch(Exception e)
            {
                return false;
            }
        }

        private ActionResult SavePaymentToDB(RequestResultVNPAYViewModel result = null)
        {
            DataPayViewModel dataPayViewModel = new DataPayViewModel();
            if (Session["DataPayVNPAY"] != null)
            {
                dataPayViewModel = (DataPayViewModel)Session["DataPayVNPAY"];
                Session["DataPayVNPAY"] = null;
            }
            else if (Session["DataPayDelivery"] != null)
            {
                dataPayViewModel = (DataPayViewModel)Session["DataPayDelivery"];
                Session["DataPayDelivery"] = null;
            }
            if (HandleSavePayment(dataPayViewModel)) return RedirectToAction("Thanks", "ActionUser", result);
            return RedirectToAction("Error", "ActionUser");
        }

        public ActionResult PaymentCallBack(ResponsePaymentVNPAYViewModel response)
        {
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"];
            var vnpayData = Request.QueryString;
            VnPayLibrary vnpay = new VnPayLibrary();

            foreach (string s in vnpayData)
            {
                if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                {
                    vnpay.AddResponseData(s, vnpayData[s]);
                }
            }
            long orderId = Convert.ToInt64(response.vnp_TxnRef);
            long vnpayTranId = Convert.ToInt64(response.vnp_TransactionNo);
            string vnp_ResponseCode = response.vnp_ResponseCode;
            string vnp_TransactionStatus = response.vnp_TransactionStatus;
            String vnp_SecureHash = response.vnp_SecureHash;
            String TerminalID = response.vnp_TmnCode;
            long vnp_Amount = Convert.ToInt64(response.vnp_Amount) / 100;
            String bankCode = response.vnp_BankCode;

            bool checkSignature = vnpay.ValidateSignature(vnp_SecureHash, vnp_HashSecret);
            RequestResultVNPAYViewModel result = new RequestResultVNPAYViewModel();
            if (checkSignature)
            {
                result.terminalID = TerminalID;
                result.orderID = orderId.ToString();
                result.vnpayTranId = vnpayTranId.ToString();
                result.vnp_Amount = vnp_Amount.ToString();
                result.bankCode = bankCode;
                if (vnp_ResponseCode == "00" && vnp_TransactionStatus == "00")
                {
                    //Thanh toan thanh cong
                    result.Message = "Giao dịch được thực hiện thành công. Cảm ơn quý khách đã sử dụng dịch vụ";
                    return SavePaymentToDB(result);
                }
                else
                {
                    //Thanh toan khong thanh cong. Ma loi: vnp_ResponseCode
                    result.Message = "Có lỗi xảy ra trong quá trình xử lý.Mã lỗi: " + vnp_ResponseCode;
                    Session["DataPayVNPAY"] = null;
                    return RedirectToAction("Error", "ActionUser", result);
                }
            }
            else
            {
                Session["DataPayVNPAY"] = null;
                result.Message = "Có lỗi xảy ra trong quá trình xử lý";
                return RedirectToAction("Error", "ActionUser", result);
            }
        }

        private double getAmount(List<CartItemViewModel> CartItems)
        {
            return CartItems.Sum(x => x.FlowerQuantity * (x.FlowerPrice - (x.FlowerPrice * x.FlowerDiscount / 100))) + 32000;
        }

        public ActionResult CreateRequestVNPAY(DataPayViewModel model)
        {
            string vnp_Returnurl = ConfigurationManager.AppSettings["vnp_Returnurl"]; //URL nhan ket qua tra ve 
            string vnp_Url = ConfigurationManager.AppSettings["vnp_Url"]; //URL thanh toan cua VNPAY 
            string vnp_TmnCode = ConfigurationManager.AppSettings["vnp_TmnCode"]; //Ma định danh merchant kết nối (Terminal Id)
            string vnp_HashSecret = ConfigurationManager.AppSettings["vnp_HashSecret"]; //Secret Key

            RequestOrderVNPAYViewModel order = new RequestOrderVNPAYViewModel();
            order.OrderID = DateTime.Now.Ticks;
            order.Amount = getAmount(model.CartItems);
            order.Status = "0";
            order.CreateDate = DateTime.Now;

            VnPayLibrary vnpay = new VnPayLibrary();
            vnpay.AddRequestData("vnp_Version", VnPayLibrary.VERSION);
            vnpay.AddRequestData("vnp_Command", "pay");
            vnpay.AddRequestData("vnp_TmnCode", vnp_TmnCode);
            vnpay.AddRequestData("vnp_Amount", (order.Amount * 100).ToString());
            vnpay.AddRequestData("vnp_BankCode", "VNBANK");
            vnpay.AddRequestData("vnp_CreateDate", order.CreateDate.ToString("yyyyMMddHHmmss"));
            vnpay.AddRequestData("vnp_CurrCode", "VND");
            vnpay.AddRequestData("vnp_IpAddr", Utils.GetIpAddress());
            vnpay.AddRequestData("vnp_Locale", "vn");
            vnpay.AddRequestData("vnp_OrderInfo", "Thanh toan don hang:" + order.OrderID);
            vnpay.AddRequestData("vnp_OrderType", "other"); 

            vnpay.AddRequestData("vnp_ReturnUrl", vnp_Returnurl);
            vnpay.AddRequestData("vnp_TxnRef", order.OrderID.ToString());
            string paymentUrl = vnpay.CreateRequestUrl(vnp_Url, vnp_HashSecret);
            return Redirect(paymentUrl);
        }

        [HttpGet]
        public JsonResult GetDeliveryDetails(int deliveryID)
        {
            var delivery = db.Deliveries.FirstOrDefault(d => d.DeliveriyID == deliveryID);
            if (delivery != null)
            {
                DeliveryViewModel viewModel = new DeliveryViewModel();
                viewModel.DeliveriyID = deliveryID;
                viewModel.DeliveryName = delivery.DeliveryName;
                viewModel.DeliveryMain = delivery.DeliveryMain;
                viewModel.Phone = delivery.Phone;
                viewModel.FullName = delivery.FullName;
                viewModel.CustomerID = delivery.CustomerID;
                return Json(new { success = true, data = viewModel }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                return Json(new { success = false }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]  
        public ActionResult HandlePay(DataPayViewModel dataPayViewModel)
        {
            if (dataPayViewModel.IsPaymentOnVNPAY)
            {
                Session["DataPayVNPAY"] = dataPayViewModel;
                return CreateRequestVNPAY(dataPayViewModel);
            }
            Session["DataPayDelivery"] = dataPayViewModel;
            return SavePaymentToDB(null);
        }

        public ActionResult Thanks(RequestResultVNPAYViewModel model)
        {
            if (string.IsNullOrEmpty(model.terminalID) && string.IsNullOrEmpty(model.orderID) && string.IsNullOrEmpty(model.vnpayTranId) &&
                string.IsNullOrEmpty(model.bankCode) && string.IsNullOrEmpty(model.vnp_Amount) && string.IsNullOrEmpty(model.Message))
            {
                return View();
            }
            return View(model);  
        }

        public ActionResult Error(RequestResultVNPAYViewModel model)
        {
            return View(model);
        }


        public ActionResult ProductDetail(int? id) {
            if (id == null) return View();
            Flower flower = db.Flowers.FirstOrDefault(f => f.FlowerID == id);
            if(flower == null) return View();
            var query = (from t in db.Topics
                         join tf in db.Topics_Flowers on t.TopicID equals tf.TopicID
                         where tf.FlowerID == id
                         select new
                         {
                             TopicID = t.TopicID,
                             TopicName = t.TopicName
                         });

            List<Topic> topicforFlowerID = new List<Topic>();
            foreach(var item in query)
            {
                topicforFlowerID.Add(new Topic { TopicID = item.TopicID, TopicName = item.TopicName }); 
            }

            List<Flower> FlowerRelate = new List<Flower>();
            foreach(var item in topicforFlowerID)
            {
                List<Flower> listf = new List<Flower>();
                var querystring = (from f in db.Flowers
                             join tf in db.Topics_Flowers on f.FlowerID equals tf.FlowerID
                             where tf.TopicID == item.TopicID
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
                             });

                
                foreach (var f in querystring)
                {
                    listf.Add(new Flower {
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
                foreach (var item1 in listf)
                {
                    FlowerRelate.Add(item1);
                }
            }
            ProductDetailViewModel productDetailViewModel = new ProductDetailViewModel
            {
                flower = flower,
                flowerRelates = FlowerRelate
            };   

            return View(productDetailViewModel);
        }

        public ActionResult DeleteOrder(int? id, string role)
        {
            if(id == null) return RedirectToAction("Infomation", "ActionUser");
            Order order = db.Orders.FirstOrDefault(o=>o.OrderID == id); 
            if(order == null) return RedirectToAction("Infomation", "ActionUser");
            if (role == "delete")
            {
                db.Orders.Remove(order);
                Session["DeleteOrder"] = true;
            }
            else
            {
                order.Status = "Canceled";
                Session["CancelOrder"] = true;
            }
            db.SaveChanges();
            return RedirectToAction("Infomation", "ActionUser");
        }

        [HttpPost]
        public ActionResult HandleDelivery(InfoUserViewModel info)
        {
            if (Session["CustomerID"] == null) RedirectToAction("Index", "Home");
            int customerid = (int)Session["CustomerID"];
            Delivery delivery = new Delivery();
            if (info.delivery.DeliveriyID == 0) // add
            {
                delivery.DeliveryName = info.delivery.DeliveryName;
                delivery.DeliveryMain = info.delivery.DeliveryMain;
                delivery.CustomerID = customerid;
                delivery.FullName = info.delivery.Fullname;
                delivery.Phone = info.delivery.Phone;
                db.Deliveries.Add(delivery);
                Session["AddSuccessDelivery"] = true;
            }else // edit
            {
                delivery = db.Deliveries.Find(info.delivery.DeliveriyID);
                if(delivery == null) RedirectToAction("Infomation", "ActionUser");
                delivery.DeliveryName = info.delivery.DeliveryName;
                delivery.FullName = info.delivery.Fullname;
                delivery.Phone = info.delivery.Phone;
                delivery.DeliveryMain = info.delivery.DeliveryMain;
                Session["EditSuccessDelivery"] = true;
            }
            if (info.delivery.DeliveryMain)
            {
                Delivery deliveryMain = db.Deliveries.SingleOrDefault(x => x.CustomerID == customerid && x.DeliveryMain == true);
                if (deliveryMain != null)
                {
                    deliveryMain.DeliveryMain = false;
                }
            }
            db.SaveChanges();
            return RedirectToAction("Infomation", "ActionUser");
        }

        public ActionResult HandleDeleteDelivery(int? id)
        {
            if(id == null) RedirectToAction("Infomation", "ActionUser");
            Delivery delivery = db.Deliveries.Find(id);
            if(delivery != null)
            {
                db.Deliveries.Remove(delivery);
                db.SaveChanges();
                Session["RemoveDelivery"] = true;
            }
            return RedirectToAction("Infomation", "ActionUser");
        }
        [HttpPost]
        public ActionResult HandleUploadAvatar(HttpPostedFileBase inputAvatar)
        {
            if (inputAvatar != null && inputAvatar.ContentLength > 0)
            {
                var path = Server.MapPath("~/Assets/Images");
                if (!System.IO.Directory.Exists(path))
                {
                    System.IO.Directory.CreateDirectory(path);
                }
                var fileName = System.IO.Path.GetFileName(inputAvatar.FileName);
                var filePath = System.IO.Path.Combine(path, fileName);
                inputAvatar.SaveAs(filePath);

                int customerID = (int)Session["CustomerID"];
                Customer cs = db.Customers.FirstOrDefault(f => f.CustomerID == customerID);
                if(cs != null)
                {
                    cs.CustomerAvatar = fileName;
                    db.SaveChanges();
                }   
            }
            InfoUserViewModel info = new InfoUserViewModel();
            if (Session["username"] == null)
            {
                if (Session["Google"] != null)
                {
                    info = getInfoUserByAccountGoogle();
                    return View("Infomation", info);
                }
                return RedirectToAction("Index", "Home");
            }
            info = getInfoUserByAccount();
            return View("Infomation", info);
        }
    }
}