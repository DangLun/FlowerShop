using FlowerShop.Models;
using FlowerShop.ViewModels;
using System;
using System.Linq;
using System.Web.Mvc;
using FlowerShop.Helpers;
using System.Threading.Tasks;
using System.Collections.Generic;
using System.Net.Http;
using Google.Apis.Auth.OAuth2.Responses;
using Newtonsoft.Json;

namespace FlowerShop.Controllers
{
    public class SignController : Controller
    {
        private FlowerShopDbContext db = new FlowerShopDbContext();
        private MailHelper _mailHelper = new MailHelper();
        public ActionResult Login()
        {
            if (Session["username"] != null || Session["Google"] != null) Session.Clear();
            return View();
        }
        public ActionResult Register()
        {
            return View();
        }
        public ActionResult VertifyRegister(string vertifyID)
        {
            if (Session["vertifyID"] == null) return RedirectToAction("Register", "Sign");
            string vertifyID_Local = Session["vertifyID"].ToString();
            if (vertifyID != vertifyID_Local && !string.IsNullOrEmpty(vertifyID))
            {
                ViewBag.Error = "Sai mã xác nhận";
                return View();
            }
            else if (vertifyID != vertifyID_Local)
            {
                ViewBag.Error = "";
                return View();
            }
            RegisterFormViewModel register = (RegisterFormViewModel)Session["InfoRegister"];
            AddNewCustomer(register.CustomerName, register.CustomerPhone, register.CustomerEmail);
            db.SaveChanges();
            AddNewAccount(register.Username, register.Password);
            db.SaveChanges();
            Session["vertifyID"] = null;
            Session["InfoRegister"] = null;
            return RedirectToAction("VertifySuccess", "Sign");
        }

        public ActionResult VertifySuccess()
        {
            return View();
        }
        public string getNameCustomerByUsername(string username)
        {
            using (db)
            {
                var name = (from ac in db.Accounts join cs in db.Customers on ac.CustomerID equals cs.CustomerID where ac.Username == username select cs.CustomerName);
                return name.FirstOrDefault()?.ToString();
            }
        }

        public ActionResult LoginWithGoogle()
        {
            string clientId = "320419221419-qfrh91ng5v4drk9e201clndas6s88sj5.apps.googleusercontent.com";
            string redirectUri = "https://localhost:44383/Sign/GoogleCallback";

            string url = $"https://accounts.google.com/o/oauth2/v2/auth?scope=https%3A//www.googleapis.com/auth/userinfo.email%20https%3A//www.googleapis.com/auth/userinfo.profile&response_type=code&redirect_uri={redirectUri}&client_id={clientId}";

            return Redirect(url);
        }

        public async Task<ActionResult> GoogleCallback(string code)
        {
            if (string.IsNullOrEmpty(code))
            {
                return RedirectToAction("Login");
            }

            string clientId = "320419221419-qfrh91ng5v4drk9e201clndas6s88sj5.apps.googleusercontent.com";
            string clientSecret = "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";
            string redirectUri = "https://localhost:44383/Sign/GoogleCallback";

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri("https://oauth2.googleapis.com");
                var content = new FormUrlEncodedContent(new[]
                {
                    new KeyValuePair<string, string>("code", code),
                    new KeyValuePair<string, string>("client_id", clientId),
                    new KeyValuePair<string, string>("client_secret", clientSecret),
                    new KeyValuePair<string, string>("redirect_uri", redirectUri),
                    new KeyValuePair<string, string>("grant_type", "authorization_code")
                });

                var response = await client.PostAsync("/token", content);
                if (response.IsSuccessStatusCode)
                {
                    var result = await response.Content.ReadAsStringAsync();
                    var tokenResponse = JsonConvert.DeserializeObject<TokenResponse>(result);
                    string accessToken = tokenResponse.AccessToken;

                    var userInfoResponse = await client.GetAsync($"https://www.googleapis.com/oauth2/v3/userinfo?access_token={accessToken}");
                    if (userInfoResponse.IsSuccessStatusCode)
                    {
                        var userInfoResult = await userInfoResponse.Content.ReadAsStringAsync();
                        var userInfo = JsonConvert.DeserializeObject<AccountGoogleViewModel>(userInfoResult);

                        string email = userInfo.email;
                        var customer = db.Customers.FirstOrDefault(x => x.CustomerEmail == email);
                        if (customer == null)
                        {
                            Customer cs = new Customer();
                            cs.CustomerEmail = userInfo.email;
                            cs.CustomerName = userInfo.family_name + userInfo.given_name;
                            cs.CustomerAvatar = userInfo.picture;
                            db.Customers.Add(cs);
                            db.SaveChanges();
                            Session["Name"] = userInfo.given_name + " " + userInfo.family_name;
                            Session["Google"] = email;
                            Session["CustomerID"] = cs.CustomerID;
                            Session["QuantityCart"] = 0;
                            return RedirectToAction("Index", "Home");
                        }
                        int CustomerID = customer.CustomerID;
                        var customerIDinAccount = db.Accounts.FirstOrDefault(x => x.CustomerID == CustomerID);
                        if(customerIDinAccount != null)
                        {
                            Session["Errored"] = true;
                            return RedirectToAction("Login", "Sign");
                        }
                        Session["Name"] = userInfo.given_name + " " + userInfo.family_name;
                        Session["Google"] = email;
                        Session["CustomerID"] = CustomerID;
                        int quantityCart = db.Carts.Where(c => c.CustomerID == CustomerID).Count();
                        Session["QuantityCart"] = quantityCart;
                        return RedirectToAction("Index", "Home");
                    }
                }

                return RedirectToAction("Login");
            }
        }


