package service.impl;

import dao.CartItemDao;
import dao.impl.CartItemDaoImpl;
import domain.CartItem;
import service.ShoppingCartService;

public class ShoppingCartServiceImpl implements ShoppingCartService {
    private CartItemDao dao = new CartItemDaoImpl();

    @Override
    public void add(CartItem item) {
        CartItem cart = dao.isExisted(item.getUid(), item.getProduct().getId());
        if (cart == null) {
            dao.add(item);
        } else {
            cart.setQuantity(cart.getQuantity() + item.getQuantity());
            dao.update(cart);
        }
    }
}