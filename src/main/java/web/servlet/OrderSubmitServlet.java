package web.servlet;

import domain.User;
import domain.CartItem;
import domain.Order;
import domain.OrderDetail;
import service.OrderService;
import service.impl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/OrderSubmitServlet")
public class OrderSubmitServlet extends HttpServlet {

    private OrderService orderService = new OrderServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {        
        request.setCharacterEncoding("UTF-8");

        User user = (User) request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. 获取购物车数据
        List<CartItem> cartItems = (List<CartItem>) request.getSession().getAttribute("cartItems");
        if (cartItems == null || cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        // 3. 获取表单提交的收货信息
        String receiverName = request.getParameter("receiverName");
        String receiverPhone = request.getParameter("receiverPhone");
        String shippingAddress = request.getParameter("shippingAddress");

        // 简单的空值校验，防止直接访问Servlet
        if (receiverName == null || receiverPhone == null || shippingAddress == null ||
            receiverName.trim().isEmpty() || shippingAddress.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/CheckoutServlet");
            return;
        }

        // 4. 构建全新的单数订单主表对象
        String oId = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        double total = 0;
        List<OrderDetail> itemList = new ArrayList<>();

        // 5. 遍历购物车，拆解装配为明细表集合
        for (CartItem item : cartItems) {
            if (item.getProduct() == null) continue;

            OrderDetail detail = new OrderDetail();
            detail.setOid(oId);                          
            detail.setPid(item.getProduct().getId());    
            detail.setCount(item.getQuantity());

            // 严谨处理价格高精度乘法，防止失真
            BigDecimal price = new BigDecimal(String.valueOf(item.getProduct().getPrice()));
            BigDecimal quantity = new BigDecimal(item.getQuantity());
            double subTotal = price.multiply(quantity).doubleValue();

            detail.setSubTotal(subTotal);
            detail.setProduct(item.getProduct());

            total += subTotal;
            itemList.add(detail);
        }

        // 6. 完整组装订单对象
        Order order = new Order();
        order.setOid(oId);                 
        order.setUid(user.getUid());       
        order.setTotal(total);
        order.setStatus(0);          
        order.setOrderTime(new Date()); 

        // 注入地址与物流追溯信息
        order.setReceiverName(receiverName);
        order.setReceiverPhone(receiverPhone);
        order.setShippingAddress(shippingAddress);
        order.setItems(itemList);

        // 7. 真实落库保存
        orderService.saveOrder(order);

        // 8. 结算成功后清除购物车，防止重复购买
        request.getSession().removeAttribute("cartItems");

        // 9. 重定向到我的订单页面
        response.sendRedirect(request.getContextPath() + "/MyOrdersServlet");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {       
        // 如果有人通过浏览器地址栏直接GET访问，直接打回购物车
        response.sendRedirect(request.getContextPath() + "/cart.jsp");
    }
}
