package service.impl;

import dao.ProductDao;
import dao.impl.ProductDaoImpl;
import domain.Product;
import service.ProductService;

import java.util.List;

public class ProductServiceImpl implements ProductService {

    private ProductDao dao = new ProductDaoImpl();

    @Override
    public void addProduct(Product product) {
        dao.add(product);
    }

    @Override
    public List<Product> getSalesPage(int offset, int pageSize) {
        return dao.findTopSalesPage(offset, pageSize);
    }

    // 替换原有的 getFruitPage 和 getNonFruitPage
    @Override
    public List<Product> getPageByCategory(String category, int offset, int pageSize) {
        return dao.findByCategoryPage(category, offset, pageSize);
    }

    // 新增：分类统计总数
    @Override
    public int countByCategory(String category) {
        return dao.countByCategory(category);
    }

    @Override
    public List<Product> searchByName(String keyword) {
        if (keyword == null) {
            keyword = "";
        }
        return dao.searchByName(keyword.trim());
    }
}
