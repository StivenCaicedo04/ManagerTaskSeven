using DAL;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using Task = ManagerTaskSeven.Entities.Task;

namespace ManagerTaskSeven.DAL
{
    public class TaskRepository
    {
        private readonly DbConnection _db = new DbConnection();

        public List<Task> GetAll()
        {
            var list = new List<Task>();

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"SELECT 
                                    t.Id,
                                    t.Title,
                                    t.Description,
                                    t.Status,
                                    t.CreatedAt,
                                    p.Nombre AS ProyectoNombre,
                                    u.Nombre AS UsuarioNombre,
						            u.Apellido AS UsuarioApellido,
						            t.ProjectId,
						            t.AssignedUserId
                                FROM Tasks t
                                INNER JOIN Projects p ON t.ProjectId = p.Id
                                INNER JOIN Users u ON t.AssignedUserId = u.Id";

                var cmd = new SqlCommand(query, conn);
                conn.Open();

                var dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    list.Add(new Task
                    {
                        Id = (int)dr["Id"],
                        ProyectoId = (int)dr["ProjectId"],
                        UsuarioId = (int)dr["AssignedUserId"],
                        Titulo = dr["Title"].ToString(),
                        Descripcion = dr["Description"].ToString(),
                        Estado = dr["Status"].ToString(),
                        FechaCreacion = Convert.ToDateTime(dr["CreatedAt"]),
                        TituloProyecto = dr["ProyectoNombre"].ToString(),
                        Nombre = dr["UsuarioNombre"].ToString(),
                        Apellido = dr["UsuarioApellido"].ToString()
                    });
                }
            }

            return list;
        }

        public void Insert(Task task)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"INSERT INTO Tasks 
                    (ProjectId, AssignedUserId, Title, Description, Status, CreatedAt)
                    VALUES (@ProjectId, @AssignedUserId, @Title, @Description, @Status, @CreatedAt)";

                var cmd = new SqlCommand(query, conn);

                cmd.Parameters.AddWithValue("@ProjectId", task.ProyectoId);
                cmd.Parameters.AddWithValue("@AssignedUserId", task.UsuarioId);
                cmd.Parameters.AddWithValue("@Title", task.Titulo);
                cmd.Parameters.AddWithValue("@Description", task.Descripcion);
                cmd.Parameters.AddWithValue("@Status", task.Estado);
                cmd.Parameters.AddWithValue("@CreatedAt", task.FechaCreacion);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public void Delete(int id)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = "DELETE FROM Tasks WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Update(Task task)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    UPDATE Tasks SET
                    ProjectId=@ProjectId,
                    AssignedUserId=@AssignedUserId,
                    Title=@Title,
                    Description=@Description,
                    Status=@Status,
                    CreatedAt=@CreatedAt
                    WHERE Id=@Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", task.Id);
                    cmd.Parameters.AddWithValue("@ProjectId", task.ProyectoId);
                    cmd.Parameters.AddWithValue("@AssignedUserId", task.UsuarioId);
                    cmd.Parameters.AddWithValue("@Title", task.Titulo);
                    cmd.Parameters.AddWithValue("@Description", task.Descripcion);
                    cmd.Parameters.AddWithValue("@Status", task.Estado);
                    cmd.Parameters.AddWithValue("@CreatedAt", task.FechaCreacion);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public Task GetById(int id)
        {
            Task project = null;

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                                SELECT 
                                    t.Id,
                                    t.Title,
                                    t.Description,
                                    t.Status,
                                    t.CreatedAt,
                                    p.Nombre AS ProyectoNombre,
                                    u.Nombre AS UsuarioNombre,
						            u.Apellido AS UsuarioApellido,
						            t.ProjectId,
						            t.AssignedUserId
                                FROM Tasks t
                                INNER JOIN Projects p ON t.ProjectId = p.Id
                                INNER JOIN Users u ON t.AssignedUserId = u.Id
                                WHERE t.Id = @Id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    project = new Task
                    {
                        Id = (int)dr["Id"],
                        ProyectoId = (int)dr["ProjectId"],
                        UsuarioId = (int)dr["AssignedUserId"],
                        Titulo = dr["Title"].ToString(),
                        Descripcion = dr["Description"].ToString(),
                        Estado = dr["Status"].ToString(),
                        FechaCreacion = Convert.ToDateTime(dr["CreatedAt"]),
                        TituloProyecto = dr["ProyectoNombre"].ToString(),
                        Nombre = dr["UsuarioNombre"].ToString(),
                        Apellido = dr["UsuarioApellido"].ToString()
                    };
                }
            }

            return project;
        }
    }
}