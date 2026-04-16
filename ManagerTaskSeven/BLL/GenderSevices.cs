using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class GenderSevices
    {
        public List<LookupItem> GetGenders()
        {
            GenderRepository repo = new GenderRepository();
            return repo.GetGenders();
        }
    }
}