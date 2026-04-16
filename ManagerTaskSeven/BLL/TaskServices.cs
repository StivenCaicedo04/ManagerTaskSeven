using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class TaskServices
    {
        public List<Task> GetTasks()
        {
            TaskRepository repo = new TaskRepository();
            return repo.GetAll();
        }

        public void DeleteTask(int id)
        {
            TaskRepository repo = new TaskRepository();
            repo.Delete(id);
        }

        public Task GetTaskById(int id)
        {
            TaskRepository repo = new TaskRepository();
            return repo.GetById(id);
        }

        public void SaveTask(Task task)
        {
            TaskRepository repo = new TaskRepository();

            if (task.Id == 0)
            {
                repo.Insert(task);
            }
            else
            {
                repo.Update(task);
            }
        }        
    }
}