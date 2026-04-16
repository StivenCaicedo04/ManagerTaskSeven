using DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.DAL
{
    public class GenderRepository
    {
        private readonly DbConnection _db = new DbConnection();
        public List<LookupItem> GetGenders()
        {
            var gender = new List<LookupItem>();
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Nombre FROM Generos", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        gender.Add(new LookupItem
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Nombre"].ToString()
                        });
                    }
                }
            }
            return gender;
        }
    }
}