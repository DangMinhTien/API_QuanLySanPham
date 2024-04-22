using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using WebApiNet5.Services;
using WebApiNet5.Data;
using WebApiNet5.Models;
using System.Linq;
using Microsoft.AspNetCore.Authorization;

namespace WebApiNet5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoaiController : ControllerBase
    {
        private readonly ILoaiRepository _loaiRepository;
        private readonly MyDbContext _context;
        public LoaiController(ILoaiRepository loaiRepository, MyDbContext context) 
        { 
            _loaiRepository = loaiRepository;
            _context = context;
        }
        [HttpGet]
        [Authorize]
        public IActionResult GetAll()
        {
            try
            {
                var loais = _loaiRepository.GetAll();
                return Ok(loais);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            try
            {
                var loai = _loaiRepository.GetById(id);
                if (loai == null)
                    return NotFound();
                return Ok(loai);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        [HttpPut("{id}")]
        public IActionResult Update(int id, LoaiVM loai)
        {
            if(id != loai.MaLoai)
                return BadRequest();
            try
            {
                if(_context.Loais.FirstOrDefault(lo => lo.MaLoai == id) == null)
                    return NotFound();
                _loaiRepository.Update(loai);
                return NoContent();
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        [HttpDelete("{id}")]
        public IActionResult Delete(int id)
        {
            try
            {
                if (_context.Loais.FirstOrDefault(lo => lo.MaLoai == id) == null)
                    return NotFound();
                _loaiRepository.Delete(id);
                return NoContent();
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        [HttpPost]
        [Authorize]
        public IActionResult Add(LoaiModel loaiModel)
        {
            try
            {
                var loai = _loaiRepository.Add(loaiModel);
                return Ok(loai);
            }
            catch
            {
                return StatusCode(StatusCodes.Status500InternalServerError);
            }

        }
    }
}
