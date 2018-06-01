package com.hishop.service;

import java.util.List;

import com.hishop.entity.Category;
import com.hishop.entity.Goods;
import com.hishop.vo.CategoryTree;
import com.hishop.vo.TreeNode;

public interface IGoodsService {

	List<Goods> searchGoods(String goodsName, String goodsCode, Integer categoryId);
	
	
	List<TreeNode> getTreeNode(String id);
	
	List<Category> getList(String parentid);


	int deleteGoods(String id);


	List<CategoryTree> getCategoryTree(String string);


	int saveGoods(Goods goods);


	Goods selectGoods(Long id);


	int update(Goods goods);

}
