package dao;

import domain.OrderDetail;
import java.util.List;

public interface OrderDetailDao {
    /**
     * 根据订单号，查询该订单下的所有商品明细
     */
    List<OrderDetail> findByOrderId(String oId);

    /**
     * 向数据库插入一条订单明细记录
     */
    void add(OrderDetail detail);
    void deleteById(String oId);
}