using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class ProjectsServices
    {
        public List<Project> GetProjects()
        {
            ProjectsRepository repo = new ProjectsRepository();
            return repo.GetAll();
        }

        public void DeleteProjects(int id)
        {
            ProjectsRepository repo = new ProjectsRepository();
            repo.Delete(id);
        }

        public Project GetProjectById(int id)
        {
            ProjectsRepository repo = new ProjectsRepository();
            return repo.GetById(id);
        }

        public void SaveProject(Project p)
        {
            ProjectsRepository repo = new ProjectsRepository();

            if (p.Id == 0)
            {
                repo.Insert(p);
            }
            else
            {
                repo.Update(p);
            }
        }

        public List<LookupItem> GetProjectsTask()
        {
            ProjectsRepository repo = new ProjectsRepository();
            return repo.GetProjectsTask();
        }
    }
}