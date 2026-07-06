package service.impl;

import dao.ShoppingCartDao;
import dao.impl.ShoppingCartDaoImpl;
import domain.CartItem;
import service.ShoppingCartService;

public class ShoppingCartServiceImpl implements ShoppingCartService {
    private ShoppingCartDao dao = new ShoppingCartDaoImpl();

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