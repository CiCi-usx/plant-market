package web.servlet;

import domain.User;
import org.apache.commons.beanutils.BeanUtils;
import service.UserService;
import service.impl.UserServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;  // 添加这个导入

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. 设置编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");
        
        // 2. 获取参数并封装对象
        Map<String, String[]> map = request.getParameterMap();
        User user = new User();
        
        try {
            BeanUtils.populate(user, map);
        } catch (IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
            request.setAttribute("error_msg", "数据封装失败：" + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;  // ← 别忘了 return
        }
        
        // 3. 判断两次输入密码是否相同
        String upwd = request.getParameter("upwd");
        String confirmPwd = request.getParameter("confirmPwd");
        
        if (upwd == null || upwd.trim().isEmpty() || !upwd.equals(confirmPwd)) {
            request.setAttribute("error_msg", "两次密码不相同或密码不能为空");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;  // ← 别忘了 return
        }
        
        // 4. 调用 Service 添加用户
        UserService service = new UserServiceImpl();
        
        try {
            service.addUser(user);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error_msg", "注册失败：" + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;  // ← 别忘了 return
        }
        System.out.println("AddUserServlet 注册成功，准备重定向");

        // 5. 注册成功，重定向到登录页
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        System.out.println("AddUserServlet 重定向已执行");

    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        this.doPost(request, response);
    }
}