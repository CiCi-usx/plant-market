package web.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import javax.imageio.ImageIO;

import java.awt.AlphaComposite;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/UploadImageServlet")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class UploadImageServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. 设置请求与响应编码
        request.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8");

        // 2. 获得 part 对象
        Part part = request.getPart("file");
        
        // Java 中字符串比对不能用 == ""，改用 isEmpty() 或 equals()
        if (part == null || part.getSubmittedFileName() == null || part.getSubmittedFileName().isEmpty()) { 
            // 上传的文件或文件名为空，提示用户
            request.setAttribute("upload_msg", "上传的文件不能为空");
            request.getRequestDispatcher("/admin/upload.jsp").forward(request, response);
            return;
        }

        String desc = request.getParameter("desc"); // 获取图片简介

        // 3. 指定图片存放的目录为 web/assets/images 目录
        File uploadDir = new File(request.getServletContext().getRealPath("/assets/images"));
        // if (!uploadDir.exists()) { uploadDir.mkdir(); }

        String oldName = part.getSubmittedFileName(); // 取上传的文件名
        
        // 用当前日期时间生成新的文件名
        String newName = new SimpleDateFormat("yyyy-MM-dd-HH-mm-ss").format(new Date());
    
        // 新文件名加上后缀名
        newName += oldName.substring(oldName.lastIndexOf("."), oldName.length());

        // 以新文件名保存
        part.write(uploadDir + File.separator + newName);

        // 4. 判断是否为图片，不是图片则删除上传的文件并返回
        String path = uploadDir + File.separator + newName;
        if (!isImage(path)) { // 不是图片
            File file = new File(path);
            if (file.exists()) { // 文件存在
                file.delete(); // 删除文件
            }
            request.setAttribute("upload_msg", "只能上传图片文件。");
            request.getRequestDispatcher("/admin/upload.jsp").forward(request, response);
            return;
        }

        // 如果要生成缩略图，则调用以下函数
        zoom(uploadDir+File.separator, newName, 100,100);
        // 如果要生成水印，则调用以下方法, 生成的带水印的图片文件名为 ”watermark-“ + 原来的文件名
        markImageBySingleText(path, uploadDir+File.separator, "watermark-"+newName, Color.red, "苗木网印", null);

        // 5. 显示已上传文件的信息
        String msg = "上传成功";
        msg += "<br>" + part.getSubmittedFileName(); // 上传的文件名
        msg += "<br>" + part.getName(); // 前端上传控件的名字
        msg += "<br>" + part.getHeader("content-disposition"); // content-disposition 头信息
        msg += "<br>" + desc; // 图片描述
        msg += "<br>" + "上传到：" + uploadDir + File.separator + newName;

        request.setAttribute("upload_msg", msg);
        request.getRequestDispatcher("/admin/upload.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        this.doPost(request, response);
    }

    //判断 所上传的文件是否是图片文件,path：文件在服务器上的完整路径
    private boolean isImage(String path) {
        File file = new File(path);
        // 使用 createImageInputStream 可以保证流能被正确关闭，释放文件锁
        try (javax.imageio.stream.ImageInputStream iis = ImageIO.createImageInputStream(file)) {
            if (iis == null) return false;
            
            java.util.Iterator<javax.imageio.ImageReader> iter = ImageIO.getImageReaders(iis);
            if (!iter.hasNext()) {
                return false; // 找不到能解析它的图片阅读器，说明不是合法图片
            }
            return true;
        } catch (IOException ex) {
            return false;
        }
    }

    /**
     * 图像等比/强制缩放工具方法
     * 
     * @param srcPath      源图片所在目录的绝对路径（需以文件分隔符结尾，例如 "D:/web/upload/"）
     * @param srcFileName  源图片文件名（例如 "2026-05-17-01-02-03.jpg"）
     * @param width        目标缩略图的指定宽度（单位：像素）
     * @param height       目标缩略图的指定高度（单位：像素）
     */
    private void zoom(String srcPath, String srcFileName, int width, int height) {
        try {
            // 1. 读取本地源图片文件流，转换为内存中的 BufferedImage 对象
            File srcFile = new File(srcPath + srcFileName);
            BufferedImage src = ImageIO.read(srcFile);
            if (src == null) {
                return; // 规避非法图片导致 ImageIO 读取返回 null 的隐患
            }

            // 2. 利用图像平滑缩放算法，获取指定宽高尺寸的 Image 实例（拉伸可能导致失真）
            Image scaledImage = src.getScaledInstance(width, height, Image.SCALE_DEFAULT);

            // 3. 构建基于 RGB 颜色模型的空白目标缓冲区，准备承载缩放后的像素数据
            BufferedImage thumb = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);

            // 4. 创建 2D 绘图上下文，将缩放后的 Image 实例绘制渲染到目标缓冲区中
            Graphics2D g2d = thumb.createGraphics();
            g2d.drawImage(scaledImage, 0, 0, null);
            g2d.dispose(); // 显式释放图形上下文占用的系统资源

            // 5. 动态解析文件扩展名，确保保存时的编码格式与原图保持一致
            String formatName = srcFileName.substring(srcFileName.lastIndexOf(".") + 1);

            // 6. 采用 try-with-resources 结构，安全输出缩略图文件（文件名自动加 "thumb-" 前缀）
            File outputFile = new File(srcPath + "thumb-" + srcFileName);
            try (OutputStream out = new FileOutputStream(outputFile)) {
                ImageIO.write(thumb, formatName, out);
            }

        } catch (IOException e) {
            // 生产环境下建议引入标准日志框架（如 Log4j2/SLF4J）进行异常埋点记录
            e.printStackTrace();
        }
    }

    /**
     * 为指定图片添加单个文字水印（支持旋转角度、透明度设置，采用画布几何中心对齐）
     *
     * @param sourcePath 源图片文件的绝对路径（例如："F:/images/6.jpg"）
     * @param outputPath 水印图输出的目录路径（例如："F:/images/"）
     * @param imageName  输出的文件名称（含扩展名，例如："watermark-7.jpg"）
     * @param color      水印文字的颜色对象
     * @param word       水印文本内容
     * @param degree     旋转角度（单位：度。传入 null 或 0 表示不旋转。正数顺时针，负数逆时针）
     * @return Boolean   是否成功生成水印图片
     */
    private Boolean markImageBySingleText(String sourcePath, String outputPath, String imageName,
                                        Color color, String word, Integer degree) {
        // 1. 常量配置定义（解耦控制变量）
        final String FONT_NAME = "微软雅黑";    // 字体族名称
        final int FONT_STYLE = Font.BOLD;        // 字体样式（加粗）
        final int FONT_SIZE = 120;               // 字体大小（单位：像素）
        final float ALPHA = 0.3F;                // 水印不透明度（0.0F 全透明 - 1.0F 不透明）

        try {
            // 2. 校验源文件合法性
            File sourceFile = new File(sourcePath);
            if (!sourceFile.exists() || !sourceFile.isFile()) {
                return false;
            }

            // 3. 载入图像源并初始化图像缓冲区
            Image srcImage = ImageIO.read(sourceFile);
            if (srcImage == null) {
                return false; // 防御：规避非合法图像文件导致的空指针异常
            }
            int width = srcImage.getWidth(null);
            int height = srcImage.getHeight(null);

            // 动态解析文件扩展名作为 ImageIO 写入时的格式标识符 (Format Name)
            String imageType = imageName.substring(imageName.lastIndexOf(".") + 1);

            // 创建与源图尺寸一致的 RGB 图像渲染缓冲区
            BufferedImage bufferedImage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
            Graphics2D g2d = bufferedImage.createGraphics();

            // 4. 渲染源图到画布基底层
            g2d.drawImage(srcImage, 0, 0, width, height, null);

            // 5. 配置图形上下文的水印渲染参数
            Font font = new Font(FONT_NAME, FONT_STYLE, FONT_SIZE);
            g2d.setFont(font);
            g2d.setColor(color);
            // 配置 Alpha 混色合成器以实现半透明视觉效果
            g2d.setComposite(AlphaComposite.getInstance(AlphaComposite.SRC_ATOP, ALPHA));

            // 6. 处理画布旋转变换（以画布绝对几何中心为轴心）
            if (degree != null && degree != 0) {
                double anchorX = (double) width / 2;
                double anchorY = (double) height / 2;
                g2d.rotate(Math.toRadians(degree), anchorX, anchorY);
            }

            // 7. 使用 FontMetrics 精准计算多语言文字的物理宽高，实现完美居中
            FontMetrics metrics = g2d.getFontMetrics(font);
            int textWidth = metrics.stringWidth(word);       // 文本的总渲染物理宽度
            int textHeight = metrics.getAscent();            // 文本基线以上的物理高度

            // 计算绘制基准点（X 轴完美居中，Y 轴考虑文字高度修正以确保视觉中心对齐）
            int x = (width - textWidth) / 2;
            int y = (height + textHeight) / 2;

            // 8. 执行文本绘制并释放图形上下文资源
            g2d.drawString(word, x, y);
            g2d.dispose();

            // 9. 持续化到磁盘物理文件
            File outputDir = new File(outputPath);
            if (!outputDir.exists()) {
                outputDir.mkdirs(); // 防御：确保输出目录存在
            }
            File outputFile = new File(outputDir, imageName);
            ImageIO.write(bufferedImage, imageType, outputFile);

            return true;
        } catch (Exception e) {
            // 生产环境下建议通过日志门面（如 SLF4J）输出 Error 堆栈
            e.printStackTrace();
            return false;
        }
    }
}
