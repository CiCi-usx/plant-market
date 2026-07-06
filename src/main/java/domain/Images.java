package domain;

import java.io.File;

/**
 * 图像目录文件实体类 / 业务辅助类
 * 用于维护指定物理路径下的文件列表快照
 */
public class Images {
    
    private String[] files; // 图片目录下所有文件名数组
    private String path;    // 图片目录的绝对路径/相对路径

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    /**
     * 动态获取并刷新当前图片目录下的所有文件名
     * 
     * @return String[] 文件名数组；若路径为空或目录不存在则返回 null
     */
    public String[] getFiles() {
        if (path == null) {
            return null;
        }
        
        File parentDirectory = new File(path); // 实例化目录文件对象
        
        // 防御性检查：确保路径存在且确实是一个目录，否则调用 list() 会返回 null 或引发异常
        if (parentDirectory.exists() && parentDirectory.isDirectory()) {
            this.files = parentDirectory.list(); // 获取目录中所有的文件名
        } else {
            this.files = null;
        }
        
        return this.files;
    }
}