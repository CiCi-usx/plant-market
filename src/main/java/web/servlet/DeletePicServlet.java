package web.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;

/**
 * 后台管理员：物理删除指定图片 Servlet
 */
@WebServlet("/admin/DeletePicServlet")
public class DeletePicServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置请求编码
        request.setCharacterEncoding("utf-8");
        
        // 2. 获取接收的图片文件名
        String fileName = request.getParameter("pic");
        
        // 安全拦截：判断文件名参数是否为空
        if (fileName == null || fileName.trim().isEmpty()) {
            request.setAttribute("delete_msg", "文件名不能为空。");
            request.getRequestDispatcher("/admin/deletePic.jsp").forward(request, response);
            return;
        }

        // 3. 构建基于 Web 容器上下文绝对路径的磁盘文件对象
        String realPath = request.getServletContext().getRealPath("/upload/" + fileName);
        File file = new File(realPath);

        // 4. 执行删除逻辑
        if (file.exists() && file.isFile()) {
            if (file.delete()) {
                request.setAttribute("delete_msg", "删除成功。");
            } else {
                // 常见失败原因：文件被系统其他流锁定（例如 ImageIO 未关闭）或无修改权限
                request.setAttribute("delete_msg", "物理删除失败，文件可能被占用。");
            }
        } else {
            request.setAttribute("delete_msg", "文件不存在，无需删除。");
        }

        // 5. 统一收拢转发（减少冗余的 dispatcher 代码）
        request.getRequestDispatcher("/admin/deletePic.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }
}