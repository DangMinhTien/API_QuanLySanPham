using System;

namespace WebApiNet5.Data
{
    public class ChiTietDonHang
    {
        public Guid MaHh { get; set; }
        public Guid MaDH { get; set; }
        public int SoLuong { get; set; }
        public double DonGia { get; set; }
        public byte GiamGia { get; set; }
        public DonHang DonHang { get; set; }
        public HangHoa hangHoa { get; set; }
    }
}
