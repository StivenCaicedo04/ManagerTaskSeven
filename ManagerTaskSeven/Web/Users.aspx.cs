using BLL;
using DAL;
using ManagerTaskSeven.BLL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerTaskSeven.Web
{
    public partial class Users : System.Web.UI.Page
    {
        [WebMethod]
        public static List<User> GetUsers(string filter)
        {
            UserServices service = new UserServices();
            return service.GetUsers(filter);
        }

        [WebMethod]
        public static void DeleteUser(int id)
        {
            UserServices service = new UserServices();
            service.DeleteUser(id);
        }

        [WebMethod]
        public static User GetUserById(int id)
        {
            UserServices service = new UserServices();
            return service.GetUserById(id);
        }

        [WebMethod]
        public static object GetLookups()
        {
            RolesServices rolesService = new RolesServices();
            GenderSevices genderService = new GenderSevices();
            CivilStatusServices civilStatusService = new CivilStatusServices();
            return new
            {
                Roles = rolesService.GetRoles(),
                Genders = genderService.GetGenders(),
                CivilStatus = civilStatusService.GetCivilStatus()
            };
        }

        [WebMethod]
        public static void SaveUser(User user)
        {
            UserServices service = new UserServices();
            service.SaveUser(user);
        }
    }
}