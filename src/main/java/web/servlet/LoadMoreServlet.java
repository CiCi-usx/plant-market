package web.servlet;

import domain.Product;

import service.ProductService;
import service.impl.ProductServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/LoadMoreServlet")
public class LoadMoreServlet extends HttpServlet {
    private ProductService productService = new ProductServiceImpl();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        int page = Integer.parseInt(request.getParameter("page"));
        int pageSize = 5;
        int offset = (page - 1) * pageSize;
        List<Product> list = null;
        switch (type) {
            case "fruit":
                list = productService.getPageByCategory("果树", offset, pageSize);
                break;

            case "non-fruit":
                list = productService.getPageByCategory("非果树", offset, pageSize);
                break;

            case "sales":
                list = productService.getSalesPage(offset, pageSize);
                break;
        }
        request.setAttribute("productList", list);
        request.getRequestDispatcher("/snippet/product-card.jsp").forward(request, response);
    }
}
