using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using ManagerTaskSeven.BLL;
using ManagerTaskSeven.Entities;

namespace ManagerTaskSeven.Web
{
    public partial class Task : System.Web.UI.Page
    {
        [WebMethod]
        public static List<Entities.Task> GetTasks()
        {
            TaskServices service = new TaskServices();
            return service.GetTasks();
        }

        [WebMethod]
        public static void DeleteTask(int id)
        {
            TaskServices service = new TaskServices();
            service.DeleteTask(id);
        }

        [WebMethod]
        public static Entities.Task GetTaskById(int id)
        {
            TaskServices service = new TaskServices();
            return service.GetTaskById(id);
        }

        [WebMethod]
        public static void SaveTask(Entities.Task task)
        {
            TaskServices service = new TaskServices();
            service.SaveTask(task);
        }

        [WebMethod]
        public static object GetLookups()
        {
            UserServices usersService = new UserServices();
            ProjectsServices projectsService = new ProjectsServices();
            return new
            {
                Users = usersService.GetUsersTask(),
                projects = projectsService.GetProjectsTask()
            };
        }

        [WebMethod]
        public static List<Comment> GetCommentsByTask(int taskId)
        {
            CommentServices service = new CommentServices();
            return service.GetByTask(taskId);
        }

        [WebMethod]
        public static void AddComment(Comment comment)
        {
            var userId = HttpContext.Current.Session["UserId"];

            comment.UsuarioId = Convert.ToInt32(HttpContext.Current.Session["UserId"]);
            comment.Fecha = DateTime.Now;

            CommentServices service = new CommentServices();
            service.AddComment(comment);
        }
    }
}