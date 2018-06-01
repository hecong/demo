package com.hishop.dao;

import com.hishop.entity.User;

public interface IUserDao {

	User selectByPrimaryKey(int userId);

}
