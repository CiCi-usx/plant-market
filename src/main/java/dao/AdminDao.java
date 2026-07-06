package dao;

import domain.Admin;

public interface AdminDao {
    Admin findAdminByNameAndPwd(String adminName, String adminPwd);
}
