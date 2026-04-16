using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace DAL
{
    public class UserRepository
    {
        private readonly DbConnection _db = new DbConnection();

        public UserLoginResult ValidateUser(string username, string password)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();

                var query = @"SELECT Id, Nombre + ' ' + Apellido AS NombreCompleto
                      FROM Users 
                      WHERE Username = @Username AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return new UserLoginResult
                            {
                                Id = Convert.ToInt32(reader["Id"]),
                                NombreCompleto = reader["NombreCompleto"].ToString()
                            };
                        }
                    }
                }
            }

            return null;
        }

        public List<User> GetFiltered(string filter)
        {
            List<User> list = new List<User>();

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    SELECT u.Id, u.Nombre, u.Apellido, u.Cedula, r.Nombre AS RolNombre
                    FROM Users u
                    INNER JOIN Roles r ON u.RolId = r.Id
                    WHERE (@filter = '' OR u.Nombre LIKE '%' + @filter + '%' OR u.Cedula LIKE '%' + @filter + '%')";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@filter", filter ?? "");

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    list.Add(new User
                    {
                        Id = (int)dr["Id"],
                        Nombre = dr["Nombre"].ToString(),
                        Apellido = dr["Apellido"].ToString(),
                        Cedula = dr["Cedula"].ToString(),
                        RolNombre = dr["RolNombre"].ToString()
                    });
                }
            }

            return list;
        }

        public void Insert(User user)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    INSERT INTO Users
                    (Nombre, Apellido, Cedula, GeneroId, EstadoCivilId, RolId, FechaNacimiento, Username, Password)
                    VALUES
                    (@Nombre, @Apellido, @Cedula, @GeneroId, @EstadoCivilId, @RolId, @FechaNacimiento, @Username, @Password)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", user.Nombre);
                    cmd.Parameters.AddWithValue("@Apellido", user.Apellido);
                    cmd.Parameters.AddWithValue("@Cedula", user.Cedula);
                    cmd.Parameters.AddWithValue("@GeneroId", user.GeneroId);
                    cmd.Parameters.AddWithValue("@EstadoCivilId", user.EstadoCivilId);
                    cmd.Parameters.AddWithValue("@RolId", user.RolId);
                    cmd.Parameters.AddWithValue("@FechaNacimiento", user.FechaNacimiento);
                    cmd.Parameters.AddWithValue("@Username", user.Username);
                    cmd.Parameters.AddWithValue("@Password", user.Password);


                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Delete(int id)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = "DELETE FROM Users WHERE Id = @Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Update(User user)
        {
            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    UPDATE Users SET
                    Nombre=@Nombre,
                    Apellido=@Apellido,
                    Cedula=@Cedula,
                    GeneroId=@GeneroId,
                    EstadoCivilId=@EstadoCivilId,
                    RolId=@RolId,
                    FechaNacimiento=@FechaNacimiento
                    WHERE Id=@Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {

                    cmd.Parameters.AddWithValue("@Id", user.Id);
                    cmd.Parameters.AddWithValue("@Nombre", user.Nombre);
                    cmd.Parameters.AddWithValue("@Apellido", user.Apellido);
                    cmd.Parameters.AddWithValue("@Cedula", user.Cedula);
                    cmd.Parameters.AddWithValue("@GeneroId", user.GeneroId);
                    cmd.Parameters.AddWithValue("@EstadoCivilId", user.EstadoCivilId);
                    cmd.Parameters.AddWithValue("@RolId", user.RolId);
                    cmd.Parameters.AddWithValue("@FechaNacimiento", user.FechaNacimiento);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public User GetById(int id)
        {
            User user = null;

            using (SqlConnection conn = _db.GetConnection())
            {
                string query = @"
                    SELECT 
                        Id,
                        Nombre,
                        Apellido,
                        Cedula,
                        GeneroId,
                        EstadoCivilId,
                        RolId,
                        FechaNacimiento
                    FROM Users
                    WHERE Id = @Id";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);

                conn.Open();

                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    user = new User
                    {
                        Id = (int)dr["Id"],
                        Nombre = dr["Nombre"].ToString(),
                        Apellido = dr["Apellido"].ToString(),
                        Cedula = dr["Cedula"].ToString(),
                        GeneroId = (int)dr["GeneroId"],
                        EstadoCivilId = (int)dr["EstadoCivilId"],
                        RolId = (int)dr["RolId"],
                        FechaNacimiento = Convert.ToDateTime(dr["FechaNacimiento"])
                    };
                }
            }

            return user;
        }

        public List<LookupItem> GetUsersTask() 
        {
            var users = new List<LookupItem>();
            using (SqlConnection conn = _db.GetConnection())
            {
                conn.Open();
                var cmd = new SqlCommand("SELECT Id, Nombre, Apellido FROM Users", conn);
                using (var reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        users.Add(new LookupItem
                        {
                            Id = Convert.ToInt32(reader["Id"]),
                            Name = reader["Nombre"].ToString() + " " + reader["Apellido"].ToString()
                        });
                    }
                }
            }
            return users;
        }
    }
}
