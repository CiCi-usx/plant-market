package web.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import java.io.IOException;

@WebFilter(filterName = "AdminLoginFilter",urlPatterns = "/admin/*")
public class AdminLoginFilter implements Filter {
    public void init(FilterConfig config) throws ServletException {
    }
    public void destroy() {
    }
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws ServletException, IOException {
        //0.强制转换
        HttpServletRequest req = (HttpServletRequest) request;
        // 1.获取资源请求路径
        String uri = req.getRequestURI();
        // 2.判断是否包含登录相关资源路径,要注意排除掉 css/js/图片/验证码等资源
        if(uri.contains("/admin/login.jsp") || uri.contains("/AdminLoginServlet") || uri.contains("/css/") || uri.contains("/js/") || uri.contains("/fonts/") || uri.contains("/CheckCodeServlet")  ){
        // 包含，用户就是想登录。放行
            chain.doFilter(req, response);
        }else{
            // 不包含，需要验证用户是否登录
            // 3.从获取session中获取user
            Object admin = req.getSession().getAttribute("admin");
            if(admin != null){
                // 登录了,放行
                chain.doFilter(req, response);
            }else{
                // 没有登录。跳转登录页面
                request.setAttribute("login_msg","您尚未登录，请登录");
                request.getRequestDispatcher("/admin/login.jsp").forward(request,response);
            }
        }
        //chain.doFilter(request, response);
    }
}
