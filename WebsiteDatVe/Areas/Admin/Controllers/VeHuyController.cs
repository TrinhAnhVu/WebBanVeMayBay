using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.Mvc;
using WebsiteDatVe.Models;

namespace WebsiteDatVe.Areas.Admin.Controllers
{
    public class VeHuyController : Controller
    {
        DatVeDB db = new DatVeDB();
        // GET: Admin/VeHuy
        public ActionResult Index()
        {

            return View();
        }

        public JsonResult List()
        {
            var listVe = db.Ves.Where(v => v.TinhTrang.Equals("request")).ToList();
            
            //var ngaybay = (from v in listVe
            //               join t in db.ChuyenBays on v.MaChuyenBay equals t.MaChuyenBay
            //               select new
            //               {
            //                   ThoiGianDi = v.ChuyenBay.ThoiGianDi
            //               }).ToList();
            //ViewBag.ThoiGianDi = ngaybay;

            var data = (from v in listVe
                        join t in db.TaiKhoans on v.MaTaiKhoan equals t.MaTaiKhoan
                        join z in db.ChuyenBays on v.MaChuyenBay equals z.MaChuyenBay
                        select new
                        {
                            MaVe = v.MaVe,
                            MaChuyenBay = v.MaChuyenBay,
                            HangVe = v.HangVe.ToString(),
                            SoLuongGhe = v.SoLuongGhe,
                            TenKhachHang = t.HoTen,
                            NgayDat = v.NgayDat.ToString(),
                            TongTien = v.TongTien,
                            ThoiGianDi = z.ThoiGianDi.ToString(),
                            ThoiGianHuyVe = v.NgayHuyVe.ToString(),
                        }).OrderBy(v => v.ThoiGianHuyVe).ThenByDescending(v => v.ThoiGianHuyVe).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult Accept(Ve veHuy)
        {
            try
            {
                
                var preData = db.Ves.Where(v => v.MaVe == veHuy.MaVe).FirstOrDefault();
                var nguoiDatVe = db.NguoiDatVes.SingleOrDefault(v => v.MaVe == veHuy.MaVe);
                preData.TinhTrang = "Canceled";
                db.SaveChanges();
                string email = nguoiDatVe.Email;
                string content = "<p>Tiêu đề:Xác nhận hủy vé thành công </p>" + nguoiDatVe.MaVe;
                SendEmail(email, "Xác nhận hủy vé thành công", content);

                return Json(new { log = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { log = "ERR" }, JsonRequestBehavior.AllowGet);
            }

        }

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
        public JsonResult OverdueBrowsing(Ve veHuy)
        {
            try
            {
                var preData = db.Ves.Where(v => v.MaVe == veHuy.MaVe).FirstOrDefault();
                var nguoiDatVe = db.NguoiDatVes.SingleOrDefault(v => v.MaVe == veHuy.MaVe);
                string email = nguoiDatVe.Email;
                string content = "<p>Tiêu đề:Xác nhận hủy vé không thành công </p>" + nguoiDatVe.MaVe;
                preData.TinhTrang = "Overdue Browsing";
                db.SaveChanges();
                SendEmail(email, "Xác nhận hủy vé không thành công", content);
                return Json(new { log = "OK" }, JsonRequestBehavior.AllowGet);
            }
            catch(Exception e)
            {
                return Json(new { log = "ERR" }, JsonRequestBehavior.AllowGet);
            }
        }


        public JsonResult SearchByMaChuyenBay(long? searchKey)
        {
            var resultSearch = db.Ves.Where(v => (v.MaChuyenBay == searchKey)
            && v.TinhTrang.Equals("request") || (searchKey == null) && v.TinhTrang.Equals("request")).ToList();
            var data = (from v in resultSearch
                        join t in db.TaiKhoans on v.MaTaiKhoan equals t.MaTaiKhoan
                        select new
                        {
                            MaVe = v.MaVe,
                            MaChuyenBay = v.MaChuyenBay,
                            HangVe = v.HangVe.ToString(),
                            SoLuongGhe = v.SoLuongGhe,
                            TenKhachHang = t.HoTen,
                            NgayDat = v.NgayDat.ToString(),
                            TongTien = v.TongTien
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SearchByHangVe(string searchKey)
        {
            var resultSearch = db.Ves.Where(v => (v.HangVe == searchKey)
            && v.TinhTrang.Equals("request") || (searchKey == null)
                && v.TinhTrang.Equals("request")).ToList();
            var data = (from v in resultSearch
                        join t in db.TaiKhoans on v.MaTaiKhoan equals t.MaTaiKhoan
                        select new
                        {
                            MaVe = v.MaVe,
                            MaChuyenBay = v.MaChuyenBay,
                            HangVe = v.HangVe.ToString(),
                            SoLuongGhe = v.SoLuongGhe,
                            TenKhachHang = t.HoTen,
                            NgayDat = v.NgayDat.ToString(),
                            TongTien = v.TongTien
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SearchByTenKH(string searchKey)
        {
            var listVeHuy = db.Ves.Where(v => v.TinhTrang.Equals("request")).ToList();
            var listKH = db.TaiKhoans.Where(t => t.HoTen.StartsWith(searchKey)
            || searchKey == "").ToList();
            var listVe = (from v in listVeHuy
                          join t in listKH on v.MaTaiKhoan equals t.MaTaiKhoan
                          select new
                          {
                              MaVe = v.MaVe,
                              MaChuyenBay = v.MaChuyenBay,
                              HangVe = v.HangVe.ToString(),
                              SoLuongGhe = v.SoLuongGhe,
                              TenKhachHang = t.HoTen,
                              NgayDat = v.NgayDat.ToString(),
                              TongTien = v.TongTien
                          }).ToList();

            return Json(listVe, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SearchByMaVe(string searchKey)
        {
            var resultSearch = db.Ves.Where(v => (v.MaVe == searchKey)
            && v.TinhTrang.Equals("request") || (searchKey == null)
                && v.TinhTrang.Equals("request")).ToList();
            var data = (from v in resultSearch
                        join t in db.TaiKhoans on v.MaTaiKhoan equals t.MaTaiKhoan
                        select new
                        {
                            MaVe = v.MaVe,
                            MaChuyenBay = v.MaChuyenBay,
                            HangVe = v.HangVe.ToString(),
                            SoLuongGhe = v.SoLuongGhe,
                            TenKhachHang = t.HoTen,
                            NgayDat = v.NgayDat.ToString(),
                            TongTien = v.TongTien
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }

        public JsonResult SearchByNgayDat(string searchKey)
        {
            DateTime dateToSearch = DateTime.Parse(searchKey);
            var resultSearch = db.Ves.Where(v => (v.NgayDat.Value.Day == dateToSearch.Day)
            && (v.NgayDat.Value.Month == dateToSearch.Month)
            && (v.NgayDat.Value.Year == dateToSearch.Year)
            && v.TinhTrang.Equals("request") || (searchKey == null)
                && v.TinhTrang.Equals("request")).ToList();
            var data = (from v in resultSearch
                        join t in db.TaiKhoans on v.MaTaiKhoan equals t.MaTaiKhoan
                        select new
                        {
                            MaVe = v.MaVe,
                            MaChuyenBay = v.MaChuyenBay,
                            HangVe = v.HangVe.ToString(),
                            SoLuongGhe = v.SoLuongGhe,
                            TenKhachHang = t.HoTen,
                            NgayDat = v.NgayDat.ToString(),
                            TongTien = v.TongTien
                        }).ToList();

            return Json(data, JsonRequestBehavior.AllowGet);
        }
    }
}