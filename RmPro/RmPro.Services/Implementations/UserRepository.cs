using Dapper;
using RmPro.Data;
using RmPro.Entities;
using RmPro.Services.Interfaces;
using RmPro.ViewModels.User;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RmPro.Services.Implementations
{
    public class UserRepository: IUserRepository
    {

        private readonly DapperContext _context;
        public UserRepository(DapperContext context)
        {
            _context = context;
        }

        /// <summary>
        /// This method returns all users in database in a list object
        /// </summary>
        public async Task<List<UserResponse>> GetAllAsync()
        {
            var procedureName = "GetAllUsers";
            using (var connection = _context.CreateConnection())
            {
                var user = await connection.QueryAsync<UserResponse>
                    (procedureName, commandType: CommandType.StoredProcedure);
                return user.ToList();
            }
        }

        public async Task<UserResponse> GetUserByUsernamePassword(string username, string password)
        {
            var procedureName = "GetUserByUsernamePassword";
            var parameters = new DynamicParameters();
            parameters.Add("username", username, DbType.String, ParameterDirection.Input);
            parameters.Add("password", password, DbType.String, ParameterDirection.Input);
            using (var connection = _context.CreateConnection())
            {
                var user = await connection.QueryFirstOrDefaultAsync<UserResponse>
                    (procedureName, parameters, commandType: CommandType.StoredProcedure);
                return user;
            }
        }
    }
}
