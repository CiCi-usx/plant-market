package service;

import domain.Order;
import java.util.List;

public interface OrderService {
    List<Order> findAllOrders();

    void shipOrder(String oId);

    void saveOrder(Order order);
    void deleteOrder(Order order);
    List<Order> findUserOrders(int uId);
    Order findById(String oid);
    boolean updateOrderStatus(String oid, int status);
}