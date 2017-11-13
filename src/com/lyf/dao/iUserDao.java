package com.lyf.dao;

import com.lyf.vo.User;

import java.util.List;

/**
 * Created by fangjiejie on 2017/11/11.
 */
public interface iUserDao {
    public boolean add(User user);
    public boolean delete(int id);
    public boolean update(User user);
    public User queryUserById(int id);
    public List<User> queryAll();
    public int OnlineUsersNumber();
}
