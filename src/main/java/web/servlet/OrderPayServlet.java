package web.servlet;

import service.OrderService;
import service.impl.OrderServiceImpl;
import domain.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OrderPayServlet")
public class OrderPayServlet extends HttpServlet {
    
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 获取参数
        String oidStr = request.getParameter("oid");
        User loginUser = (User) request.getSession().getAttribute("user");
        
        // 2. 基础校验
        if (oidStr == null || oidStr.isEmpty()) {
            request.getSession().setAttribute("msg", "订单ID不能为空！");
            response.sendRedirect(request.getContextPath() + "/userCenter.jsp");
            return;
        }
        
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            String oid = request.getParameter("oid");
            
            // 3. 改用通用的 updateOrderStatus 方法，传入状态 1 (已支付/待发货)
            boolean isSuccess = orderService.updateOrderStatus(oid, 1);
            
            // 4. 使用session存储消息（因为重定向后request会丢失）
            if (isSuccess) {
                request.getSession().setAttribute("msg", "支付成功！订单已提交");
            } else {
                request.getSession().setAttribute("msg", "支付失败！订单状态异常");
            }
            
        } catch (NumberFormatException e) {
            request.getSession().setAttribute("msg", "订单ID格式错误！");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("msg", "系统错误，支付失败！");
        }
        
        // 5. 重定向回用户中心页面
        response.sendRedirect(request.getContextPath() + "/MyOrdersServlet");
    }
}
