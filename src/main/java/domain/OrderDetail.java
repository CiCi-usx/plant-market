package domain;

/**
 * 订单详情实体类
 * @version 2026-06-16
 */
public class OrderDetail {
    private int odId;             // 详情主键ID
    private String oid;           // 所属订单号 (改为 oid)
    private int pid;              // 商品ID (改为 pid)
    private int count;            // 购买数量
    private double subTotal;      // 商品小计

    // 业务关联属性：JSP 页面中需要点出商品图片(item.product.pImg)和名称
    private Product product;

    public OrderDetail() {}

    // Getter and Setter
    public int getOdId() { return odId; }
    public void setOdId(int odId) { this.odId = odId; }

    public String getOid() { return oid; }
    public void setOid(String oid) { this.oid = oid; }

    public int getPid() { return pid; }
    public void setPid(int pid) { this.pid = pid; }

    public int getCount() { return count; }
    public void setCount(int count) { this.count = count; }

    public double getSubTotal() { return subTotal; }
    public void setSubTotal(double subTotal) { this.subTotal = subTotal; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }
}
