package servlet.admin;

import domain.User;
import service.UserService;
import service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserAddServlet")
public class UserAddServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置编码，防止中文乱码
        request.setCharacterEncoding("UTF-8");
        
        // 2. 获取表单参数
        String uname = request.getParameter("uname");
        String upwd = request.getParameter("upwd");
        String usex = request.getParameter("usex");
        String uemail = request.getParameter("uemail");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // 3. 封装成User对象
        User user = new User();
        user.setUname(uname);
        user.setUpwd(upwd);
        user.setUsex(usex);
        user.setUemail(uemail);
        user.setPhone(phone);
        user.setAddress(address);

        // 4. 调用service添加
        userService.addUser(user);

        // 5. 重定向到列表servlet
        response.sendRedirect(request.getContextPath() + "/UserListServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}


