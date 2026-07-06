package dao.impl;

import domain.Admin;
import dao.AdminDao;
import util.DebugUtil;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import util.JDBCUtils;

import java.util.List;

public class AdminDaoImpl implements AdminDao {
    private JdbcTemplate template= new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public Admin findAdminByNameAndPwd(String adminName, String adminPwd) {

        /*
        // Debug
        DebugUtil.printAdminParams(adminName, adminPwd);
        */
       
        try {
            String sql = "select * from exp4_admin where adminName = ? and adminPwd = ?";
            Admin admin = template.queryForObject(sql, new BeanPropertyRowMapper<Admin>(Admin.class), adminName, adminPwd);
            return admin;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}
