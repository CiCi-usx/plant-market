package dao.impl;

import dao.CartItemDao;
import dao.ProductDao;
import domain.CartItem;
import domain.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import util.JDBCUtils;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class CartItemDaoImpl implements CartItemDao {
    
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());
    
    @Override
    public CartItem isExisted(Integer uid, Integer pid) {
        try {
            String sql = "SELECT cartid, uid, pid, quantity, addtime FROM exp4_cart_item WHERE uid = ? AND pid = ?";
            return template.queryForObject(sql, new RowMapper<CartItem>() {
                @Override
                public CartItem mapRow(ResultSet rs, int rowNum) throws SQLException {
                    CartItem item = new CartItem();
                    item.setCartid(rs.getInt("cartid"));
                    item.setUid(rs.getInt("uid"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddtime(rs.getTimestamp("addtime"));
                    
                    // 创建 Product 并设置 pid
                    Product product = new Product();
                    product.setPid(rs.getInt("pid"));
                    item.setProduct(product);
                    
                    return item;
                }
            }, uid, pid);
        } catch (Exception e) {
            return null;
        }
    }
    
    @Override
    public void add(CartItem item) {
        // 先检查是否已存在
        CartItem existing = isExisted(item.getUid(), item.getProduct().getPid());
        
        if (existing != null) {
            // 如果已存在，更新数量（累加）
            existing.setQuantity(existing.getQuantity() + item.getQuantity());
            update(existing);
        } else {
            // 如果不存在，新增
            String sql = "INSERT INTO exp4_cart_item (uid, pid, quantity, addtime) VALUES (?, ?, ?, ?)";
            template.update(sql, 
                item.getUid(), 
                item.getProduct().getPid(), 
                item.getQuantity(), 
                new java.util.Date()
            );
        }
    }
    
    @Override
    public void update(CartItem item) {
        String sql = "UPDATE exp4_cart_item SET quantity = ? WHERE cartid = ?";
        template.update(sql, item.getQuantity(), item.getCartid());
    }
    
    @Override
    public CartItem findById(Integer cartItemId) {
        try {
            String sql = "SELECT cartid, uid, pid, quantity, addtime FROM exp4_cart_item WHERE cartid = ?";
            return template.queryForObject(sql, new RowMapper<CartItem>() {
                @Override
                public CartItem mapRow(ResultSet rs, int rowNum) throws SQLException {
                    CartItem item = new CartItem();
                    item.setCartid(rs.getInt("cartid"));
                    item.setUid(rs.getInt("uid"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setAddtime(rs.getTimestamp("addtime"));
                    
                    Product product = new Product();
                    product.setPid(rs.getInt("pid"));
                    item.setProduct(product);
                    
                    return item;
                }
            }, cartItemId);
        } catch (Exception e) {
            return null;
        }
    }
    
    @Override
    public void delete(Integer cartItemId) {
        String sql = "DELETE FROM exp4_cart_item WHERE cartid = ?";
        template.update(sql, cartItemId);
    }
    
    @Override
    public void clearByUid(Integer uid) {
        String sql = "DELETE FROM exp4_cart_item WHERE uid = ?";
        template.update(sql, uid);
    }
    
    @Override
    public List<CartItem> findByUid(Integer uid) {
        // 第一步：查询购物车项
        String sql = "SELECT cartid, uid, pid, quantity, addtime FROM exp4_cart_item WHERE uid = ? ORDER BY addtime DESC";
        
        List<CartItem> items = template.query(sql, new RowMapper<CartItem>() {
            @Override
            public CartItem mapRow(ResultSet rs, int rowNum) throws SQLException {
                CartItem item = new CartItem();
                item.setCartid(rs.getInt("cartid"));
                item.setUid(rs.getInt("uid"));
                item.setQuantity(rs.getInt("quantity"));
                item.setAddtime(rs.getTimestamp("addtime"));
                
                // 创建 Product 并设置 pid（临时保存）
                Product product = new Product();
                product.setPid(rs.getInt("pid"));
                item.setProduct(product);
                
                return item;
            }
        }, uid);
        
        // 第二步：查询完整的商品信息并替换
        ProductDao productDao = new ProductDaoImpl();
        for (CartItem item : items) {
            if (item.getProduct() != null) {
                Product fullProduct = productDao.findById(item.getProduct().getPid());
                item.setProduct(fullProduct);
            }
        }
        
        return items;
    }
}