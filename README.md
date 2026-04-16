# ManagerTaskSeven

_ManagerTaskSeven es una aplicación web desarrollada en ASP.NET Web Forms + SQL Server para la gestión de proyectos, tareas y seguimiento de actividades mediante comentarios.Permite administrar usuarios, asignar tareas por proyecto y realizar control del estado del trabajo en tiempo real._

## Tecnologías utilizadas ⚙️

* ASP.NET Web Forms (C#)
* SQL Server
* ADO.NET
* JavaScript / jQuery
* HTML / CSS
* Bootstrap (si aplica en tu UI)

### Base de datos 🔧

_El sistema utiliza una base de datos llamada: ManagerTaskSeven_

Tablas principales:
* Users
* Projects
* Tasks
* TaskComments
* Generos
* EstadoCivil
* Roles

### Instalación y ejecución 🚀
1. Clonar o descargar el proyecto
```
git clone <url-del-repositorio>
```
2. Restaurar base de datos
* Ejecutar el script SQL incluido en el proyecto
* Verificar que la base de datos se llame ManagerTaskSeven
3. Configurar conexión
* En el archivo Web.config:
```
<connectionStrings>
  <add name="DefaultConnection"
       connectionString="Server=TU_SERVIDOR;Database=ManagerTaskSeven;Trusted_Connection=True;"
       providerName="System.Data.SqlClient"/>
</connectionStrings>
```

4. Ejecutar el proyecto
* Abrir en Visual Studio
* Ejecutar con IIS Express
* Acceder desde el navegador

### Credenciales de prueba (si aplican) 🔐
* Usuario: admin
* Password: 123456

### Autor 👨‍💻

* Stiven Caicedo
* Proyecto tecnico – ASP.NET Web Forms + SQL Server
