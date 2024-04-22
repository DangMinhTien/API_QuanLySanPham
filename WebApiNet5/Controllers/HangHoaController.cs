using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using WebApiNet5.Models;

namespace WebApiNet5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class HangHoaController : ControllerBase
    {
        public static List<HangHoa> hangHoas = new List<HangHoa>();
        [HttpGet]
        public IActionResult GetAll()
        {
            return Ok(hangHoas);
        }
        [HttpPost]
        public IActionResult Create(HangHoaVM hangHoaVM)
        {
            var hanghoa = new HangHoa()
            {
                MaHangHoa = Guid.NewGuid(),
                TenHangHoa = hangHoaVM.TenHangHoa,
                DonGia = hangHoaVM.DonGia
            };
            hangHoas.Add(hanghoa);
            return Ok(new
            {
                success = true,
                data = hangHoas
            });
        }
        [HttpGet("{id}")]
        //[Route("/[controller]/[action]/{id}")]
        public IActionResult FindById(string? id)
        {
            try
            {
                var hanghoa = hangHoas.FirstOrDefault(h => h.MaHangHoa == Guid.Parse(id));
                if(hanghoa == null)
                {
                    return NotFound();
                }
                return Ok(new
                {
                    success = true,
                    data = hanghoa
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpPut]
        public IActionResult Edit(string id, HangHoa hangHoaEdit)
        {
            try
            {
                if(Guid.Parse(id) != hangHoaEdit.MaHangHoa)
                    return BadRequest();
                var hanghoa = hangHoas.FirstOrDefault(h => h.MaHangHoa == Guid.Parse(id));
                if (hanghoa == null)
                {
                    return NotFound();
                }
                hanghoa.TenHangHoa = hangHoaEdit.TenHangHoa;
                hanghoa.DonGia = hangHoaEdit.DonGia;
                return Ok(new
                {
                    success = true,
                    data = hanghoa
                });

            }
            catch(Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
        [HttpDelete]
        public IActionResult Delete(string id)
        {
            try
            {
                var hanghoa = hangHoas.FirstOrDefault(h => h.MaHangHoa == Guid.Parse(id));
                if (hanghoa == null)
                {
                    return NotFound();
                }
                hangHoas.Remove(hanghoa);
                return Ok(new
                {
                    success = true,
                    data = hangHoas
                });
            }
            catch (Exception ex)
            {
                return BadRequest(ex.Message);
            }
        }
    }
}
