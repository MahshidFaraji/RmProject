using Microsoft.Extensions.Options;
using RmPro.API.Services;
using System.Net;

namespace RmPro.API.CustomMiddleWares
{
    public class JwtMiddleware
    {
        private readonly RequestDelegate _next;

        public JwtMiddleware(RequestDelegate next)
        {
            _next = next;
        }

        public async Task Invoke(HttpContext context, IJwtManager jwtManager)
        {
            var token = context.Request.Headers["Authorization"].FirstOrDefault()?.Split(" ").Last();

            string? path = context.Request.Path.Value;
            if (path.ToLower().Contains("/auth/login"))
            {
                await _next(context);
                return;
            }

            if (token == null)
            {
                context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                await context.Response.WriteAsync("UnAuthorize: Token Not Found");
                return;
            }

            var accountId = jwtManager.ValidateJwtToken(token);
            if (accountId == null)
            {
                context.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                await context.Response.WriteAsync("UnAuthorize: Token Not Found");
            }
            
            await _next(context);
        }
    }
}
