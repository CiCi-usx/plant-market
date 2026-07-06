package domain;

import java.io.Serializable;

// 重构classes为category

/**
 * 对应表 exp4_category
 */
public class Category implements Serializable {
    private static final long serialVersionUID = 1L;

    private Integer cId;     // 分类ID (cId int AUTO_INCREMENT)
    private String cName;    // 分类名称 (cName VARCHAR(200))

    // 无参构造方法
    public Category() {
    }

    // 全参构造方法
    public Category(Integer cId, String cName) {
        this.cId = cId;
        this.cName = cName;
    }

    // Getter 和 Setter 方法
    public Integer getcId() {
        return cId;
    }

    public void setcId(Integer cId) {
        this.cId = cId;
    }

    public String getcName() {
        return cName;
    }

    public void setcName(String cName) {
        this.cName = cName;
    }

    // toString 方法，方便调试打印
    @Override
    public String toString() {
        return "Cagegory{" +
                "cId=" + cId +
                ", cName='" + cName + '\'' +
                '}';
    }
}