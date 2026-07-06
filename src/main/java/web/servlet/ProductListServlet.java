package web.servlet;

import dao.ProductDao;
import dao.impl.ProductDaoImpl;
import domain.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * 后台商品列表展示控制器
 * 
 * @version 2026-05-212
 */
@WebServlet("/ProductListServlet")
public class ProductListServlet extends HttpServlet {

    private ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 调用 DAO 层查询所有的商品记录
        List<Product> productList = productDao.findAll();

        // 2. 将数据集合存入 request 域，供 productList.jsp 识别
        request.setAttribute("productList", productList);

        String runtimePath = request.getServletContext().getRealPath("/upload");
            java.io.File uploadDir = new java.io.File(runtimePath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs(); // 防止前端报 404
            }

        // 3. 转发到商品列表展示页面
        request.getRequestDispatcher("/admin/productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 防止由于误用 POST 方法导致 405 错误，统一交由 doGet 处理
        this.doGet(request, response);
    }
}