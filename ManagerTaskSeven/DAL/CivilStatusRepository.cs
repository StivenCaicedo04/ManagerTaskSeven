using DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.DAL
{
    public class CivilStatusRepository
    {
        private readonly DbConnection _db = new DbConnection();
        public List<LookupItem> GetCivilStatus()
        {
            var civilStatus = new List<LookupItem>();
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Nombre FROM EstadoCivil", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        civilStatus.Add(new LookupItem
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Nombre"].ToString()
                        });
                    }
                }
            }
            return civilStatus;
        }
    }
}