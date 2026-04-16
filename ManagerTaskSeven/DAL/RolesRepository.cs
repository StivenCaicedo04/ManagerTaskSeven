using DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.DAL
{
    public class RolesRepository
    {
        private readonly DbConnection _db = new DbConnection();
        public List<LookupItem> GetRoles()
        {
            var roles = new List<LookupItem>();
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Nombre FROM Roles", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        roles.Add(new LookupItem
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Nombre"].ToString()
                        });
                    }
                }
            }
            return roles;
        }
    }
}