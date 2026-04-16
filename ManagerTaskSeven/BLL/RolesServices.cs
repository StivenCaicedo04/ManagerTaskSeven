using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class RolesServices
    {
        public List<LookupItem> GetRoles()
        {
            RolesRepository repo = new RolesRepository();
            return repo.GetRoles();
        }
    }
}