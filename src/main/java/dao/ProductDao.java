package dao;

import domain.Product;
import java.util.List;

/**
 * 商品持久层接口
 * @version 2026-06-16
 */
public interface ProductDao {

    /**
     * 添加新商品
     * @param product 包含商品信息的实体类对象
     */
    void add(Product product);

    /**
     * 修改商品信息
     * @param product 包含更新后数据和主键 id 的商品实体类对象
     */
    void edit(Product product);

    /**
     * 根据商品主键 id 查询单条商品详细信息
     * @param id 商品的主键 ID
     * @return 对应的商品对象，若未找到则返回 null
     */
    Product findById(int id);

    /**
     * 根据关键字搜索商品
     * @param keyword 搜索关键字
     * @return 匹配的商品列表
     */
    List<Product> searchByName(String keyword);

    /**
     * 查询数据库中所有的商品记录
     * @return 包含所有商品的 List 集合；若无数据则返回一个空集合
     */
    List<Product> findAll();

    /**
     * 分页查询销量最高的商品
     * @param offset 偏移量
     * @param pageSize 每页记录数
     * @return 商品列表
     */
    List<Product> findTopSalesPage(int offset, int pageSize);

    /**
     * 根据分类分页查询商品
     * @param category 商品分类
     * @param offset 偏移量
     * @param pageSize 每页记录数
     * @return 商品列表
     */
    List<Product> findByCategoryPage(String category, int offset, int pageSize);

    /**
     * 根据分类统计商品数量
     * @param category 商品分类
     * @return 该分类下的商品数量
     */
    int countByCategory(String category);

}
