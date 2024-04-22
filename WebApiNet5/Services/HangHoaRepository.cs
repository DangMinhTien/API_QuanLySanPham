using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using WebApiNet5.Data;
using WebApiNet5.Models;
namespace WebApiNet5.Services
{
    public class HangHoaRepository : IHangHoaRepository
    {
        private readonly MyDbContext _context;
        private static int Page_size = 2;
        public HangHoaRepository(MyDbContext context)
        {
            _context = context;
        }

        public List<WebApiNet5.Models.HangHoaModel> GetAll(string search, double? from, double? to, string sort, int page = 1)
        {
            var allproduct = _context.HangHoas.Include(hh => hh.Loai).AsQueryable();

            if(!string.IsNullOrEmpty(search) )
            {
                allproduct = allproduct.Where(hh => hh.TenHh.Contains(search));
            }
            if (from.HasValue)
            {
                allproduct = allproduct.Where(hh => hh.DonGia >= from.Value);
            }
            if (to.HasValue)
            {
                allproduct = allproduct.Where(hh => hh.DonGia <= to.Value);
            }
            #region Sorting
            allproduct = allproduct.OrderBy(hh => hh.TenHh);
            if (!string.IsNullOrEmpty(sort))
            {
                switch (sort)
                {
                    case "gia_asc":
                        allproduct = allproduct.OrderBy(hh => hh.DonGia);
                        break;
                    case "gia_desc":
                        allproduct = allproduct.OrderByDescending(hh => hh.DonGia);
                        break;
                    case "tenhh_desc":
                        allproduct = allproduct.OrderByDescending(hh => hh.TenHh);
                        break;
                }
            }
            #endregion
            //#region Paging
            //var totalpage = (int)Math.Ceiling(allproduct.Count() / (double)Page_size);
            //if (page < 1)
            //    page = 1;
            //if(page > totalpage) 
            //    page = totalpage;
            //allproduct = allproduct.Skip((page - 1) * Page_size).Take(Page_size);
            //#endregion
            //var result = allproduct.ToList().Select(hh => new WebApiNet5.Models.HangHoaModel
            //{
            //    MaHh = hh.MaHh,
            //    TenHh = hh.TenHh,
            //    DonGia = hh.DonGia,
            //    MoTa = hh.MoTa,
            //    GiamGia = hh.GiamGia,
            //    TenLoai = hh.Loai?.TenLoai,
            //}).ToList();
            //return result;


            #region Paging 2
            var result = PaginatedList<WebApiNet5.Data.HangHoa>.Create(allproduct, page, Page_size)
                            .Select(hh => new WebApiNet5.Models.HangHoaModel
                            {
                                MaHh = hh.MaHh,
                                TenHh = hh.TenHh,
                                DonGia = hh.DonGia,
                                MoTa = hh.MoTa,
                                GiamGia = hh.GiamGia,
                                TenLoai = hh.Loai?.TenLoai,
                            }).ToList();
            return result;
            #endregion
        }

    }
}
