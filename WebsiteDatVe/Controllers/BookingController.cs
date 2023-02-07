using MoMo;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Mail;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using System.Web.Script.Serialization;
using WebsiteDatVe.Models;

namespace WebsiteDatVe.Controllers
{
    public class BookingController : Controller
    {
        private DatVeDB db = new DatVeDB();


        private static readonly log4net.ILog log = log4net.LogManager.GetLogger(System.Reflection.MethodBase.GetCurrentMethod().DeclaringType);
        public ActionResult Checkout(long id, double giave, long? idKhuHoi, double giaveKhuHoi)
        {
            ThongTinDatVe thongtin = (ThongTinDatVe)Session["ThongTinDatVe"];
            ViewBag.DiemDi = db.SanBays.Where(x => x.MaSanBay.Equals(thongtin.DiemDi)).Select(x => x.TenSanBay).SingleOrDefault();
            ViewBag.DiemDen = db.SanBays.Where(x => x.MaSanBay.Equals(thongtin.DiemDen)).Select(x => x.TenSanBay).SingleOrDefault();
            ViewBag.SoLuong = thongtin.NguoiLon + thongtin.TreEm + thongtin.EmBe;

            //double giave = (double)db.ChuyenBays.Where(x => x.MaChuyenBay == id).Select(x => x.Gia).SingleOrDefault();
            double giaHangVe = 1;
            double giavetong = giave + giaveKhuHoi;

            if (thongtin.HangGhe.Trim() == "Phổ thông")
            {
                giaHangVe = giavetong;
            }
            else if (thongtin.HangGhe.Trim() == "Phổ thông đặc biệt")
            {
                giaHangVe = giavetong * 1.2;
            }
            else if (thongtin.HangGhe.Trim() == "Thương gia")
            {
                giaHangVe = giavetong * 1.4;
            }
            else if (thongtin.HangGhe.Trim() == "Hạng nhất")
            {
                giaHangVe = giavetong * 1.8;
            }


            ViewBag.GiaVeNguoiLon = (giaHangVe * thongtin.NguoiLon);
            ViewBag.GiaVeTreEm = giaHangVe * 0.75 * thongtin.TreEm;
            ViewBag.GiaVeEmBe = 110000 * thongtin.EmBe;

            double tongtam = 0;

            double giaHanhLi = 1;
            double giaTongHanhLi = giave + giaveKhuHoi;
            if (thongtin.HanhLi.Trim() == "Xách tay")
            {
                giaHanhLi = 0;
                ViewBag.HanhLi = 0;
            }
            else
            {
                giaHanhLi = 300000;
                ViewBag.HanhLi = giaHanhLi;
            }

            tongtam = giaHangVe * thongtin.NguoiLon + giaHangVe * 0.75 * thongtin.TreEm + 110000 * thongtin.EmBe + giaHanhLi;
            ViewBag.TongTamTinh = tongtam;
            double thue = (double)(tongtam * 0.1);
            ViewBag.Thue = thue;
            ViewBag.TongCong = tongtam + thue;

            ViewBag.MaChuyenBay1 = id;
            ViewBag.MaChuyenBay2 = idKhuHoi;

            Session["TongTien1"] = TinhGiaVe(giave);

            if(idKhuHoi == null)
            {
                Session["TongTien2"] = giaveKhuHoi;
            }
            else
            {

                Session["TongTien2"] = TinhGiaVe(giaveKhuHoi);
            }

            

            return View();
        }

