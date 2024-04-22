using System.Collections.Generic;
using WebApiNet5.Models;
using WebApiNet5.Data;
using System.Linq;

namespace WebApiNet5.Services
{
    public class LoaiRepository : ILoaiRepository
    {
        public readonly MyDbContext _context;
        public LoaiRepository(MyDbContext context)
        {
            _context = context;
        }
        public LoaiVM Add(LoaiModel loaiModel)
        {
            var loai = new Loai()
            {
                TenLoai = loaiModel.TenLoai,
            };
            _context.Loais.Add(loai);
            _context.SaveChanges();
            return new LoaiVM
            {
                MaLoai = loai.MaLoai,
                TenLoai = loai.TenLoai
            };
        }

        public void Delete(int id)
        {
            var loai = _context.Loais.FirstOrDefault(lo => lo.MaLoai == id);
            if (loai != null)
            {
                _context.Loais.Remove(loai);
                _context.SaveChanges();
            }
        }

        public List<LoaiVM> GetAll()
        {
            var loais = _context.Loais.Select(lo => new LoaiVM { 
                                        MaLoai = lo.MaLoai, 
                                        TenLoai = lo.TenLoai 
                                    }).ToList();
            return loais;
        }

        public LoaiVM GetById(int id)
        {
            var loai = _context.Loais.FirstOrDefault(lo => lo.MaLoai == id);
            if (loai == null)
                return null;
            return new LoaiVM
            {
                MaLoai = loai.MaLoai,
                TenLoai = loai.TenLoai
            };
        }

        public void Update(LoaiVM loaiVM)
        {
            var _loai = _context.Loais.FirstOrDefault(lo => lo.MaLoai == loaiVM.MaLoai);
            if(_loai != null)
            {
                _loai.TenLoai = loaiVM.TenLoai;
                _context.Loais.Update(_loai);
                _context.SaveChanges();
            }
        }
    }
}
