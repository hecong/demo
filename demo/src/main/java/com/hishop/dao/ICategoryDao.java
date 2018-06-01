package com.hishop.dao;

import java.util.List;

import com.hishop.entity.Category;

public interface ICategoryDao {
    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    int deleteByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    int insert(Category record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    int insertSelective(Category record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    Category selectByPrimaryKey(Integer id);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    int updateByPrimaryKeySelective(Category record);

    /**
     * This method was generated by MyBatis Generator.
     * This method corresponds to the database table category
     *
     * @mbggenerated Tue May 22 15:51:20 CST 2018
     */
    int updateByPrimaryKey(Category record);

    /**
     * 获取该节点下所有分类
     * @param parentid
     * @return
     */
	List<Category> selectAllCategory(String parentid);
}