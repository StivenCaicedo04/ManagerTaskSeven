using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.Entities
{
    public class User
    {
        // 🔑 Clave primaria
        public int Id { get; set; }

        // 🧍 Datos personales
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string Cedula { get; set; }

        // 🎂 Fecha
        public DateTime FechaNacimiento { get; set; }

        // 🔗 Relaciones (IDs)
        public int GeneroId { get; set; }
        public int EstadoCivilId { get; set; }
        public int RolId { get; set; }

        // 🖥️ Propiedades para mostrar (JOIN)
        public string GeneroNombre { get; set; }
        public string EstadoCivilNombre { get; set; }
        public string RolNombre { get; set; }

        // 🔐 Autenticación
        public string Username { get; set; }
        public string Password { get; set; }

        // 🎯 Propiedad calculada (no viene de DB)
        public string NombreCompleto => $"{Nombre} {Apellido}";
    }
}