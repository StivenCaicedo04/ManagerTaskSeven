using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class CivilStatusServices
    {
        public List<LookupItem> GetCivilStatus()
        {
            CivilStatusRepository repo = new CivilStatusRepository();
            return repo.GetCivilStatus();
        }
    }
}