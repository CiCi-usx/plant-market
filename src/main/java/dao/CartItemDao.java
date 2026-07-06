package dao;

import domain.CartItem;

public interface CartItemDao {
    /**
     * 检查某用户购物车中是否已存在某商品
     */
    CartItem isExisted(Integer uid, Integer pid);

    /**
     * 向购物车添加新商品记录
     */
    void add(CartItem item);

    /**
     * 更新购物车中已有商品的数量
     */
    void update(CartItem item);
    CartItem findById(Integer cartItemId);
    void delete(Integer cartItemId);
    void clearByUid(Integer uid);
}