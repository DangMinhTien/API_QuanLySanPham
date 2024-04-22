using System.Collections.Generic;

namespace WebApiNet5.Services
{
    public interface IHangHoaRepository
    {
        List<WebApiNet5.Models.HangHoaModel> GetAll(string search, double? from, double? to, string sort, int page = 1);
    }
}
