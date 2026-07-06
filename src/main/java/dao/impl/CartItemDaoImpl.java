package dao.impl;

import dao.CartItemDao;
import domain.CartItem;
import domain.Product;
import util.JDBCUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CartItemDaoImpl implements CartItemDao {

    @Override
    public CartItem isExisted(int uid, int pid) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        CartItem cart = null;
        try {
            conn = JDBCUtils.getConnection();
            // 1. SQL语句全部对齐纯小写
            String sql = "SELECT * FROM exp4_cart_item WHERE uid = ? AND pid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, uid);
            pstmt.setInt(2, pid);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                cart = new CartItem();
                // 2. rs.getInt 内和 setter 方法全部对齐纯小写
                cart.setCartid(rs.getInt("cartid"));
                cart.setUid(rs.getInt("uid"));
                
                // 3. 完美封装组合的 Product 对象
                Product product = new Product();
                product.setId(rs.getInt("pid"));
                cart.setProduct(product);
                
                cart.setQuantity(rs.getInt("quantity"));
                cart.setAddtime(rs.getTimestamp("addtime"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
        return cart;
    }

    @Override
    public void add(CartItem item) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "INSERT INTO exp4_cart_item(uid, pid, quantity) VALUES(?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, item.getUid());
            // 4. 从关联的 product 对象中获取商品 pid
            pstmt.setInt(2, item.getProduct().getId()); 
            pstmt.setInt(3, item.getQuantity());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }

    @Override
    public void update(CartItem item) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        try {
            conn = JDBCUtils.getConnection();
            String sql = "UPDATE exp4_cart_item SET quantity = ? WHERE uid = ? AND pid = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, item.getQuantity());
            pstmt.setInt(2, item.getUid());
            pstmt.setInt(3, item.getProduct().getId());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}