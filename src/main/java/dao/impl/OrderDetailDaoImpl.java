package dao.impl;

import dao.OrderDetailDao;
import domain.OrderDetail;
import domain.Product;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;
import java.util.List;
import java.math.BigDecimal;

public class OrderDetailDaoImpl implements OrderDetailDao {
    
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<OrderDetail> findByOrderId(String oId) {
        try {
            String sql = "SELECT * FROM exp4_order_detail WHERE oId = ?";
            List<OrderDetail> details = template.query(sql, new BeanPropertyRowMapper<>(OrderDetail.class), oId);

            if (details != null) {
                for (OrderDetail detail : details) {
                    String productSql = "SELECT * FROM exp4_product WHERE pId = ?";
                    Product product = template.queryForObject(productSql, new BeanPropertyRowMapper<>(Product.class), detail.getPid());
                    detail.setProduct(product); 
                }
            }
            return details;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

@Override
public void add(OrderDetail detail) {
    try {
        // 1. 计算小计金额：数量(int) * 单价
        // 注意：getCount()返回int，getPrice()返回BigDecimal，需要类型转换
        BigDecimal countBigDecimal = BigDecimal.valueOf(detail.getCount());
        BigDecimal price = detail.getProduct().getPrice();
        BigDecimal subTotal = price.multiply(countBigDecimal);
        
        // 2. 将计算结果设置到detail对象中
        detail.setSubTotal(subTotal.doubleValue()); // 假设setSubTotal接受double
        
        // 3. 修改SQL语句，加入subTotal字段
        String sql = "INSERT INTO exp4_order_detail(oId, pId, count, subTotal) VALUES(?, ?, ?, ?)";
        
        // 4. 执行更新，传入4个参数
        template.update(sql, detail.getOid(), detail.getPid(), detail.getCount(), detail.getSubTotal());
        
    } catch (Exception e) {
        e.printStackTrace();
    }
}


    @Override
    public void deleteById(String oId) {
        String sql = "DELETE FROM exp4_order_detail WHERE oId = ?";
        template.update(sql, oId);
    }
}