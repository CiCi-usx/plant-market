package service.impl;

import domain.Admin;
import service.AdminService;
import dao.AdminDao;
import dao.impl.AdminDaoImpl;

public class AdminServiceImpl implements AdminService {
    private AdminDao dao=new AdminDaoImpl();
   
    @Override
    public Admin login(Admin admin) {        
        return dao.findAdminByNameAndPwd(admin.getAdminName(),admin.getAdminPwd());
    }
}