        public double TinhGiaVe(double gia)
        {
            ThongTinDatVe thongtin = (ThongTinDatVe)Session["ThongTinDatVe"];
            double giaHangVe = 1;
            if (thongtin.HangGhe.Trim() == "Phổ thông")
            {
                giaHangVe = gia;
            }
            else if (thongtin.HangGhe.Trim() == "Phổ thông đặc biệt")
            {
                giaHangVe = gia * 1.2;
            }
            else if (thongtin.HangGhe.Trim() == "Thương gia")
            {
                giaHangVe = gia * 1.4;
            }
            else if (thongtin.HangGhe.Trim() == "Hạng nhất")
            {
                giaHangVe = gia * 1.8;
            }

            double giaHanhLi = 1;

            if (thongtin.HanhLi.Trim() == "Xách tay")
            {
                giaHanhLi = 0;

            }
            else
            {
                giaHanhLi = 300000;

            }
            double tongtien = giaHangVe * thongtin.NguoiLon + giaHangVe * 0.75 * thongtin.TreEm + 110000 * thongtin.EmBe + giaHanhLi;
            return tongtien + tongtien * 0.1;
        }

        public Ve CreateTicket(string arr, long? machuyenbay, double tongtien, string nguoidat)
        {
            var listCus = new JavaScriptSerializer().Deserialize<List<KhachHang>>(arr);
            var obj = new JavaScriptSerializer().Deserialize<NguoiDatVe>(nguoidat);

            TaiKhoan taikhoan = (TaiKhoan)Session["TaiKhoan"];
            ThongTinDatVe thongtin = (ThongTinDatVe)Session["ThongTinDatVe"];



            //Đặt vé
            Ve ve = new Ve();
            ve.MaVe = taikhoan.MaTaiKhoan + DateTime.Now.ToString("MM/dd/yyyy HH:mm:ss");
            ve.MaChuyenBay = machuyenbay;
            ve.HangVe = thongtin.HangGhe;
            ve.SoLuongGhe = thongtin.NguoiLon + thongtin.TreEm;
            ve.MaTaiKhoan = taikhoan.MaTaiKhoan;
            ve.TinhTrang = "Processing";
            ve.NgayDat = DateTime.Now;
            ve.TongTien = tongtien;
            db.Ves.Add(ve);
            db.SaveChanges();


            //Thêm khách hàng
            foreach (var item in listCus)
            {
                KhachHang khachhang = new KhachHang();
                khachhang.Ho = item.Ho;
                khachhang.Ten = item.Ten;
                khachhang.SDT = item.SDT;
                khachhang.NgaySinh = item.NgaySinh;
                khachhang.CMND = item.CMND;
                khachhang.QuocTich = item.QuocTich;
                khachhang.MaVe = ve.MaVe;
                khachhang.LoaiKhachHang = item.LoaiKhachHang;
                db.KhachHangs.Add(khachhang);
                db.SaveChanges();
            }

            //Thêm người đặt
            NguoiDatVe nguoiDatVe = new NguoiDatVe();
            nguoiDatVe.Ho = obj.Ho;
            nguoiDatVe.Ten = obj.Ten;
            nguoiDatVe.SDT = obj.SDT;
            nguoiDatVe.Email = obj.Email;
            nguoiDatVe.MaVe = ve.MaVe;
            db.NguoiDatVes.Add(nguoiDatVe);
            db.SaveChanges();

            Session["NguoiDatVe"] = nguoiDatVe;
            return ve;
        }

