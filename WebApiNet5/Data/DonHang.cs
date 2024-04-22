using System;
using System.Collections.Generic;

namespace WebApiNet5.Data
{
    public enum TinhTrangDonDatHang
    {
        New = 0,
        Payment = 1,
        Complete = 2,
        Cancel = -1
    }
    public class DonHang
    {
        public Guid MaDH { get; set; }
        public DateTime NgayDat { get; set; }
        public DateTime? NgayGiao { get; set; }
        public TinhTrangDonDatHang TinhTrangDonHang { get; set; }
        public string NguoiNhan { get; set; }
        public string DiaChiGiaoHang { get; set; }
        public string SoDienThoai {  get; set; }
        public ICollection<ChiTietDonHang> ChiTietDonHang { get; set; }
        public DonHang()
        {
            ChiTietDonHang = new List<ChiTietDonHang>();
        }
    }
}
