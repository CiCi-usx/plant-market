package web.servlet;

import dao.ProductDao;
import dao.impl.ProductDaoImpl;
import domain.Product;
import org.apache.commons.beanutils.BeanUtils;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Map;
import java.util.Arrays;

/**
 * 商品编辑控制器
 * 负责处理单条商品的“数据回显”与“数据修改保存”逻辑。
 * 
 * @version 2026-06-21
 */
@WebServlet("/ProductEditServlet")
public class ProductEditServlet extends HttpServlet {
    
    private ProductDao productDao = new ProductDaoImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String pIdStr = request.getParameter("pId");

        // 健壮性校验：只有传了合法的 pId 才可以进入回显编辑
        if (pIdStr != null && !pIdStr.isEmpty()) {
            int pId = Integer.parseInt(pIdStr);
            Product product = productDao.findById(pId);

            if (product != null) {
                request.setAttribute("product", product);

                // ================= 【核心修复：动态扫描并下发图片列表】 =================
                // 1. 获取运行时的 upload 真实物理路径，因upload迁移到assets下故修改
                String runtimePath = request.getServletContext().getRealPath("/assets/images");
                java.io.File uploadDir = new java.io.File(runtimePath);
                
                // 2. 健壮性
                // if (!uploadDir.exists()) { uploadDir.mkdirs(); }
                
                // 3. 获取目录下所有的文件名
                String[] images = uploadDir.list();
                
                // 4. 将数组塞进 request 域，对齐 JSP 里的 <c:forEach items="${images}" var="file">
                request.setAttribute("images", images);
                // =====================================================================

                // 数据全了（有商品，有图片列表），正常转发到编辑页面
                request.getRequestDispatcher("/admin/productEdit.jsp").forward(request, response);
                return; // 结束方法，防止重复转发
            }
        }

        // 如果 pId 为空或者根本没查到这件商品，说明请求非法，直接送回列表页
        response.sendRedirect(request.getContextPath() + "/ProductListServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        
        Map<String, String[]> parameterMap = request.getParameterMap();
        Product product = new Product();
        try {
            BeanUtils.populate(product, parameterMap);
        } catch (Exception e) {
            e.printStackTrace();
        }

// ================= 【控制台输出：排查问题】 =================
    System.out.println("========== ProductEditServlet doPost 执行 ==========");
    System.out.println("接收到的所有参数：");
    for (Map.Entry<String, String[]> entry : parameterMap.entrySet()) {
        System.out.println(entry.getKey() + " = " + Arrays.toString(entry.getValue()));
    }
    
    System.out.println("BeanUtils封装后的商品信息：");
    System.out.println("ID: " + product.getId());
    System.out.println("名称: " + product.getName());
    System.out.println("产地: " + product.getOrigin());
    System.out.println("价格: " + product.getPrice());
    System.out.println("库存: " + product.getStock());
    System.out.println("图片: " + product.getImg());
    System.out.println("描述: " + product.getDescription());
    System.out.println("==================================================");
    // ==================================================================
        
        // 调用 DAO 写入数据库修改
        productDao.edit(product);
        
        // 重定向
        response.sendRedirect(request.getContextPath() + "/ProductListServlet");
    }
}