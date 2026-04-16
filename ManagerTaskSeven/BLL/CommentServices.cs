using ManagerTaskSeven.DAL;
using ManagerTaskSeven.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ManagerTaskSeven.BLL
{
    public class CommentServices
    {
        public List<Comment> GetByTask(int idTask)
        {
            CommentRepository repo = new CommentRepository();
            return repo.GetByTask(idTask);
        }

        public void AddComment(Comment comment)
        {
            CommentRepository repo = new CommentRepository();
            repo.Insert(comment);
        }
    }
}