using Facebook;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using WebsiteDatVe.Models;

namespace WebsiteDatVe.Controllers
{
    public class UserController : Controller
    {

        private DatVeDB db = new DatVeDB();

        public ActionResult Login()
        {
            return PartialView();
        }

        //login thường
        public JsonResult CheckAccount(string email, string password)
        {
            try
            {
                Boolean thanhcong = false;
                TaiKhoan user = (from u in db.TaiKhoans where u.Email == email && u.MatKhau == password select u).FirstOrDefault();
                string quyen = "";
                if(user != null)
                {
                    thanhcong = true;
                    Session["TaiKhoan"] = user;
                    quyen = user.Quyen;
                }
                return Json(new { code = 200, user = user, thanhcong = thanhcong , quyen = quyen}, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { code = 500, msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public Uri RedirectUri
        {
            get
            {
                var uriBuilder = new UriBuilder(Request.Url);
                uriBuilder.Query = null;
                uriBuilder.Fragment = null;
                uriBuilder.Path = Url.Action("FacebookCallback");
                return uriBuilder.Uri;
            }
        }


        //login facebook
        public ActionResult loginFacebook()
        {
            var fb = new FacebookClient();
            var loginUrl = fb.GetLoginUrl(new
            {
                client_id = ConfigurationManager.AppSettings["FbAppID"],
                client_secret = ConfigurationManager.AppSettings["FbAppSecret"],
                redirect_uri = RedirectUri.AbsoluteUri,
                respone_type = "code",
                scope = "email",
            });

            return Redirect(loginUrl.AbsoluteUri);
        }

        //https://localhost:44309/User/FacebookCallback
        //https://localhost:44309/User/loginFacebook
        //https://localhost:44309/User/InsertLoginFacebook

        public ActionResult FacebookCallback(string code)
        {
            var fb = new FacebookClient();
            dynamic result = fb.Post("oauth/access_token", new
            {
                client_id = ConfigurationManager.AppSettings["FbAppID"],
                client_secret = ConfigurationManager.AppSettings["FbAppSecret"],
                redirect_uri = RedirectUri.AbsoluteUri,
                code = code
            });

            var accessToken = result.access_token;
            if (!string.IsNullOrEmpty(accessToken))
            {
                fb.AccessToken = accessToken;
                dynamic me = fb.Get("me?fields=first_name,middle_name,last_name,id,email");
                string email = me.email;
                string firstname = me.first_name;
                string lastname = me.last_name;
                string middlename = me.middle_name;
                string id = me.id;

                var user = new TaiKhoan();
                user.Email = email;
                //var a = GetMD5(email).ToString();
                user.MatKhau = id;
                user.Quyen = "0";
                user.HoTen = lastname + " " + middlename + " " + firstname ;
                var resultInsert = int.Parse(InsertLoginFacebook(user).ToString());
                if(resultInsert > 0)
                {
                    var tv = (from c in db.TaiKhoans where c.Email == user.Email select c).FirstOrDefault();
                    if (tv != null)
                    {
                        Session["TaiKhoan"] = tv;
                        return RedirectToAction("Index", "Home");
                    }
                }
                
            }
            
            return View();
        }

        public long InsertLoginFacebook(TaiKhoan enty)
        {
            var user = db.TaiKhoans.SingleOrDefault(n => n.Email == enty.Email);
            if (user == null)
            {
                db.TaiKhoans.Add(enty);
                db.SaveChanges();
                return enty.MaTaiKhoan;
            }

            return user.MaTaiKhoan;

        }


        //login google
        [HttpPost]
        public JsonResult GoogleLogin(string Username, string TenNguoiDung, string Email, string Hinh)
        {
            try
            {
                
                var taikhoan = (from c in db.TaiKhoans where c.Email == Email select c).FirstOrDefault();
                if (taikhoan != null)
                {
                    Session["TaiKhoan"] = taikhoan;
                }
                else
                {
                    TaiKhoan tk = new TaiKhoan();
                    tk.Quyen = "0";
                    tk.HoTen = Username;
                    tk.HoTen = TenNguoiDung;
                    tk.Email = Email;
                    //tk.Hinh = Hinh;
                    //tk.NgayThamGia = DateTime.Now;
                    db.TaiKhoans.Add(tk);
                    db.SaveChanges();
                    Session["TaiKhoan"] = tk;
                }

                return Json(new { code = 200 }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception ex)
            {
                return Json(new { code = 500, msg = ex.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        public JsonResult CreateAcc(string email, string password, string name, string phone)
        {
            try
            {
                Boolean thanhcong = false;
                var taikhoan = (from c in db.TaiKhoans where c.Email == email select c).FirstOrDefault();
                if (taikhoan != null)
                {
                    return Json(new { code = 500 }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    thanhcong = true;
                    TaiKhoan tk = new TaiKhoan();
                    tk.HoTen = name;
                    
                    tk.Email = email;
                    tk.MatKhau = password;
                    tk.SDT = phone;
                    tk.Quyen = "";
                    //tk.Hinh = Hinh;
                    //tk.NgayThamGia = DateTime.Now;
                    db.TaiKhoans.Add(tk);
                    db.SaveChanges();
                    Session["TaiKhoan"] = tk;
                }

                return Json(new { code = 200, thanhcong = thanhcong }, JsonRequestBehavior.AllowGet);
            }
            catch(Exception e)
            {
                return Json(new { code = 500, msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
            
        }

        //Đã lưu
        public ActionResult Saved()
        {
            List<VeDaLuu> list = db.VeDaLuus.ToList();
            return View(list);
        }

        public JsonResult SavedTicket(int id)
        {
            try
            {
                TaiKhoan taikhoan = (TaiKhoan)Session["TaiKhoan"];
                VeDaLuu ve = new VeDaLuu();
                ChuyenBay chuyen = (from v in db.ChuyenBays where v.MaChuyenBay == id select v).SingleOrDefault();
                ve.MaChuyenBay = id;
                ve.MaTaiKhoan = taikhoan.MaTaiKhoan;
                db.VeDaLuus.Add(ve);
                db.SaveChanges();
                return Json(new { code = 200 }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { code = 500, msg = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }

        //Lịch sử đặt vé
        public ActionResult MyBooking()
        {
            TaiKhoan taikhoan = (TaiKhoan)Session["TaiKhoan"];
            List<Ve> lstVe = (from v in db.Ves where v.MaTaiKhoan == taikhoan.MaTaiKhoan orderby v.NgayDat descending select v).ToList();
            return View(lstVe);
        }

        public ActionResult Logout()
        {
            Session["Taikhoan"] = null;
            return RedirectToAction("Index", "Home");
        }


        //gửi mail quên mật khẩu
        public void SendEmail(string address, string subject, string message)
        {
            string email = "";
            string password = "";

            var loginInfo = new NetworkCredential(email, password);
            var msg = new System.Net.Mail.MailMessage();
            var smtpClient = new SmtpClient("smtp.gmail.com", 587);

            msg.From = new MailAddress(email);
            msg.To.Add(new MailAddress(address));
            msg.Subject = subject;
            msg.Body = message;
            msg.IsBodyHtml = true;

            smtpClient.EnableSsl = true;
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = loginInfo;
            smtpClient.Send(msg);
        }

        [HttpPost]
        public JsonResult ForgetPass(string email)
        {
            try
            {
                Boolean thanhcong = false;
                var checkEmail = db.TaiKhoans.SingleOrDefault(n => n.Email == email);
                if(checkEmail != null)
                {
                    thanhcong = true;
                    Random random = new Random();
                    string code = random.Next(1000, 9999).ToString();
                    string content = "<p>Tiêu đề: Quên mật khẩu </p>" + "<p>Mã code của bạn là: " + code + "</p>" + "<p>Vui lòng nhập mã code vào trang web để được tạo mới mật khẩu!</p>";
                    SendEmail(email, "Quên mật khẩu", content);
                    Session["EmailForgetPass"] = email;
                    Session["code"] = code;
                    return Json(new { code = 200, thanhcong = thanhcong }, JsonRequestBehavior.AllowGet) ;
                }
                else
                {
                    return Json(new { code = 500, thanhcong = thanhcong }, JsonRequestBehavior.AllowGet);
                }
                
            }
            catch(Exception e)
            {
                return Json(new { code = 500, msg = e.Message}, JsonRequestBehavior.AllowGet);
            }
            
        }

        [HttpPost]
        public JsonResult CreateNewPass(string code, string password)
        {
            try
            {
                Boolean thanhcong = false;
                string checkCode = Session["code"].ToString();
                string checkEmail = Session["EmailForgetPass"].ToString();
                var newPass = (from c in db.TaiKhoans where c.Email == checkEmail select c).FirstOrDefault();
                if (code == checkCode)
                {
                    thanhcong = true;
                    newPass.MatKhau = password;
                    db.SaveChanges();
                    
                    return Json(new { code = 200, thanhcong = thanhcong }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(new { code = 500, thanhcong = thanhcong }, JsonRequestBehavior.AllowGet);
                }

            }
            catch (Exception e)
            {
                return Json(new { code = 500, msg = e.Message }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}