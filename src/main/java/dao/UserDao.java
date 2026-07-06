package dao;

import domain.User;
import java.util.List;


public interface UserDao {
    public void addUser(User user);
    User findUserByUnameAndUpwd(String uname, String upwd);
    List<User> findAllUsers();          // 查询所有用户
    User findUserByUid(Integer uid);    // 根据UID查询用户（修改时回显用）
    void updateUser(User user);         // 修改用户
    void deleteUserByUid(Integer uid);  // 删除用户
}