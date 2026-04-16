using DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.DAL
{
    public class ProjectsRepository
    {
        private readonly DbConnection _db = new DbConnection();

        public List<Project> GetAll()
        {
            var list = new List<Project>();

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = "SELECT * FROM Projects";

                var cmd = new SqlCommand(query, conn);
                conn.Open();

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    list.Add(new Project
                    {
                        Id = (int)dr["Id"],
                        Nombre = dr["Nombre"].ToString(),
                        Descripcion = dr["Descripcion"].ToString(),
                        FechaInicio = Convert.ToDateTime(dr["FechaInicio"]),
                        FechaFin = Convert.ToDateTime(dr["FechaFin"])
                    });
                }
            }

            return list;
        }

        public void Insert(Project p)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"INSERT INTO Projects 
                    (Nombre, Descripcion, FechaInicio, FechaFin)
                    VALUES (@Nombre, @Descripcion, @FechaInicio, @FechaFin)";

                var cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@Nombre", p.Nombre);
                cmd.Parameters.AddWithValue("@Descripcion", p.Descripcion);
                cmd.Parameters.AddWithValue("@FechaInicio", p.FechaInicio);
                cmd.Parameters.AddWithValue("@FechaFin", p.FechaFin);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = "DELETE FROM Projects WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Update(Project p)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    UPDATE Projects SET
                    Nombre=@Nombre,
                    Descripcion=@Descripcion,
                    FechaInicio=@FechaInicio,
                    FechaFin=@FechaFin
                    WHERE Id=@Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {

                    cmd.Parameters.AddWithValue("@Id", p.Id);
                    cmd.Parameters.AddWithValue("@Nombre", p.Nombre);
                    cmd.Parameters.AddWithValue("@Descripcion", p.Descripcion);
                    cmd.Parameters.AddWithValue("@FechaInicio", p.FechaInicio);
                    cmd.Parameters.AddWithValue("@FechaFin", p.FechaFin);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public Project GetById(int id)
        {
            Project project = null;

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    SELECT 
                        Id,
                        Nombre,
                        Descripcion,
                        FechaInicio,
                        FechaFin
                    FROM Projects
                    WHERE Id = @Id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    project = new Project
                    {
                        Id = (int)dr["Id"],
                        Nombre = dr["Nombre"].ToString(),
                        Descripcion = dr["Descripcion"].ToString(),
                        FechaInicio = Convert.ToDateTime(dr["FechaInicio"]),
                        FechaFin = Convert.ToDateTime(dr["FechaFin"])
                    };
                }
            }

            return project;
        }

        public List<LookupItem> GetProjectsTask()
        {
            var projects = new List<LookupItem>();
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Nombre FROM Projects", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        projects.Add(new LookupItem
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Nombre"].ToString()
                        });
                    }
                }
            }
            return projects;
        }
    }
}