using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;
using WebApiNet5.Data;
using WebApiNet5.Models;

namespace WebApiNet5.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly MyDbContext _context;
        private readonly AppSettings _appSettings;
        public UserController(MyDbContext context, IOptionsMonitor<AppSettings> appSettings)
        {
            _context = context;
            _appSettings = appSettings.CurrentValue;
        }
        private async Task<TokenModel> GenerateToken(NguoiDung nguoiDung)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);
            var tokenDecreption = new SecurityTokenDescriptor()
            {
                Subject = new ClaimsIdentity(new List<Claim>
                {
                    new Claim(ClaimTypes.Email, nguoiDung.Email),
                    new Claim(JwtRegisteredClaimNames.Email, nguoiDung.Hoten),
                    new Claim(JwtRegisteredClaimNames.Sub, nguoiDung.Hoten),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()), // đây là tokenId(accessToken)
                    new Claim("UserName", nguoiDung.UserName),
                    new Claim("Id", nguoiDung.Id.ToString()),

                    // role
                }),
                Expires = DateTime.UtcNow.AddSeconds(30),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(secretKeyBytes),
                        SecurityAlgorithms.HmacSha512Signature)

            };
            var token = jwtTokenHandler.CreateToken(tokenDecreption);
            var accessToken = jwtTokenHandler.WriteToken(token);
            var refreshToken = GenerateRefreshToken();
            // lưu refreshtoken và database
            var refreshtokenEntity = new RefreshToken()
            {
                Id = Guid.NewGuid(),
                Token = refreshToken,
                jwtId = token.Id,
                IsUsed = false,
                IsRevoked = false,
                IssuedAt = DateTime.UtcNow,
                ExpiredAt = DateTime.UtcNow.AddHours(1),
                UserId = nguoiDung.Id
            };
            await _context.RefreshTokens.AddAsync(refreshtokenEntity);
            await _context.SaveChangesAsync();
            return new TokenModel
            {
                AccessToken = accessToken,
                RefreshToken = refreshToken              
            };
        } 
        private string GenerateRefreshToken()
        {
            var random = new Byte[32];
            using(var rng = RandomNumberGenerator.Create())
            {
                rng.GetBytes(random);

                return Convert.ToBase64String(random);
            }
        }
        [HttpPost("Login")]
        public async Task<IActionResult> Validate(LoginModel loginModel)
        {
            var user = _context.NguoiDungs
                .FirstOrDefault(nd => nd.UserName == loginModel.UserName && nd.Password == loginModel.Password);
            if (user == null)
            {
                return Ok(new ApiResponse
                {
                    Success = false,
                    Message = "Invalid UserName or Password",
                    Data = null
                });
            }
            var token = await GenerateToken(user);
            // cấp token
            return Ok(new ApiResponse
            {
                Success = true,
                Message = "Authenticate is Success",
                Data = token
            });
        }
        [HttpPost("RenewToken")]
        public async Task<IActionResult> RenewToken(TokenModel tokenModel)
        {
            var jwtTokenHandler = new JwtSecurityTokenHandler();
            var secretKeyBytes = Encoding.UTF8.GetBytes(_appSettings.SecretKey);
            var tokenValidateParam = new Microsoft.IdentityModel.Tokens.TokenValidationParameters()
            {
                //tự cấp token
                ValidateIssuer = false,
                ValidateAudience = false,
                // ký vào token
                ValidateIssuerSigningKey = true,
                IssuerSigningKey = new SymmetricSecurityKey(secretKeyBytes),

                ClockSkew = TimeSpan.Zero,

                ValidateLifetime = false // không kiểm tra token hết hạn
            };
            try
            {

                // check 1: kiểm tra accessToken đúng fomat không 
                var tokenInverification = jwtTokenHandler.ValidateToken(tokenModel.AccessToken,
                    tokenValidateParam, out var validatedToken);
                // chech 2: kiểm tra thuật toán
                if(validatedToken is JwtSecurityToken jwtSecurityToken)
                {
                    var result = jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha512);
                    if(!result)
                    {
                        return Ok(new ApiResponse
                        {
                            Success = false,
                            Message = "Invalid Token ko đúng"
                        });
                    }
                }
                // check 3: kiểm tra token đã hết hạn chưa
                var utcExpireDate = long.Parse(tokenInverification.Claims
                            .FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Exp).Value);
                var ExpireDate = CovertToDateTime(utcExpireDate);
                if(ExpireDate > DateTime.UtcNow) // đáng nhẽ phải ExpireDate < DateTime.UtcNow nhưng không được do covert utcExpireDate ra bị sai 
                {
                    return Ok(new ApiResponse
                    {
                        Success = false,
                        Message = "AccessToken has not yet expired"
                    });
                }
                // check 4: kiểm tra refresh có trong db không
                var storedToken = _context.RefreshTokens.FirstOrDefault(rt => rt.Token == tokenModel.RefreshToken);
                if(storedToken == null)
                {
                    return Ok(new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token is not found in database"
                    });
                }
                // check 5: kiểm tra refresh token đã được dùng hoặc đã bị thu hồi hay chưa
                if(storedToken.IsUsed)
                {
                    return Ok(new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token has been used"
                    });
                }
                if (storedToken.IsRevoked)
                {
                    return Ok(new ApiResponse
                    {
                        Success = false,
                        Message = "Refresh token has been revoked"
                    });
                }
                // check 6: kiểm tra AccessToken Id == jwtId in refreshToken
                var jti = tokenInverification.Claims.FirstOrDefault(c => c.Type == JwtRegisteredClaimNames.Jti).Value;
                if(jti != storedToken.jwtId)
                {
                    return Ok(new ApiResponse
                    {
                        Success = false,
                        Message = "AccessToken Id is not match jwtId in refreshToken"
                    });
                }
                // update refresh token is used
                storedToken.IsUsed = true;
                storedToken.IsRevoked = true;
                _context.RefreshTokens.Update(storedToken);
                await _context.SaveChangesAsync();
                // create new token
                //var userId = tokenInverification.Claims.FirstOrDefault(c => c.Type == "Id").Value;
                var user = _context.NguoiDungs
                    .FirstOrDefault(user => user.Id == storedToken.UserId);
                var token = await GenerateToken(user);
                return Ok(new ApiResponse
                {
                    Success = true,
                    Message = "RenewToken is Success",
                    Data = token
                });
            }
            catch (Exception ex)
            {
                return BadRequest(new ApiResponse
                {
                    Success = false,
                    Message = ex.Message,
                });
            }
        }
        private DateTime CovertToDateTime(long utcExpireDate)
        {
            var dateTimeInterval = new DateTime(1970, 1, 1, 0, 0, 0, 0, DateTimeKind.Utc);
            dateTimeInterval.AddSeconds(utcExpireDate).ToUniversalTime();
            return dateTimeInterval;
        }
    }
}
