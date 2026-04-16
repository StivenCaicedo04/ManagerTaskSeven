using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.Entities
{
    public class Comment
    {
        public int Id { get; set; }
        public int TaskId { get; set; }
        public int UsuarioId { get; set; }
        public string Comentario { get; set; }
        public string UsuarioNombre { get; set; }
        public DateTime Fecha { get; set; }
    }
}