package domain;

import java.util.Date;

public class CartItem {
    private Integer cartid;   // 纯小写，对应数据库 cartid
    private int uid;          // 纯小写，对应数据库 uid
    private Product product;  // 组合商品对象，其内部包含 pid
    private int quantity;     // 对应数据库 quantity
    private Date addtime;     // 纯小写，对应数据库 addtime

    public CartItem() {}

    public CartItem(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    public Integer getCartid() { return cartid; }
    public void setCartid(Integer cartid) { this.cartid = cartid; }

    public int getUid() { return uid; }
    public void setUid(int uid) { this.uid = uid; }

    public Product getProduct() { return product; }
    public void setProduct(Product product) { this.product = product; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Date getAddtime() { return addtime; }
    public void setAddtime(Date addtime) { this.addtime = addtime; }
}