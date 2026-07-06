package dao.impl;

import dao.UserDao;
import domain.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import util.JDBCUtils;

import java.util.List;

public class UserDaoImpl implements UserDao {
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public void addUser(User user) {
        // SQL 语句：插入所有字段（uid 自增，不需要手动插入）
        String sql = "INSERT INTO exp4_user(uname, upwd, usex, uemail, phone, address) VALUES(?,?,?,?,?,?)";
        
        // 执行更新操作
        template.update(sql, 
            user.getUname(),
            user.getUpwd(),
            user.getUsex(),
            user.getUemail(),
            user.getPhone(),
            user.getAddress()
        );
    }

    @Override
    public User findUserByUnameAndUpwd(String uname, String upwd) {
        try {
            String sql = "select * from exp4_user where uname = ? and upwd = ?";
            User user = template.queryForObject(sql, new BeanPropertyRowMapper<User>(User.class), uname, upwd);
            return user;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public List<User> findAllUsers() {
        String sql = "SELECT uid, uname, upwd, usex, uemail, phone, address FROM exp4_user";
        return template.query(sql, new BeanPropertyRowMapper<>(User.class));
    }

    @Override
    public User findUserByUid(Integer uid) {
        String sql = "SELECT uid, uname, upwd, usex, uemail, phone, address FROM exp4_user WHERE uid = ?";
        try {
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(User.class), uid);
        } catch (Exception e) {
            return null; // 找不到时返回null，避免抛出 EmptyResultDataAccessException
        }
    }

    @Override
    public void updateUser(User user) {
        String sql = "UPDATE exp4_user SET uname = ?, upwd = ?, usex = ?, uemail = ?, phone = ?, address = ? WHERE uid = ?";
        template.update(sql, user.getUname(), user.getUpwd(), user.getUsex(), 
                             user.getUemail(), user.getPhone(), user.getAddress(), user.getUid());
    }

    @Override
    public void deleteUserByUid(Integer uid) {
        String sql = "DELETE FROM exp4_user WHERE uid = ?";
        template.update(sql, uid);
    }

}