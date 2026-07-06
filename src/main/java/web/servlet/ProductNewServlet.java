package web.servlet;

import domain.Category;
import domain.Product;
import service.CategoryService;
import service.impl.CategoryServiceImpl;
import service.ProductService;
import service.impl.ProductServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 产品新增 Servlet
 * 处理 /admin/ProductNewServlet 路径的请求
 * 用于展示商品新增表单以及处理表单提交的数据
 */
@WebServlet("/ProductNewServlet")
public class ProductNewServlet extends HttpServlet {

    /**
     * 处理 GET 请求：展示商品新增页面，准备下拉框（商品类别）以及已上传图片列表
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 调用 Service 层获取所有商品类别（Category）
        CategoryService cs = new CategoryServiceImpl();
        List<Category> classList = cs.findAll();      
        request.setAttribute("classList", classList); 

        // 2. 获取 /upload 目录下所有已上传的图片文件名
        String pathStr = request.getServletContext().getRealPath("/assets/images");
        File uploadDir = new File(pathStr);

        // if (!uploadDir.exists()) { uploadDir.mkdirs(); }

        // 获取文件列表并进行安全校验
        String[] images = uploadDir.list();
        if (images == null) {
            images = new String[0]; 
        }
        request.setAttribute("images", images);

        // ==================== 🛠️ 双路日志输出开始 ====================
        String separator = "==================================================";
        String logMsg = "\n" + separator + 
                        "\n【DOGET 触发成功】正在访问商品新增页面" +
                        "\n【扫描绝对路径】: " + pathStr + 
                        "\n【当前找到的文件数量】: " + images.length + " 个" +
                        "\n【文件列表详情】: " + java.util.Arrays.toString(images) + 
                        "\n" + separator;

        // 方式一：输出到标准控制台（如果是命令行通过 catalina run 启动，会直接在黑窗口打印）
        System.out.println(logMsg);

        // 方式二：强制写入 Tomcat Servlet 容器日志（落入 Web 容器日志文件中）
        request.getServletContext().log("ProductNewServlet-doGet 诊断信息: " + logMsg);
        // ==================== 🛠️ 双路日志输出结束 ====================

        // 3. 请求转发到 productNew.jsp 页面
        request.getRequestDispatcher("/admin/productNew.jsp").forward(request, response);
    }

    /**
     * 处理 POST 请求：接收新增商品表单提交的数据，执行添加操作
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. 设置请求与响应的字符编码，防止中文乱码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 2. 获取客户端提交的所有请求参数（键值对形式，值为 String[]）
        Map<String, String[]> map = request.getParameterMap();

        // 3. 创建 Product 对象，并使用 BeanUtils 将请求参数封装到该对象中
        Product product = new Product();
        try {
            // BeanUtils.populate 会自动将请求参数中同名的属性设置到 product 对象中
            BeanUtils.populate(product, map);
        } catch (Exception e) {
            e.printStackTrace();   // 实际项目中建议记录日志
        }

        // 设置商品录入时间为当前系统时间
        product.setCreateTime(new Date());

        // （可选）数据验证可在此处自行完成，例如检查必填项、数字格式等
        // 如验证失败可返回错误信息，此处略

        // 4. 调用 Service 层的添加商品方法，将商品信息保存到数据库
        ProductServiceImpl service = new ProductServiceImpl();
        service.addProduct(product);   // 执行添加操作

        // 5. 添加成功后的处理：将成功信息放入 request 域，并重新准备页面需要的数据
        request.setAttribute("add_msg", "增加成功");

        // 重新获取所有商品类别，以便在下拉框中保持最新数据（例如新增类别的情况）
        CategoryService cs = new CategoryServiceImpl();  // 注意原代码中可能存在类名不一致
        // 原代码写的是 CategoryService，变量为 cs，这里沿用（实际应保持与 Service 层一致）
        request.setAttribute("classList", cs.findAll());

        // 重新获取 /upload 目录下的图片文件列表
        String pathStr = request.getServletContext().getRealPath("/upload");
        request.setAttribute("images", new File(pathStr).list());

        // 6. 转发回 productNew.jsp 页面，显示增加成功的提示，同时表单可继续添加新商品
        request.getRequestDispatcher("/admin/productNew.jsp").forward(request, response);

        // ========= 以下是注释掉的几种其他跳转方式 =========
        // 方式1：直接重定向到 productNew.jsp（会导致 request 域中的数据丢失）
        // response.sendRedirect(request.getContextPath() + "/admin/productNew.jsp");

        // 方式2：直接输出脚本提示，并使用 refresh 头实现延时跳转
        // response.getWriter().println("增加成功，3秒后返回");
        // response.setHeader("refresh", "3;url=" + request.getContextPath() + "/admin/productNew.jsp");
    }
}