using RmPro.ViewModels.Auth;

namespace RmPro.API.Services
{
    public interface IJwtManager
    {
        string GenerateJwtToken(UserSession user);
        int? ValidateJwtToken(string? token);
    }
}
