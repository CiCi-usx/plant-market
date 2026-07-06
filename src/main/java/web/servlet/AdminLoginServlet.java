package web.servlet;

import domain.Admin;
import org.apache.commons.beanutils.BeanUtils;
import service.AdminService;
import service.impl.AdminServiceImpl;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Cookie;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

@WebServlet("/admin/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //1.设置编码
        request.setCharacterEncoding("utf-8");
        //2.获取数据
        //2.1获取用户填写验证码
        String verifycode = request.getParameter("verifycode");
        //3.验证码校验
        HttpSession session = request.getSession();
        String checkcode_server = (String) session.getAttribute("CHECKCODE_SERVER");
        session.removeAttribute("CHECKCODE_SERVER");//确保验证码一次性
        
        if(checkcode_server == null || !checkcode_server.equalsIgnoreCase(verifycode)){
            //验证码不正确 ,提示信息
            request.setAttribute("login_msg","验证码错误！");
            //跳转登录页面
            request.getRequestDispatcher("/admin/login.jsp").forward(request,response);
            return;
        }
        Map<String, String[]> map = request.getParameterMap();
        //4.封装 Admin 对象
        Admin admin = new Admin();
        try {
            BeanUtils.populate(admin, map);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        //5.调用Service查询
        AdminService service = new AdminServiceImpl();
        Admin loginAdmin = service.login(admin);
        //6.判断是否登录成功
        if(loginAdmin != null){
            //================== 【新增/修改：写入独占的 Admin Cookie】 ==================
            // 使用隔离的键名：adminUname 和 adminUpwd
            Cookie nameCookie = new Cookie("adminUname", loginAdmin.getAdminName());
            Cookie pwdCookie = new Cookie("adminUpwd", loginAdmin.getAdminPwd());
            
            // 设置有效路径为当前项目下的 /admin 目录，进一步防止普通用户页面读取到
            nameCookie.setPath(request.getContextPath() + "/admin");
            pwdCookie.setPath(request.getContextPath() + "/admin");
            
            // 设置生存周期为 7 天（可根据需要修改，单位：秒）
            nameCookie.setMaxAge(60 * 60 * 24 * 7);
            pwdCookie.setMaxAge(60 * 60 * 24 * 7);
            
            // 发送给浏览器保存
            response.addCookie(nameCookie);
            response.addCookie(pwdCookie);
            //======================================================================

            //登录成功  将用户存入session
            session.setAttribute("admin",loginAdmin);
            //跳转页面
            response.sendRedirect(request.getContextPath()+"/admin/index.jsp");
        } else {
            //登录失败 提示信息
            request.setAttribute("login_msg","管理员账号或密码错误！");
            //跳转登录页面
            request.getRequestDispatcher("/admin/login.jsp").forward(request,response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}