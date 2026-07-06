package dao;

import domain.Category;
import java.util.List;

public interface CategoryDao {
    public List<Category> findAll();
    public String findCategoryNameById(int cId);
}
