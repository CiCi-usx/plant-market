package web.servlet;

import domain.CartItem;
import domain.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/CartViewServlet")
public class CartViewServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");

        // 处理删除商品操作
        if ("remove".equals(action)) {
            int pId = Integer.parseInt(request.getParameter("pId"));
            HttpSession session = request.getSession();
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");

            if (cartItems != null) {
                cartItems.removeIf(item -> item.getProduct().getId().equals(pId));
            }

            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
            return;
        }

        // 处理清空购物车操作
        if ("clear".equals(action)) {
            HttpSession session = request.getSession();
            session.removeAttribute("cartItems");
            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
            return;
        }

        // 计算总价并转发到 cart.jsp
        HttpSession session = request.getSession();
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");

        BigDecimal totalPrice = BigDecimal.ZERO;
        int totalCount = 0;
        if (cartItems != null) {
            for (CartItem item : cartItems) {
                totalPrice = totalPrice.add(
                    item.getProduct().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()))
                );
                totalCount += item.getQuantity();
            }
        }
        // 把 cartItems 存入 request 域，供 JSP 的 c:forEach 使用

        request.setAttribute("cartItems", cartItems);
        request.setAttribute("totalPrice", totalPrice);
        request.setAttribute("totalCount", totalCount);
        request.getRequestDispatcher("/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        // ==================== 处理批量删除 ====================
        if ("batchRemove".equals(action)) {
            String[] selectedIds = request.getParameterValues("selectedIds");
            HttpSession session = request.getSession();
            List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");

            if (selectedIds != null && selectedIds.length > 0 && cartItems != null) {
                for (String idStr : selectedIds) {
                    int pId = Integer.parseInt(idStr);
                    // 使用 removeIf 遍历并移除匹配的商品
                    cartItems.removeIf(item -> item.getProduct().getId().equals(pId));
                }
            }
            
            // 删除完成后重定向回购物车页面
            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
            return;
        }

        // 其他 POST 请求按 GET 处理
        doGet(request, response);
    }
}