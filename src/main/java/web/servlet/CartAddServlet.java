package web.servlet;

import dao.ProductDao;
import dao.impl.ProductDaoImpl;
import domain.Product;
import domain.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    private ProductDao productsDao = new ProductDaoImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 验证登录
        Object user = request.getSession().getAttribute("user");
        if (user == null) {
            request.setAttribute("login_msg", "请先登录后再加入购物车！");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // 2. 取商品
        int pId = Integer.parseInt(request.getParameter("pId"));
        Product product = productsDao.findById(pId);

        // 3. 从 session 取购物车 List（key 统一用 cartItems）
        java.util.List<CartItem> cartItems =
            (java.util.List<CartItem>) request.getSession().getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new java.util.ArrayList<>();
            request.getSession().setAttribute("cartItems", cartItems);
        }

        // 4. 已存在则数量+1，否则新增
        boolean found = false;
        for (CartItem item : cartItems) {
            if (item.getProduct().getId() == pId) {
                item.setQuantity(item.getQuantity() + 1);
                found = true;
                break;
            }
        }
        if (!found) {
            cartItems.add(new CartItem(product, 1));
        }

        // 5. 重定向到购物车页
        response.sendRedirect(request.getContextPath() + "/CartViewServlet");
    }
}