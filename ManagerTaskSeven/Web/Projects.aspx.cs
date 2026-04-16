using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using ManagerTaskSeven.BLL;
using ManagerTaskSeven.Entities;

namespace ManagerTaskSeven.Web
{
    public partial class Projects : System.Web.UI.Page
    {
        [WebMethod]
        public static List<Project> GetProjects()
        {
            ProjectsServices service = new ProjectsServices();
            return service.GetProjects();
        }

        [WebMethod]
        public static void DeleteProjects(int id)
        {
            ProjectsServices service = new ProjectsServices();
            service.DeleteProjects(id);
        }

        [WebMethod]
        public static Project GetProjectById(int id)
        {
            ProjectsServices service = new ProjectsServices();
            return service.GetProjectById(id);
        }

        [WebMethod]
        public static void SaveProject(Project project)
        {
            ProjectsServices service = new ProjectsServices();
            service.SaveProject(project);
        }
    }
}