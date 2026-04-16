using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ManagerTaskSeven.Web
{
    public partial class Login : System.Web.UI.Page
    {
        [WebMethod(EnableSession = true)]
        public static object LoginUser(string username, string password)
        {
            try
            {
                var service = new UserServices();
                var result = service.Login(username, password);

                if (result.Id > 0)
                {
                    HttpContext.Current.Session["UserId"] = result.Id;
                    HttpContext.Current.Session["UserName"] = result.NombreCompleto;

                    return new
                    {
                        success = true,
                        userId = result.Id
                    };
                }

                return new
                {
                    success = false,
                    message = "Credenciales inválidas"
                };
            }
            catch (Exception ex)
            {
                return new
                {
                    success = false,
                    message = ex.Message
                };
            }
        }
    }
}