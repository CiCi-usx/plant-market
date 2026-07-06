package domain;

import java.util.Date;
import java.util.List;

/**
 * 订单实体类
 * @version 2026-06-16
 */
public class Order {
    private String oid;                // 订单号 (改为 oid)
    private int uid;                   // 用户ID (改为 uid)
    private double total;              // 总金额
    private int status;                // 状态：0待支付，1待发货，2已发货，3待评价，4已评价
    private Date orderTime;            // 下单时间
    private Date shipTime;             // 发货时间

    // 新增：配送与物流追溯字段
    private String receiverName;       // 收货人姓名
    private String receiverPhone;      // 收货人联系电话
    private String shippingAddress;    // 详细收货地址
    private String originAddress;      // 发货源产地

    private List<OrderDetail> items;   // 订单包含的明细集合

    // 无参构造
    public Order() {}

    // Getter and Setter
    public String getOid() { return oid; }
    public void setOid(String oid) { this.oid = oid; }

    public int getUid() { return uid; }
    public void setUid(int uid) { this.uid = uid; }

    public double getTotal() { return total; }
    public void setTotal(double total) { this.total = total; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }

    public Date getOrderTime() { return orderTime; }
    public void setOrderTime(Date orderTime) { this.orderTime = orderTime; }

    public Date getShipTime() { return shipTime; }
    public void setShipTime(Date shipTime) { this.shipTime = shipTime; }

    public String getReceiverName() { return receiverName; }
    public void setReceiverName(String receiverName) { this.receiverName = receiverName; }

    public String getReceiverPhone() { return receiverPhone; }
    public void setReceiverPhone(String receiverPhone) { this.receiverPhone = receiverPhone; }

    public String getShippingAddress() { return shippingAddress; }
    public void setShippingAddress(String shippingAddress) { this.shippingAddress = shippingAddress; }

    public String getOriginAddress() { return originAddress; }
    public void setOriginAddress(String originAddress) { this.originAddress = originAddress; }

    public List<OrderDetail> getItems() { return items; }
    public void setItems(List<OrderDetail> items) { this.items = items; }
}
