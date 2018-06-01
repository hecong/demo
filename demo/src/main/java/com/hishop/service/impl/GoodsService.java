package com.hishop.service.impl;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hishop.dao.ICategoryDao;
import com.hishop.dao.IGoodsDao;
import com.hishop.entity.Category;
import com.hishop.entity.Goods;
import com.hishop.service.IGoodsService;
import com.hishop.vo.CategoryTree;
import com.hishop.vo.TreeNode;

@Service
public class GoodsService implements IGoodsService {

	
	@Resource  
    private IGoodsDao goodsDao;
	
	@Resource
	private ICategoryDao categoryDao;

	@Override
	public List<Goods> searchGoods(String goodsName, String goodsCode, Integer categoryId) {
		if(categoryId != null) {
			List<Goods> result = new ArrayList<Goods>();
			String childrenCates =  goodsDao.getChildCaIds(categoryId);
			childrenCates = childrenCates.substring(1, childrenCates.length());
			List<String> childs = Arrays.asList(childrenCates.split(","));
			for (String child : childs) {
				result.addAll(goodsDao.selectGoods(goodsName,goodsCode,Integer.parseInt(child)));
			}
			return result;
		}
		return goodsDao.selectGoods(goodsName,goodsCode,categoryId);
	}

	@Override
	public List<TreeNode> getTreeNode(String id) {

        List<TreeNode> rtn =null;
        List<Category> lr=getList(id);
        if(lr!=null&&lr.size()>0)
        {
            rtn=new ArrayList<>();
            for(Category r:lr)
            {
                TreeNode tn=new TreeNode(String.valueOf(r.getId()), r.getCategoryname());
                
                System.out.println("name="+r.getCategoryname());
                //得到节点的子节点
                //递归的调用
                List<TreeNode>children=    getTreeNode(String.valueOf(r.getId()));
                
                tn.setChildren(children);
                
                rtn.add(tn);
            }
            
        }
        
        return rtn;
	}

	@Override
	public List<Category> getList(String parentid) {
		return categoryDao.selectAllCategory(parentid);
	}

	@Override
	public int deleteGoods(String id) {
		return  goodsDao.deleteByPrimaryKey(Long.valueOf(id));
	}

	@Override
	public List<CategoryTree> getCategoryTree(String id) {
		 List<CategoryTree> rtn =null;
	        List<Category> lr=getList(id);
	        if(lr!=null&&lr.size()>0)
	        {
	            rtn=new ArrayList<>();
	            for(Category r:lr)
	            {
	            	CategoryTree tn=new CategoryTree(String.valueOf(r.getId()), r.getCategoryname());
	                //得到节点的子节点
	                //递归的调用
	                List<CategoryTree> children= getCategoryTree(String.valueOf(r.getId()));
	                
	                tn.setChild(children);
	                rtn.add(tn);
	            }
	        }
	        return rtn;
	}

	@Override
	public int saveGoods(Goods goods) {
		return goodsDao.insert(goods);
	}

	@Override
	public Goods selectGoods(Long id) {
		return goodsDao.selectByPrimaryKey(id);
	}

	@Override
	public int update(Goods goods) {
		return goodsDao.updateByPrimaryKey(goods);
	}  
}
