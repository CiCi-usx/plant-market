package dao;

import domain.Order;
import java.util.List;

public interface OrderDao {
    List<Order> findAll();
    
    void updateStatusToShipped(String oId);

    void addOrder(Order order);

    void deleteOrder(Order order);

    List<Order> findByUid(int uId);
    
    void updateStatusToPaid(String oId);

    void updateStatusToCancelled(String oId);

    Order findByOid(String oid);

    /**
     * 修改订单状态 (通用方法)
     * @param oid 订单ID
     * @param status 要修改的目标状态
     * @return 受影响的行数
     */
    int updateState(String oid, int status);
}
