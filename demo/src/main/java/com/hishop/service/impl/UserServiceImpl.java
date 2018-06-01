package com.hishop.service.impl;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.hishop.dao.IUserDao;
import com.hishop.entity.User;
import com.hishop.service.IUserService;

@Service("userService")  
public class UserServiceImpl implements IUserService{

	@Resource  
    private IUserDao userDao;  
    @Override  
    public User getUserById(int userId) {  
        return this.userDao.selectByPrimaryKey(userId);  
    }

}
