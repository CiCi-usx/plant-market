package service.impl;

import dao.OrderDao;
import dao.OrderDetailDao;
import dao.impl.OrderDaoImpl;
import dao.impl.OrderDetailDaoImpl;
import domain.Order;
import domain.OrderDetail;
import service.OrderService;
import java.util.List;

public class OrderServiceImpl implements OrderService {

    // 引入依赖的两个 DAO 实体者
    private OrderDao orderDao = new OrderDaoImpl();
    private OrderDetailDao orderDetailDao = new OrderDetailDaoImpl();

    @Override
    public List<Order> findAllOrders() {
        // 1. 捞出所有的订单主记录（含订单号、总金额、收货人、地址等基础数据）
        List<Order> orders = orderDao.findAll();
        
        // 2. 核心拼装：遍历每一个订单，通过订单号将其对应的明细商品列表抓取出来，组合成完整对象
        if (orders != null) {
            for (Order order : orders) {
                // 根据主表里的 oId 去详情表里查关联的商品明细
                List<OrderDetail> items = orderDetailDao.findByOrderId(order.getOid());
                // 将明细集合封装进主表对象的 items 属性中
                order.setItems(items);
            }
        }
        return orders;
    }

    @Override
    public void shipOrder(String oId) {
        // 直接传达发货更新指令
        orderDao.updateStatusToShipped(oId);
    }

    /**
     * 创建新订单并进行双表持久化落库
     */
    @Override
    public void saveOrder(Order order) {
        // 1. 优先将订单主表数据（含收货地址、联系人、总价等）写入 exp4_order
        orderDao.addOrder(order);

        // 2. 健壮性校验：如果没有任何商品明细，则直接拦截，防止空指针
        if (order.getItems() == null || order.getItems().isEmpty()) {
            return;
        }

        // 3. 循环遍历购物车拆解出的明细列表，逐条钉进 exp4_order_detail
        for (OrderDetail detail : order.getItems()) {
            // 安全线：强制让明细里的订单外键（oId）和刚刚生成的主订单号保持绝对强一致
            detail.setOid(order.getOid());
            orderDetailDao.add(detail);
        }
    }

    @Override
    public void deleteOrder(Order order) {
        // 1. 安全校验
        if (order == null || order.getOid() == null) {
            return;
        }
        
        // 2. 先删子表：删除该订单关联的所有明细记录
        orderDetailDao.deleteById(order.getOid());
        
        // 3. 再删主表：删除订单主表记录
        orderDao.deleteOrder(order);
    }

    @Override
    public List<Order> findUserOrders(int uId) {
        List<Order> orders = orderDao.findByUid(uId);
        return orders;
    }

    @Override
    public Order findById(String oid) {
        return orderDao.findByOid(oid);
    }

    @Override
    public boolean updateOrderStatus(String oid, int status) {
        return orderDao.updateState(oid, status) > 0;
    }

}