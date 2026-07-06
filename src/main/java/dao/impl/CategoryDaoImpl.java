package dao.impl;

import dao.CategoryDao;
import domain.Category;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import util.JDBCUtils;

import java.util.List;

public class CategoryDaoImpl implements CategoryDao {
    
    private JdbcTemplate template = new JdbcTemplate(JDBCUtils.getDataSource());

    @Override
    public List<Category> findAll() {       
        String sql = "select * from exp4_category";

        List<Category> category = template.query(sql, new BeanPropertyRowMapper<Category>(Category.class));

        return category;
    }

    @Override
    public String findCategoryNameById(int cId) {
        String sql = "SELECT cName FROM exp4_category WHERE cId = ?";
        return template.queryForObject(sql, String.class, cId);
    }
}