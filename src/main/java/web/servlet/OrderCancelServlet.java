package web.servlet;

import domain.User;
import domain.Order;
import service.OrderService;
import service.impl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/OrderCancelServlet")
public class OrderCancelServlet extends HttpServlet {
    
    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("\n======= OrderCancelServlet 开始执行 =======");
        
        // 1. 获取参数 (oid 是字符串，不用转 int 了)
        String oid = request.getParameter("oid");
        User loginUser = (User) request.getSession().getAttribute("user");
        
        System.out.println("1. 获取到参数 oid: " + oid);
        System.out.println("1. 获取到登录用户: " + (loginUser != null ? loginUser.getUid() : "null"));
        
        // 2. 基础校验
        if (oid == null || oid.isEmpty()) {
            System.out.println("2. 校验失败: 订单ID为空！");
            request.getSession().setAttribute("msg", "订单ID不能为空！");
            response.sendRedirect(request.getContextPath() + "/userCenter.jsp");
            return;
        }
        
        if (loginUser == null) {
            System.out.println("2. 校验失败: 用户未登录！");
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        try {
            // 去掉了 Integer.parseInt(oidStr)
            System.out.println("3. 准备查询订单，oid: " + oid);
            
            // 3. 查询订单信息（用于校验）
            // 注意：你的 OrderService.findById 方法接收的参数类型也需要改成 String！
            Order order = orderService.findById(oid);
            System.out.println("3. 查询订单结果: " + (order != null ? order.toString() : "null"));
            
            if (order == null) {
                System.out.println("4. 订单不存在！");
                request.getSession().setAttribute("msg", "该订单不存在！");
            } 
            // 4. 权限校验：确保取消的是自己的订单
            else if (order.getUid() != loginUser.getUid()) {
                System.out.println("4. 权限校验失败: 订单uid(" + order.getUid() + ") != 用户uid(" + loginUser.getUid() + ")");
                request.getSession().setAttribute("msg", "非法操作：无权取消此订单！");
            } 
            // 5. 状态校验：只有状态为 0 (待支付) 的订单才能取消
            else if (order.getStatus() != 0) {
                System.out.println("4. 状态校验失败: 订单状态为 " + order.getStatus() + "，无法取消！");
                request.getSession().setAttribute("msg", "订单当前状态无法取消！");
            } 
            // 6. 执行取消逻辑：将状态更新为 5 (已取消)
            else {
                System.out.println("5. 校验通过，准备更新订单状态为 5...");
                // 注意：你的 updateOrderStatus 方法接收的 oid 参数类型也需要改成 String！
                boolean isSuccess = orderService.updateOrderStatus(oid, 5);
                System.out.println("5. 更新结果: " + isSuccess);
                
                if (isSuccess) {
                    request.getSession().setAttribute("msg", "订单已成功取消！");
                } else {
                    request.getSession().setAttribute("msg", "订单取消失败，请稍后重试！");
                }
            }
            
        } catch (Exception e) {
            System.out.println("异常: 系统错误！");
            e.printStackTrace(); // 在控制台打印完整异常堆栈
            request.getSession().setAttribute("msg", "系统错误，取消订单失败！");
        }
        
        System.out.println("6. 准备重定向到 MyOrdersServlet");
        System.out.println("======= OrderCancelServlet 执行结束 =======\n");
        
        // 7. 重定向回用户中心
        response.sendRedirect(request.getContextPath() + "/MyOrdersServlet");
    }
}
