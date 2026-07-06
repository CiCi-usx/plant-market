package service;

import domain.Product;
import java.util.List;

public interface ProductService {

    void addProduct(Product product);

    // 改为通用的销量分页查询（如果原来就是查所有的销量，去掉 fruit/nonFruit 的区分）
    List<Product> getSalesPage(int offset, int pageSize);

    // 新增：通用的根据分类名称分页查询
    List<Product> getPageByCategory(String category, int offset, int pageSize);

    // 新增：根据分类名称统计商品总数
    int countByCategory(String category);

    List<Product> searchByName(String keyword);
}
