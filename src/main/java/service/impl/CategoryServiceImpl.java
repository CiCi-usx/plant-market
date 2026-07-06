package service.impl;

import domain.Category;
import service.CategoryService;
import dao.CategoryDao;
import dao.impl.CategoryDaoImpl;

import java.util.List;

public class CategoryServiceImpl implements CategoryService {
    private CategoryDao dao = new CategoryDaoImpl();

    @Override
    public List<Category> findAll() {
        return dao.findAll();
    }
}