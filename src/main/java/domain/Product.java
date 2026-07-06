package domain;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 对应表 exp4_product (苗木商品表)
 */
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    // 去除 p 前缀，解决 EL 表达式与 Getter 推断冲突问题
    private Integer id;
    private String name;
    private String img;
    private String description;
    private BigDecimal price;
    private String category;
    private String origin;
    private Integer stock;
    private Integer sales;
    private Date createTime;
    private Integer status;

    // 无参构造方法
    public Product() {
    }

    // 全参构造方法
    public Product(Integer id, String name, String img, String description, BigDecimal price, 
                   String category, String origin, Integer stock, Integer sales, Date createTime, Integer status) {
        this.id = id;
        this.name = name;
        this.img = img;
        this.description = description;
        this.price = price;
        this.category = category;
        this.origin = origin;
        this.stock = stock;
        this.sales = sales;
        this.createTime = createTime;
        this.status = status;
    }

    // Getter 和 Setter 方法 (注意方法名的变化)
    public Integer getId() { return id; }

    public void setId(Integer id) { this.id = id; }

    public String getName() { return name; }

    public void setName(String name) { this.name = name; }

    public String getImg() { return img; }

    public void setImg(String img) { this.img = img; }

    public String getDescription() { return description; }

    public void setDescription(String description) { this.description = description; }

    public BigDecimal getPrice() { return price; }

    public void setPrice(BigDecimal price) { this.price = price; }

    public String getCategory() { return category; }

    public void setCategory(String category) { this.category = category; }

    public String getOrigin() { return origin; }

    public void setOrigin(String origin) { this.origin = origin; }

    public Integer getStock() { return stock; }

    public void setStock(Integer stock) { this.stock = stock; }

    public Integer getSales() { return sales; }

    public void setSales(Integer sales) { this.sales = sales; }

    public Date getCreateTime() { return createTime; }

    public void setCreateTime(Date createTime) { this.createTime = createTime; }

    public Integer getStatus() { return status; }

    public void setStatus(Integer status) { this.status = status; }

    // toString 方法
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", img='" + img + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", category='" + category + '\'' +
                ", origin='" + origin + '\'' +
                ", stock=" + stock +
                ", sales=" + sales +
                ", createTime=" + createTime +
                ", status=" + status +
                '}';
    }
}
