package web.servlet;

import service.ProductService;
import service.impl.ProductServiceImpl;
import dao.CategoryDao;
import dao.impl.CategoryDaoImpl;
import domain.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/ProductListByCategoryServlet")
public class ProductListByCategoryServlet extends HttpServlet {

    // 改为依赖 Service 层
    private ProductService productService = new ProductServiceImpl();
    // 这个保留，因为只有 DAO 层有根据 ID 查名称的方法
    private CategoryDao categoryDao = new CategoryDaoImpl(); 

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. 获取 cId 和 pageNo (建议加上非空安全校验)
        String cIdParam = request.getParameter("cId");
        if (cIdParam == null || cIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        int cId = Integer.parseInt(cIdParam);
        String pageNoParam = request.getParameter("pageNo");
        int pageNo = (pageNoParam != null && !pageNoParam.isEmpty()) ? Integer.parseInt(pageNoParam) : 1;

        // 2. cId 转 cName
        String cName = categoryDao.findCategoryNameById(cId);

        // 3. 调用 Service 查总数 和 查列表 (不再直接调用 productDao)
        int totalCount = productService.countByCategory(cName);
        int totalPage = (int) Math.ceil((double) totalCount / PAGE_SIZE);

        // 边界保护：防止 pageNo 越界
        if (pageNo > totalPage && totalPage > 0) pageNo = totalPage;
        if (pageNo < 1) pageNo = 1;

        // 4. 查当页数据
        int offset = (pageNo - 1) * PAGE_SIZE;
        List<Product> productList = productService.getPageByCategory(cName, offset, PAGE_SIZE);

        // 5. 存入 request 域转发
        request.setAttribute("productList", productList);
        request.setAttribute("pageNo", pageNo);
        request.setAttribute("totalPage", totalPage);
        request.setAttribute("cId", cId);
        request.setAttribute("cName", cName);

        request.getRequestDispatcher("/productList.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doGet(request, response);
    }
}
