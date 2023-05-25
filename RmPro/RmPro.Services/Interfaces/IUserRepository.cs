using RmPro.Entities;
using RmPro.ViewModels.User;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RmPro.Services.Interfaces
{
    public interface IUserRepository
    {
        Task<List<UserResponse>> GetAllAsync();
        Task<UserResponse> GetUserByUsernamePassword(string username, string password);
    }
}
