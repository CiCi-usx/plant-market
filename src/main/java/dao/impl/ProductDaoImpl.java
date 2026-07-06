package dao.impl;

import dao.ProductDao;
import domain.Product;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

/**
 * 商品持久层接口实现类
 * @version 2026-07-06
 */
public class ProductDaoImpl implements ProductDao {
    
    // 初始化 JdbcTemplate
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public void add(Product product) {
        // 注意：INSERT 和 UPDATE 语句的列名是数据库实际列名，不需要改
        String sql = "INSERT INTO exp4_product (pId, pName, pImg, description, price, category, origin, stock, sales) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        // 注意：这里的 Getter 已经换成了去前缀化的新方法名
        template.update(sql, 
                product.getId(),       // 原 getPId()
                product.getName(),     // 原 getPName()
                product.getImg(),      // 原 getPImg()
                product.getDescription(), 
                product.getPrice(), 
                product.getCategory(), 
                product.getOrigin(), 
                product.getStock(), 
                product.getSales()
        );
    }

    @Override
    public void edit(Product product) {
        if (product == null || product.getId() == null) {
            System.out.println("错误：ProductDaoImpl edit() 尝试更新的商品 ID 为空，拒绝执行更新！");
            return;
        }
    String sql = "UPDATE exp4_product SET pName = ?, pImg = ?, description = ?, price = ?, category = ?, origin = ?, stock = ? WHERE pId = ?";
        
        template.update(sql, 
            product.getName(),      // 对应 pName
            product.getImg(),       // 对应 pImg
            product.getDescription(),
            product.getPrice(),
            product.getCategory(),
            product.getOrigin(),
            product.getStock(),
            product.getId()
        );
    }

    @Override
    public Product findById(int id) { // 参数名从 pId 改为 id
        try {
            // 【关键修改】：使用 AS 将数据库列名映射为 Java 属性名
            String sql = "SELECT pId AS id, pName AS name, pImg AS img, description, price, category, origin, stock, sales, createTime, status FROM exp4_product WHERE pId = ?";
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Product.class), id);
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Product> findAll() {
        try {
            // 【关键修改】：同上，加上 AS 别名
            String sql = "SELECT pId AS id, pName AS name, pImg AS img, description, price, category, origin, stock, sales, createTime, status FROM exp4_product";
            return template.query(sql, new BeanPropertyRowMapper<>(Product.class));
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public List<Product> findTopSalesPage(int offset, int pageSize) {
        // 【关键修改】：加上 AS 别名
        String sql =
                "SELECT pId AS id, pName AS name, pImg AS img, description, price, category, origin, stock, sales, createTime, status " +
                "FROM exp4_product " +
                "WHERE status=1 " +
                "ORDER BY sales DESC " +
                "LIMIT ?, ?";

        return template.query(
                sql,
                new BeanPropertyRowMapper<>(Product.class),
                offset,
                pageSize
        );
    }

    @Override
    public List<Product> findByCategoryPage(String category, int offset, int pageSize) {
        // 【关键修改】：加上 AS 别名
        String sql =
                "SELECT pId AS id, pName AS name, pImg AS img, description, price, category, origin, stock, sales, createTime, status " +
                "FROM exp4_product " +
                "WHERE category=? AND status=1 " +
                "LIMIT ?, ?";

        return template.query(sql, new BeanPropertyRowMapper<>(Product.class), category, offset, pageSize);
    }

    @Override
    public int countByCategory(String category) {
        // COUNT 函数不需要映射对象，不需要改
        String sql = "SELECT COUNT(*) FROM exp4_product WHERE category = ? AND status = 1";
        return template.queryForObject(sql, Integer.class, category);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        
        // 基础的 SELECT 语句，提取出来复用，方便维护
        String baseSelect = "SELECT pId AS id, pName AS name, pImg AS img, description, price, category, origin, stock, sales, createTime, status FROM exp4_product ";

        if (keyword == null || keyword.trim().isEmpty()) {
            String sql = baseSelect + "WHERE status = 1";
            return template.query(sql, new BeanPropertyRowMapper<>(Product.class));
        }

        // 【关键修改】：WHERE 条件里的 pName 是数据库列名，不能改
        String sql = baseSelect + "WHERE status = 1 AND pName LIKE ?";

        return template.query(sql, new BeanPropertyRowMapper<>(Product.class), "%" + keyword.trim() + "%");
    }
}
