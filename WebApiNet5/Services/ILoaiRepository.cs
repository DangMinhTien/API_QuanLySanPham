using System.Collections.Generic;
using WebApiNet5.Models;

namespace WebApiNet5.Services
{
    public interface ILoaiRepository
    {
        List<LoaiVM> GetAll();
        LoaiVM GetById(int id);
        LoaiVM Add(LoaiModel loaiModel);
        void Update(LoaiVM loaiVM);
        void Delete(int id);
    }
}
