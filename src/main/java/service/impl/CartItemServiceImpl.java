package service.impl;

import dao.CartItemDao;
import dao.impl.CartItemDaoImpl;
import domain.CartItem;
import domain.Product;
import java.util.List;
import service.ShoppingCartService;

public class CartItemServiceImpl implements CartItemService {
    private CartItemDao dao = new CartItemDaoImpl();

    // 添加商品到购物车（会自动判断是新增还是更新）
    @Override
    public void addToCart(Integer uid, Product product, Integer quantity) {
        CartItem item = new CartItem();
        item.setUid(uid);
        item.setProduct(product);
        item.setQuantity(quantity);
        
        // add 方法内部会自动调用 isExisted 检查
        cartItemDao.add(item);
    }
    
    // 获取用户的购物车列表
    @Override
    public List<CartItem> getCartItems(Integer uid) {
        return cartItemDao.findByUid(uid);
    }
    
    // 删除购物车项
    @Override
    public void deleteCartItem(Integer cartItemId) {
        cartItemDao.delete(cartItemId);
    }
    
    // 清空购物车
    @Override
    public void clearCart(Integer uid) {
        cartItemDao.clearByUid(uid);
    }
}