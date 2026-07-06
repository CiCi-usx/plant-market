package servlet;

import domain.Product;
import domain.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.CartItemService;
import service.impl.CartItemServiceImpl;

import java.io.IOException;

@WebServlet("/CartAddServlet")
public class CartAddServlet extends HttpServlet {
    
    private CartItemService cartService = new CartItemServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // 1. 验证登录状态
            Object user = request.getSession().getAttribute("user");
            if (user == null) {
                // 未登录，重定向到登录页
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }
            
            // 2. 获取参数
            String pidStr = request.getParameter("pid");
            String quantityStr = request.getParameter("quantity");
            
            // 参数校验
            if (pidStr == null || pidStr.trim().isEmpty() || quantityStr == null || quantityStr.trim().isEmpty()) {
                System.out.println("pid or quantity is not proper. CartAddServlet.java(44)");
                response.sendRedirect(request.getContextPath() + "/CartViewServlet");
                return;
            }
            
            Integer pid = Integer.parseInt(pidStr);
            Integer quantity = Integer.parseInt(quantityStr);
            
            if (quantity <= 0) {
                response.sendRedirect(request.getContextPath() + "/CartViewServlet");
                return;
            }
            
            // 3. 获取用户信息
            User loginUser = (User) user;
            Integer uid = loginUser.getUid();
            
            // 4. 创建商品对象（只需要pid）
            Product product = new Product();
            product.setPid(pid);
            
            // 5. 添加到购物车
            cartService.addToCart(uid, product, quantity);
            
            // 6. 重定向到购物车页面
            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
            
        } catch (NumberFormatException e) {
            // 参数格式错误，只在控制台输出
            System.err.println("CartAddServlet - 参数格式错误: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
        } catch (Exception e) {
            // 其他异常，只在控制台输出
            System.err.println("CartAddServlet - 添加购物车失败: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/CartViewServlet");
        }
    }
}