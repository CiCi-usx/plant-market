
package dao;

import domain.CartItem;

public interface ShoppingCartDao {
    /**
     * 检查某用户购物车中是否已存在某商品
     */
    CartItem isExisted(int uid, int pid);

    /**
     * 向购物车添加新商品记录
     */
    void add(CartItem item);

    /**
     * 更新购物车中已有商品的数量
     */
    void update(CartItem item);
}