package service.impl;

import dao.UserDao;
import dao.impl.UserDaoImpl;
import domain.User;
import service.UserService;
import java.util.List;

public class UserServiceImpl implements UserService {
    private UserDao dao = new UserDaoImpl();

    @Override
    public void addUser (User user) {
        dao.addUser(user);
    }

    @Override
    public User login(User user) {
        return dao.findUserByUnameAndUpwd(user.getUname(),user.getUpwd());
    }

        @Override
    public List<User> findAllUsers() {
        return dao.findAllUsers();
    }

    @Override
    public User findUserByUid(Integer uid) {
        return dao.findUserByUid(uid);
    }

    @Override
    public void updateUser(User user) {
        dao.updateUser(user);
    }

    @Override
    public void deleteUserByUid(Integer uid) {
        dao.deleteUserByUid(uid);
    }

}
