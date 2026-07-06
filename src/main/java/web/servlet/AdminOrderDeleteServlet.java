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

@WebServlet("/AdminOrderDeleteServlet")
public class AdminOrderDeleteServlet extends HttpServlet {

    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置请求编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // 2. 获取前端传递的订单 ID
        String oId = request.getParameter("oId");

        // 3. 健壮性校验：如果 oId 不为空，则执行删除
        if (oId != null && !oId.trim().isEmpty()) {
            // 封装 Order 对象交给 Service 层
            Order order = new Order();
            order.setOid(oId);
            
            // 调用 Service 执行删除 (Service内部已处理先删明细再删主表)
            orderService.deleteOrder(order);
        }

        // 4. 删除完成后，重定向回订单列表 Servlet，刷新数据
        response.sendRedirect(request.getContextPath() + "/AdminOrderListServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}

