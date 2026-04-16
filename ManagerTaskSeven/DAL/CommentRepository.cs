using DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.DAL
{
    public class CommentRepository
    {
        private readonly DbConnection _db = new DbConnection();
        public List<Comment> GetByTask(int id)
        {
            List<Comment> comment = new List<Comment>();

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                        SELECT ts.Id, ts.TaskId, ts.UserId, ts.Comment, ts.CreatedAt, u.Nombre + ' ' + u.Apellido AS    NombreCompleto, t.Title
                        FROM TaskComments ts 
                        RIGHT JOIN Users u ON ts.UserId = u.Id	
                        INNER JOIN Tasks t ON ts.TaskId = t.Id
                        WHERE t.Id = @Id
                        ORDER BY ts.CreatedAt DESC";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    comment.Add(new Comment
                    {
                        Id = (int)dr["Id"],
                        TaskId = (int)dr["TaskId"],
                        UsuarioId = (int)dr["UserId"],
                        Comentario = dr["Comment"].ToString(),
                        UsuarioNombre = dr["NombreCompleto"].ToString(),
                        Fecha = Convert.ToDateTime(dr["CreatedAt"])
                    });
                }
            }

            return comment;
        }

        public void Insert(Comment comment)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    INSERT INTO TaskComments
                        (TaskId, UserId, Comment, CreatedAt)
                        VALUES
                        (@TaskId, @UsuarioId, @Comment, @CreatedAt)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TaskId", comment.TaskId);
                    cmd.Parameters.AddWithValue("@UsuarioId", comment.UsuarioId);
                    cmd.Parameters.AddWithValue("@Comment", comment.Comentario);
                    cmd.Parameters.AddWithValue("@CreatedAt", comment.Fecha);


                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}