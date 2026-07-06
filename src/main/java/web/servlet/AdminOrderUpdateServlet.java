package web.servlet;

import domain.Order;
import service.OrderService;
import service.impl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/AdminOrderUpdateServlet")
public class AdminOrderUpdateServlet extends HttpServlet {

    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 2. 获取前端参数：订单ID 和 触发的动作(如发货)
        String oId = request.getParameter("oId");
        String action = request.getParameter("action"); // 前端传 action=ship 表示发货

        // 3. 健壮性校验
        if (oId != null && !oId.trim().isEmpty()) {
            
            if ("ship".equals(action)) {
                orderService.shipOrder(oId);
            } 
            // 用通用的 updateOrderStatus(oid, status)
            else if ("status".equals(action)) {
                int newStatus = Integer.parseInt(request.getParameter("status"));
                orderService.updateOrderStatus(oId, newStatus);
            }
            
        }

        // 4. 更新完毕，重定向回列表页
        response.sendRedirect(request.getContextPath() + "/AdminOrderListServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}