        [HttpPost]
        public ActionResult HandleLogin(AccountViewModel account)
        {
            if (!ModelState.IsValid)
            {
                return View("Login", account);
            }
            string username = account.Username;
            string password = account.Password;
            Account ac = db.Accounts.SingleOrDefault(x => x.Username == username && x.Password == password);
            if (ac == null)
            {
                return View("Login", account);
            }
            Customer customer = (from cs in db.Customers join a in db.Accounts on cs.CustomerID equals a.CustomerID where a.Username == username select cs).FirstOrDefault();
            ac.LogDate = DateTime.Now;
            ac.QuantityLog++;
            int quantityCart = db.Carts.Where(c => c.CustomerID == customer.CustomerID).Count();
            db.SaveChanges();
            Session["username"] = username;
            Session["Name"] = getNameCustomerByUsername(username);
            Session["CustomerID"] = customer.CustomerID;
            Session["QuantityCart"] = quantityCart;
            if(ac.TypeAccountID == 1)
            {
                return RedirectToAction("Index", "Admin", new { area = "Admin" });
            }
            else
            {
                return RedirectToAction("Index", "Home");
            }
        }

        private void AddNewAccount(string username, string password)
        {
            Account ac = new Account();
            ac.Username = username;
            ac.Password = password;
            ac.Status = true;
            ac.CreateDate = DateTime.Now;
            ac.QuantityLog = 0;
            ac.LogDate = null;
            ac.TypeAccountID = 2; // khách hàng
            ac.CustomerID = db.Customers.Max(x => x.CustomerID);
            db.Accounts.Add(ac);
        }

        private void AddNewCustomer(string fullname, string phone, string email)
        {
            Customer cs = new Customer();
            cs.CustomerPhone = phone;
            cs.CustomerEmail = email;
            cs.CustomerName = fullname;
            cs.CustomerAvatar = "default.png";
            db.Customers.Add(cs);
        }
        public string GenerateRandomNumbers()
        {
            Random random = new Random();
            int num1 = random.Next(0, 10);
            int num2 = random.Next(0, 10);
            int num3 = random.Next(0, 10);
            int num4 = random.Next(0, 10);

            string result = $"{num1}{num2}{num3}{num4}";
            return result;
        }
        [HttpPost]
        public ActionResult HandleRegister(RegisterFormViewModel register)
        {
            if (!ModelState.IsValid)
            {
                return View("Register", register);
            }
            using (db)
            {
                string vertifyID = GenerateRandomNumbers();
                Session["vertifyID"] = vertifyID;
                Session["InfoRegister"] = register;
                string content = $"<h1>Xác nhận đăng kí tài khoản</h1>" +
                    $"<p>Mã xác minh của bạn là: {vertifyID}</p>";
                _mailHelper.SendEmail(register.CustomerEmail, "Xác nhận đăng kí tài khoản tại Đân trần", content);
                return RedirectToAction("VertifyRegister", "Sign");
            }
        }
    }
}