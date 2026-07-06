package web.servlet;

import dao.ProductDao;
import dao.impl.ProductDaoImpl;
import domain.Product;
import domain.User;
import domain.Order;
import domain.OrderDetail;
import service.OrderService;
import service.impl.OrderServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/ProductDetailServlet")
public class ProductDetailServlet extends HttpServlet {
    private ProductDao productsDao = new ProductDaoImpl();
    private OrderService orderService = new OrderServiceImpl();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pIdStr = request.getParameter("pId");
        if (pIdStr != null && !pIdStr.isEmpty()) {
            Product product = productsDao.findById(Integer.parseInt(pIdStr));
            request.setAttribute("product", product);

            // === 新增：从 Session 获取该商品的模拟评论 ===
            HttpSession session = request.getSession();
            Map<Integer, List<String[]>> allReviews = (Map<Integer, List<String[]>>) session.getAttribute("mockReviews");
            if (allReviews == null) {
                allReviews = new HashMap<>();
            }
            // 获取当前商品的评论列表，如果没有就新建一个空的
List<String[]> currentProductReviews = allReviews.getOrDefault(product.getId(), new ArrayList<>());
            request.setAttribute("reviewList", currentProductReviews);
            // ==========================================

            // 判断当前用户是否已购买且已收货该商品
            boolean hasReceived = false;
            User user = (User) request.getSession().getAttribute("user");
            
            if (user != null && product != null) {
                List<Order> myOrders = orderService.findUserOrders(user.getUid());
                int currentProductId = product.getId(); 

                if (myOrders != null) {
                    for (Order order : myOrders) {
                        if (order.getStatus() >= 3 && order.getItems() != null) {
                            for (OrderDetail item : order.getItems()) {
                                if (item.getProduct() != null 
                                    && item.getProduct().getId() != null 
                                    && item.getProduct().getId().equals(currentProductId)) {
                                    hasReceived = true;
                                    break;
                                }
                            }
                        }
                        if (hasReceived) {
                            break;
                        }
                    }
                }
            }
            request.setAttribute("hasReceived", hasReceived);

            request.getRequestDispatcher("/productDetail.jsp").forward(request, response);
            return;
        }
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // 防止中文乱码
        
        String action = request.getParameter("action");
        
        if ("addReview".equals(action)) {
            String pIdStr = request.getParameter("pId");
            String ratingStr = request.getParameter("rating");
            String content = request.getParameter("content");
            User user = (User) request.getSession().getAttribute("user");
            
            if (user != null && pIdStr != null) {
                int pId = Integer.parseInt(pIdStr);
                int rating = Integer.parseInt(ratingStr);
                
                // === 新增：将评论存入 Session ===
                HttpSession session = request.getSession();
                // Session 里存一个 Map：键是商品ID，值是该商品的评论列表
                Map<Integer, List<String[]>> allReviews = (Map<Integer, List<String[]>>) session.getAttribute("mockReviews");
                if (allReviews == null) {
                    allReviews = new HashMap<>();
                }
                
                // 获取当前商品的评论列表，如果没有就新建
                List<String[]> reviewList = allReviews.getOrDefault(pId, new ArrayList<>());
                
                // 将评论信息存为数组：[用户名, 评分, 评论内容]
                String[] reviewData = new String[]{
                    user.getUname(),
                    String.valueOf(rating),
                    content
                };
                reviewList.add(reviewData);
                
                // 放回 Map
                allReviews.put(pId, reviewList);
                // 存回 Session
                session.setAttribute("mockReviews", allReviews);
                // ================================
            }
            
            // 重定向回当前商品详情页
            response.sendRedirect(request.getContextPath() + "/ProductDetailServlet?pId=" + pIdStr);
        } else {
            doGet(request, response);
        }
    }
}
