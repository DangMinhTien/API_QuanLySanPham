using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using WebApiNet5.Data;
using WebApiNet5.Models;

namespace WebApiNet5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class LoaisController : ControllerBase
    {
        public readonly MyDbContext _context;
        public LoaisController(MyDbContext context)
        {
            _context = context;   
        }
        [HttpGet]
        public IActionResult getAll()
        {
            try
            {
                var dsloai = _context.Loais.ToList();
                return Ok(dsloai);
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpGet("{id}")]
        public IActionResult GetById(int id)
        {
            var loai = _context.Loais.FirstOrDefault(l => l.MaLoai == id);
            if(loai == null)
                return NotFound();
            return Ok(loai);
        }
        [HttpPost]
        public IActionResult Create(LoaiModel loaiModel)
        {
            var loai = new Loai()
            {
                TenLoai = loaiModel.TenLoai,
            };
            try
            {
                _context.Loais.Add(loai);
                _context.SaveChanges();
            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
            return StatusCode(StatusCodes.Status201Created, loai);
        }
        [HttpPut("{id}")]
        public IActionResult Edit(int id,LoaiModel loaiModel)
        {
            var loai = _context.Loais.FirstOrDefault(l => l.MaLoai == id);
            if(loai == null)
            {
                return NotFound();
            }
            else
            {
                loai.TenLoai = loaiModel.TenLoai;
                try
                {
                    _context.Update(loai);
                    _context.SaveChanges();
                }
                catch(Exception ex)
                {
                    return BadRequest(ex.Message);
                }
                return NoContent();
            }
        }
        [HttpDelete("{id}")]
        public IActionResult DeleteLoaiById(int id)
        {
            var loai = _context.Loais.FirstOrDefault(l => l.MaLoai == id);
            if (loai == null)
                return NotFound();
            try
            {
                _context.Loais.Remove(loai);
                _context.SaveChanges();
            }
            catch
            {
                return BadRequest();
            }
            return StatusCode(StatusCodes.Status200OK);
        }
    }
}
