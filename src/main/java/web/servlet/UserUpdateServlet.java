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

@WebServlet("/UserUpdateServlet")
public class UserUpdateServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置编码
        request.setCharacterEncoding("UTF-8");

        // 2. 获取表单参数（包含隐藏域传来的uid）
        String uidStr = request.getParameter("uid");
        String uname = request.getParameter("uname");
        String upwd = request.getParameter("upwd");
        String usex = request.getParameter("usex");
        String uemail = request.getParameter("uemail");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // 3. 封装对象
        User user = new User();
        user.setUid(Integer.parseInt(uidStr));
        user.setUname(uname);
        user.setUpwd(upwd);
        user.setUsex(usex);
        user.setUemail(uemail);
        user.setPhone(phone);
        user.setAddress(address);

        // 4. 调用service更新
        userService.updateUser(user);

        // 5. 重定向到列表servlet
        response.sendRedirect(request.getContextPath() + "/UserListServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}


