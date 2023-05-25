using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using RmPro.API.Services;
using RmPro.Services.Interfaces;
using RmPro.ViewModels.Auth;

namespace RmPro.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly IJwtManager _jwtManager;
        private readonly IUserRepository _userRepository;

        public AuthController(IJwtManager jwtManager, IUserRepository userRepository)
        {
            _jwtManager = jwtManager;
            _userRepository = userRepository;
        }

        [HttpPost]
        [Route("login")]
        public async Task<ActionResult<LoginResponse>> Authenticate([FromBody] LoginRequest request)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            var managedUser = await _userRepository.GetUserByUsernamePassword(request.UserName, request.Password);

            if (managedUser == null)
            {
                return BadRequest("user not found");
            }

            var accessToken = _jwtManager.GenerateJwtToken(new UserSession() { Email = managedUser.Email, UserName = managedUser.Username});

            return Ok(new LoginResponse
            {
                Username = managedUser.Username,
                Email = managedUser.Email,
                Token = accessToken,
            });
        }
    }
}
