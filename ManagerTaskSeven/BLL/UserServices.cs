using DAL;
using ManagerTaskSeven.Entities;
using System.Collections.Generic;

namespace BLL
{
    public class UserServices
    {
        private readonly UserRepository _repo = new UserRepository();

        public UserLoginResult Login(string username, string password)
        {
            return _repo.ValidateUser(username, password);
        }

        public List<User> GetUsers(string filter)
        {
            UserRepository repo = new UserRepository();
            return repo.GetFiltered(filter);
        }

        public void DeleteUser(int id)
        {
            UserRepository repo = new UserRepository();
            repo.Delete(id);
        }

        public User GetUserById(int id) 
        {
            UserRepository repo = new UserRepository();
            return repo.GetById(id);
        }

        public void SaveUser(User user)
        {
            UserRepository repo = new UserRepository();            

            if (user.Id == 0)
            {
                repo.Insert(user);
            }
            else
            {
                repo.Update(user);
            }
        }

        public List<LookupItem> GetUsersTask()
        {
            UserRepository repo = new UserRepository();
            return repo.GetUsersTask();
        }
    }
}
