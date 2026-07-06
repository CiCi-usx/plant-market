package service;

import domain.CartItem;
import domain.Product;
import java.util.List;

public interface CartItemService {
    public void addToCart(Integer uid, Product product, Integer quantity);
    public List<CartItem> getCartItems(Integer uid);
    public void deleteCartItem(Integer cartItemId);
    public void clearCart(Integer uid);
}