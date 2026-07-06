package dao;

import domain.CartItem;
import java.util.List;

public interface CartItemDao {
    CartItem isExisted(Integer uid, Integer pid);
    void add(CartItem item);

    /**
     * 更新购物车中已有商品的数量
     */
    void update(CartItem item);
    CartItem findById(Integer cartItemId);
    void delete(Integer cartItemId);
    void clearByUid(Integer uid);
    List<CartItem> findByUid(Integer uid);
}