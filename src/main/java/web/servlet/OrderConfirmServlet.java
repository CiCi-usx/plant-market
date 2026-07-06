package web.servlet;

import service.OrderService;
import service.impl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OrderConfirmServlet")
public class OrderConfirmServlet extends HttpServlet {
    
    // 1. 必须创建 Service 的实例对象
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 2. 从请求中获取 oid 参数，补上这一行！
        String oid = request.getParameter("oid");
        
        // 可以加个简单的非空判断，防止报错
        if (oid == null || oid.trim().isEmpty()) {
            request.getSession().setAttribute("msg", "订单ID不能为空！");
            response.sendRedirect(request.getContextPath() + "/userCenter.jsp");
            return;
        }

        // 3. 确认收货，状态 2 -> 4 (已完成)，通过对象调用方法
        boolean isSuccess = orderService.updateOrderStatus(oid, 4);
        
        if (isSuccess) {
            request.getSession().setAttribute("msg", "确认收货成功，订单已完成！");
        } else {
            request.getSession().setAttribute("msg", "操作失败！");
        }
        
        // 建议也改回走 Servlet，这样订单状态刷新会及时一点
        response.sendRedirect(request.getContextPath() + "/MyOrdersServlet");
    }
}
