package servlet.admin;

import service.UserService;
import service.impl.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/UserDeleteServlet")
public class UserDeleteServlet extends HttpServlet {
    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 获取要删除的用户uid
        String uidStr = request.getParameter("uid");
        if (uidStr != null && !uidStr.isEmpty()) {
            int uid = Integer.parseInt(uidStr);
            // 2. 调用service删除
            userService.deleteUserByUid(uid);
        }
        // 3. 重定向到列表servlet，刷新数据
        response.sendRedirect(request.getContextPath() + "/UserListServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}