        public JsonResult TaoVe(string arr, long machuyenbay1, long? machuyenbay2, string nguoidat)
        {
            try
            {
                double tongtien1 = (double)Session["TongTien1"];
                double tongtien2 = (double)Session["TongTien2"];

                Ve ve1 = CreateTicket(arr, machuyenbay1, tongtien1, nguoidat);
                Session["MaVe1"] = ve1.MaVe;

                if (machuyenbay2 != null)
                {
                    Ve ve2 = CreateTicket(arr, machuyenbay2, tongtien1, nguoidat);
                    Session["MaVe2"] = ve2.MaVe;
                }

                return Json(new { code = 200 }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { code = 500, msg = e.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Ticket(string id)
        {
            Ve ve = (from v in db.Ves where v.MaVe == id select v).SingleOrDefault();

            //Sân bay
            ViewBag.DiemDi = db.SanBays.Where(x => x.MaSanBay == ve.ChuyenBay.DiemDi).Select(x => x.TenSanBay).SingleOrDefault();
            ViewBag.DiemDen = db.SanBays.Where(x => x.MaSanBay == ve.ChuyenBay.DiemDen).Select(x => x.TenSanBay).SingleOrDefault();

            return View(ve);
        }

            

        public async Task<ActionResult> ThanhToanMomo()
        {
            double tongtien = (double)Session["TongTien1"] + (double)Session["TongTien2"];

            string serectkey = "sFcbSGRSJjwGxwhhcEktCHWYUuTuPNDB";
            string partnerCode = "MOMOOJOI20210710";
            string accessKey = "iPXneGmrJH0G8FOP";
            string orderId = Guid.NewGuid().ToString();
            string requestId = Guid.NewGuid().ToString();
            string extraData = "";
            string orderInfo = "THANH TOÁN VÉ MÁY BAY";
            string amount = tongtien + "";
            string redirectUrl = "https://localhost:44309/Booking/returnUrl";
            string ipnUrl = "https://localhost:44309/Booking/notifyurl";
            string requestType = "captureWallet";
            //Before sign HMAC SHA256 signature
            string rawHash = "accessKey=" + accessKey +
                "&amount=" + amount +
                "&extraData=" + extraData +
                "&ipnUrl=" + ipnUrl +
                "&orderId=" + orderId +
                "&orderInfo=" + orderInfo +
                "&partnerCode=" + partnerCode +
                "&redirectUrl=" + redirectUrl +
                "&requestId=" + requestId +
                "&requestType=" + requestType
                ;


            MoMoSecurity crypto = new MoMoSecurity();
            //sign signature SHA256
            string signature = crypto.signSHA256(rawHash, serectkey);


            //build body json request
            JObject message = new JObject
            {
                { "partnerCode", partnerCode },
                { "partnerName", "Test" },
                { "storeId", "MomoTestStore" },
                { "requestId", requestId },
                { "amount", amount },
                { "orderId", orderId },
                { "orderInfo", orderInfo },
                { "redirectUrl", redirectUrl },
                { "ipnUrl", ipnUrl },
                { "lang", "en" },
                { "extraData", extraData },
                { "requestType", requestType },
                { "signature", signature }

            };
            var httpClient = new HttpClient();

            var httpContent = new StringContent(message.ToString(), Encoding.UTF8, "application/json");

            HttpResponseMessage response = await httpClient.PostAsync("https://test-payment.momo.vn/v2/gateway/api/create", httpContent);
            string a = await response.Content.ReadAsStringAsync();
            JObject jmessage = JObject.Parse(a);
            return Redirect(jmessage.GetValue("payUrl").ToString());
        }

        public string DisplayMail(string mave)
        {
            var nguoidatve = db.NguoiDatVes.SingleOrDefault(n => n.MaVe == mave);
            string email = nguoidatve.Email;
            return email;
        }

        public ActionResult  returnUrl()
        {
            string param = Request.QueryString.ToString().Substring(0, Request.QueryString.ToString().IndexOf("signature") - 1);

            //Thành công

            string mave1 = Session["MaVe1"].ToString();

            if (Request.QueryString["message"].Equals("Successful."))
            {
                
                //Thay đổi trạng thái vé
                Ve ve1 = (from v in db.Ves where v.MaVe == mave1 select v).FirstOrDefault();
                ve1.TinhTrang = "Paid";
                db.SaveChanges();
                ViewBag.Message = "Đặt vé thành công! Vui lòng vào lịch sử đặt vé để kiểm tra";
                string content = "<p>Tiêu đề:Xác nhận mua vé thành công </p>"+ ve1.MaVe ;
                SendEmail(DisplayMail(mave1), "Xác nhận mua vé thành công", content);
                if (Session["MaVe2"] != null)
                {
                    string mave2 = Session["MaVe2"].ToString();
                    Ve ve2 = (from v in db.Ves where v.MaVe == mave2 select v).FirstOrDefault();
                    ve2.TinhTrang = "Paid";
                    db.SaveChanges(); 
                    content = "<p>Tiêu đề:Xác nhận mua vé khứ hồi thành công </p>" + ve2.MaVe;
                    SendEmail(DisplayMail(mave1), "Xác nhận mua vé thành công", content);
                }
            }
            else
            {
                ViewBag.Message = "Thanh toán thất bại!";
                //Thay đổi trạng thái vé
                Ve ve1 = (from v in db.Ves where v.MaVe == mave1 select v).FirstOrDefault();
                ve1.TinhTrang = "Canceled";
                db.SaveChanges();
                string content = "<p>Tiêu đề:Xác nhận mua vé thất bại </p>" + ve1.MaVe;
                SendEmail(DisplayMail(mave1), "Xác nhận mua vé thất bại", content);
                if (Session["MaVe2"] != null)
                {
                    string mave2 = Session["MaVe2"].ToString();
                    Ve ve2 = (from v in db.Ves where v.MaVe == mave2 select v).FirstOrDefault();
                    ve2.TinhTrang = "Canceled";
                    db.SaveChanges();
                    content = "<p>Tiêu đề:Xác nhận mua vé khứ hồi thất bại </p>" + ve2.MaVe;
                    SendEmail(DisplayMail(mave1), "Xác nhận mua vé thất bại", content);
                }
                return View();

            }
            return View();
        }

        public JsonResult notifyurl()
        {
            return Json(new { code = 200 }, JsonRequestBehavior.AllowGet);
        }

        public JsonResult getKhachHang(string mave)
        {
            try
            {
                var lstKhachHang = (from k in db.KhachHangs
                                    where k.MaVe == mave
                                    select new
                                    {
                                        HoTen = k.Ho + k.Ten,
                                        LoaiKhachHang = k.LoaiKhachHang
                                    }).ToList();

                return Json(new { code = 200, lst = lstKhachHang }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { code = 500 }, JsonRequestBehavior.AllowGet);
            }
        }

        public JsonResult HuyVe(string mave)
        {
            try
            {
                Ve ve = (from v in db.Ves where v.MaVe == mave select v).SingleOrDefault();
                ve.NgayHuyVe = DateTime.Now;
                ve.TinhTrang = "request";
                db.SaveChanges();

                return Json(new { code = 200 }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception e)
            {
                return Json(new { code = 500 }, JsonRequestBehavior.AllowGet);
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


        //thanh toán VNPay
        public ActionResult Payment()
        {
            double tongtien = (double)Session["TongTien1"] + (double)Session["TongTien2"];

            string url = ConfigurationManager.AppSettings["Url"];
            string returnUrl = ConfigurationManager.AppSettings["ReturnUrl"];
            string tmnCode = ConfigurationManager.AppSettings["TmnCode"];
            string hashSecret = ConfigurationManager.AppSettings["HashSecret"];

            PayLib pay = new PayLib();

            pay.AddRequestData("vnp_Version", "2.0.0"); //Phiên bản api mà merchant kết nối. Phiên bản hiện tại là 2.0.0
            pay.AddRequestData("vnp_Command", "pay"); //Mã API sử dụng, mã cho giao dịch thanh toán là 'pay'
            pay.AddRequestData("vnp_TmnCode", tmnCode); //Mã website của merchant trên hệ thống của VNPAY (khi đăng ký tài khoản sẽ có trong mail VNPAY gửi về)
            pay.AddRequestData("vnp_Amount", tongtien*100 + ""); //số tiền cần thanh toán, công thức: số tiền * 100 - ví dụ 10.000 (mười nghìn đồng) --> 1000000
            pay.AddRequestData("vnp_BankCode", ""); //Mã Ngân hàng thanh toán (tham khảo: https://sandbox.vnpayment.vn/apis/danh-sach-ngan-hang/), có thể để trống, người dùng có thể chọn trên cổng thanh toán VNPAY
            pay.AddRequestData("vnp_CreateDate", DateTime.Now.ToString("yyyyMMddHHmmss")); //ngày thanh toán theo định dạng yyyyMMddHHmmss
            pay.AddRequestData("vnp_CurrCode", "VND"); //Đơn vị tiền tệ sử dụng thanh toán. Hiện tại chỉ hỗ trợ VND
            pay.AddRequestData("vnp_IpAddr", Util.GetIpAddress()); //Địa chỉ IP của khách hàng thực hiện giao dịch
            pay.AddRequestData("vnp_Locale", "vn"); //Ngôn ngữ giao diện hiển thị - Tiếng Việt (vn), Tiếng Anh (en)
            pay.AddRequestData("vnp_OrderInfo", "THANH TOÁN VÉ MÁY BAY"); //Thông tin mô tả nội dung thanh toán
            pay.AddRequestData("vnp_OrderType", "other"); //topup: Nạp tiền điện thoại - billpayment: Thanh toán hóa đơn - fashion: Thời trang - other: Thanh toán trực tuyến
            pay.AddRequestData("vnp_ReturnUrl", returnUrl); //URL thông báo kết quả giao dịch khi Khách hàng kết thúc thanh toán
            pay.AddRequestData("vnp_TxnRef", DateTime.Now.Ticks.ToString()); //mã hóa đơn

            string paymentUrl = pay.CreateRequestUrl(url, hashSecret);

            return Redirect(paymentUrl);
        }

        public ActionResult PaymentConfirm()
        {
            if (Request.QueryString.Count > 0)
            {
                string hashSecret = ConfigurationManager.AppSettings["HashSecret"]; //Chuỗi bí mật
                var vnpayData = Request.QueryString;
                PayLib pay = new PayLib();

                //lấy toàn bộ dữ liệu được trả về
                foreach (string s in vnpayData)
                {
                    if (!string.IsNullOrEmpty(s) && s.StartsWith("vnp_"))
                    {
                        pay.AddResponseData(s, vnpayData[s]);
                    }
                }

                long orderId = Convert.ToInt64(pay.GetResponseData("vnp_TxnRef")); //mã hóa đơn
                long vnpayTranId = Convert.ToInt64(pay.GetResponseData("vnp_TransactionNo")); //mã giao dịch tại hệ thống VNPAY
                string vnp_ResponseCode = pay.GetResponseData("vnp_ResponseCode"); //response code: 00 - thành công, khác 00 - xem thêm https://sandbox.vnpayment.vn/apis/docs/bang-ma-loi/
                string vnp_SecureHash = Request.QueryString["vnp_SecureHash"]; //hash của dữ liệu trả về

                bool checkSignature = pay.ValidateSignature(vnp_SecureHash, hashSecret); //check chữ ký đúng hay không?

                if (checkSignature)
                {
                    if (vnp_ResponseCode == "00")
                    {
                        NguoiDatVe nguoiDatVe = (NguoiDatVe)Session["NguoiDatVe"];
                        string email = nguoiDatVe.Email;
                        string content = "<p>Tiêu đề:Xác nhận mua vé thành công </p>" + nguoiDatVe.MaVe;
                        SendEmail(email, "Xác nhận mua vé thành công", content);
                        //Thanh toán thành công
                        ViewBag.Message = "Thanh toán thành công hóa đơn " + orderId + " | Mã giao dịch: " + vnpayTranId;

                    }
                    else
                    {
                        NguoiDatVe nguoiDatVe = (NguoiDatVe)Session["NguoiDatVe"];
                        string email = nguoiDatVe.Email;
                        string content = "<p>Tiêu đề:Xác nhận mua vé thất bại </p>" + nguoiDatVe.MaVe;
                        SendEmail(email, "Xác nhận mua vé thất bại", content);
                        //Thanh toán không thành công. Mã lỗi: vnp_ResponseCode
                        ViewBag.Message = "Có lỗi xảy ra trong quá trình xử lý hóa đơn " + orderId + " | Mã giao dịch: " + vnpayTranId + " | Mã lỗi: " + vnp_ResponseCode;
                    }
                }
                else
                {
                    ViewBag.Message = "Có lỗi xảy ra trong quá trình xử lý";
                }
            }

            return View();
        }

    }
}