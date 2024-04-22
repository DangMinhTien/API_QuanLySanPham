using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Text.Json;
using WebApiNet5.Data;
using WebApiNet5.Services;

namespace WebApiNet5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly MyDbContext _context;
        private readonly IHangHoaRepository _hangHoaRepository;
        public ProductController(MyDbContext context ,IHangHoaRepository hangHoaRepository)
        {

            _hangHoaRepository = hangHoaRepository;
            _context = context;
        }
        [HttpGet]
        public IActionResult GetAll(string search, double? from, double? to, string sort, int page = 1)
        {
            try
            {
                var result = _hangHoaRepository.GetAll(search, from, to, sort, page);
                return StatusCode(StatusCodes.Status200OK, result);
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
