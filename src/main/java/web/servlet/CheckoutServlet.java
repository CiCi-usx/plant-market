package web.servlet;

import domain.CartItem; // 请替换为你实际的购物车项类名
import domain.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.math.BigDecimal;

@WebServlet("/CheckoutServlet")
public class CheckoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 检查登录状态
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. 从 Session 获取购物车数据
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        
        if (cartItems == null || cartItems.isEmpty()) {
            // 购物车为空，打回购物车页面
            response.sendRedirect(request.getContextPath() + "/cart.jsp");
            return;
        }

        // 3. 计算总金额和总件数
        BigDecimal cartTotal = BigDecimal.ZERO; // 使用 BigDecimal 防止精度丢失
        int cartItemCount = 0;
        
        for (CartItem item : cartItems) {
            if (item.getProduct() == null) continue;
            
            // 获取价格和数量，转为 BigDecimal 进行安全乘法
            BigDecimal price = new BigDecimal(String.valueOf(item.getProduct().getPrice()));
            BigDecimal quantity = new BigDecimal(item.getQuantity());
            
            cartTotal = cartTotal.add(price.multiply(quantity));
            cartItemCount += item.getQuantity();
        }

        // 4. 存入 request 域，转发给 submitOrder.jsp
        request.setAttribute("cartTotal", cartTotal);
        request.setAttribute("cartItemCount", cartItemCount);

        request.getRequestDispatcher("/submitOrder.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}

