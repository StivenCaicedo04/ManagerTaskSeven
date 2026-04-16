using BLL;
using DAL;
using ManagerTaskSeven.BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerTaskSeven.Web
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserId"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        [WebMethod]
        public static object GetDashboardData()
        {
            var userServices = new UserServices();
            var taskServices = new TaskServices();
            var projectServices = new ProjectsServices();

            var taskPending = taskServices.GetTasks();
            return new
            {
                TotalUsers = userServices.GetUsers("").Count(),
                TotalProjects = projectServices.GetProjects().Count(),
                PendingTasks = taskPending.Count(u => u.Estado == "Pendiente"),
                InProgressTasks = taskPending.Count(u => u.Estado == "En Progreso"),
                FinishTasks = taskPending.Count(u => u.Estado == "Finalizada")
            };
        }

        [WebMethod]
        public static void Logout()
        {
            HttpContext.Current.Response.Cookies["UserSession"].Expires = DateTime.Now.AddDays(-1);
        }
    }
}