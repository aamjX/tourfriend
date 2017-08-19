package services;

import java.util.ArrayList;
import java.util.Collection;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.Assert;

import domain.Category;
import domain.Route;
import repositories.CategoryRepository;

@Service
@Transactional
public class CategoryService {
	
	@Autowired
	private CategoryRepository categoryRepository;
	
	
	public CategoryService(){
		super();
	}
	
	public Category create(){
		Category category = new Category();
		category.setRoutes(new ArrayList<Route>());
		category.setName("");
		return category;
	}
	
	public Category findOne(int categoryId){
		Assert.notNull(categoryId);
		return categoryRepository.findOne(categoryId);
	}
	
	public Collection<Category> findAll(){
		return categoryRepository.findAll();
	}
	
	public Category save(Category category){
		return categoryRepository.saveAndFlush(category);
	}
	
	public void delete(Category category){
		categoryRepository.delete(category.getId());
	}

	public Collection<Category> searchCategory(String keyword) {
		return categoryRepository.searchCategory(keyword);
	}
	


}
