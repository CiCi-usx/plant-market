package dao.impl;

import dao.OrderDao;
import domain.Order;
import domain.OrderDetail;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;
import java.util.List;
import java.sql.ResultSet;
import java.sql.SQLException;
import domain.Product;


public class OrderDaoImpl implements OrderDao {
    
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<Order> findAll() {
        try {
            String sql = "SELECT * FROM exp4_order ORDER BY orderTime DESC";
            return template.query(sql, new BeanPropertyRowMapper<>(Order.class));
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public void updateStatusToShipped(String oId) {
        // 管理员点击发货：将状态修改为 2（已发货），并记录当前系统时间为发货时间 shipTime
        String sql = "UPDATE exp4_order SET status = 2, shipTime = NOW() WHERE oId = ?";
        template.update(sql, oId);
    }

    @Override
    public void addOrder(Order order) {
        String sql = "INSERT INTO exp4_order(oId, orderTime, total, status, uId, receiverName, receiverPhone, shippingAddress) VALUES(?,?,?,?,?,?,?,?)";
        
        template.update(sql, 
            order.getOid(),
            order.getOrderTime(),
            order.getTotal(),
            order.getStatus(),
            order.getUid(),
            order.getReceiverName(),     
            order.getReceiverPhone(),    
            order.getShippingAddress()   
        );
    }

    @Override
    public void deleteOrder(Order order) {
        String sql = "DELETE FROM exp4_order WHERE oId = ?";
        template.update(sql, order.getOid());
    }

    @Override
public List<Order> findByUid(int uId) {
    try {
        // 1. 查询所有主订单
        String orderSql = "SELECT * FROM exp4_order WHERE uId = ? ORDER BY orderTime DESC";
        List<Order> orderList = template.query(orderSql, new BeanPropertyRowMapper<>(Order.class), uId);
        
        if (orderList == null || orderList.isEmpty()) {
            return orderList;
        }

        // 2. 查询明细和商品信息
        String itemSql = "SELECT od.*, p.* FROM exp4_order_detail od " +
                         "JOIN exp4_product p ON od.pId = p.pId " +
                         "WHERE od.oId = ?";

        for (Order order : orderList) {
            // 【核心修改】：使用自定义的 OrderDetailRowMapper 组装数据
            List<OrderDetail> items = template.query(itemSql, new OrderDetailRowMapper(), order.getOid());
            order.setItems(items);
        }
        
        return orderList;
        
    } catch (Exception e) {
        e.printStackTrace();
        return null;
    }
}

/**
 * 自定义 RowMapper：专门负责组装 OrderDetail 和它内部的 Product 对象
 */
private static class OrderDetailRowMapper implements org.springframework.jdbc.core.RowMapper<OrderDetail> {
    @Override
    public OrderDetail mapRow(ResultSet rs, int rowNum) throws SQLException {
        OrderDetail item = new OrderDetail();
        // 组装订单明细
        item.setOdId(rs.getInt("odId"));
        item.setCount(rs.getInt("count"));
        item.setSubTotal(rs.getBigDecimal("subTotal").doubleValue());

        
        // 组装商品对象
        Product product = new Product();
        product.setId(rs.getInt("pId"));       // 数据库是 pId，赋给实体类的 id
        product.setName(rs.getString("pName")); // 数据库是 pName，赋给实体类的 name
        product.setImg(rs.getString("pImg"));   // 数据库是 pImg，赋给实体类的 img
        product.setPrice(rs.getBigDecimal("price"));
        
        System.out.println(">>> RowMapper: 从数据库取出的 pId = " + rs.getInt("pId"));
        System.out.println(">>> RowMapper: 赋值后 product.getId() = " + product.getId());

        item.setProduct(product);
        
        return item;
    }
}


    @Override
    public void updateStatusToPaid(String oId) {
        String sql = "UPDATE exp4_order SET status = 1 WHERE oId = ?";
        template.update(sql, oId);
    }

    @Override
    public void updateStatusToCancelled(String oId) {
        String sql = "UPDATE exp4_order SET status = 5 WHERE oId = ?";
        template.update(sql, oId);
    }

    // ================= 改正后的通用方法 =================

    @Override
    public Order findByOid(String oid) {
        try {
            String sql = "SELECT * FROM exp4_order WHERE oId = ?";
            // 使用 JdbcTemplate 配合 BeanPropertyRowMapper 自动映射实体类
            return template.queryForObject(sql, new BeanPropertyRowMapper<>(Order.class), oid);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public int updateState(String oid, int status) {
        try {
            String sql = "UPDATE exp4_order SET status = ? WHERE oId = ?";
            // 执行更新并返回受影响的行数
            return template.update(sql, status, oid);
        } catch (Exception e) {
            e.printStackTrace();
            return 0;
        }
    }
}
