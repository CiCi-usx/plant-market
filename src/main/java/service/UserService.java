package service;

import domain.User;
import java.util.List;

public interface UserService {
    public void addUser(User user);
    User login(User user);
    List<User> findAllUsers();
    User findUserByUid(Integer uid);
    void updateUser(User user);
    void deleteUserByUid(Integer uid);

}
