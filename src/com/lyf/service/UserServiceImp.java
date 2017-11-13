package com.lyf.service;

import com.lyf.dao.iUserDao;
import com.lyf.db.DB;
import com.lyf.listener.OnlineListener;
import com.lyf.vo.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by fangjiejie on 2017/11/11.
 */
public class UserServiceImp implements iUserDao {
    @Override
    public int OnlineUsersNumber() {
        return OnlineListener.count;
    }

    private Connection connection;
    private PreparedStatement ps=null;

    public UserServiceImp() {
        connection= DB.getConnection();
    }

    @Override
    public boolean add(User user) {
        boolean flag=false;
        try {
            String sql="insert into user(username,psw) values(?,?)";
            ps=connection.prepareStatement(sql);
            ps.setString(1,user.getUsername());
            ps.setString(2,user.getPassword());
            flag=ps.executeUpdate()>0?true:false;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean delete(int id) {
        boolean flag=false;
        String sql="delete from user where id=?";
        try {
            ps=connection.prepareStatement(sql);
            ps.setInt(1,id);
            flag=ps.executeUpdate()>0?true:false;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public boolean update(User user) {
        boolean flag=false;
        String sql="update user set username=?,psw=? where id=?";
        try {
            ps=connection.prepareStatement(sql);
            ps.setString(1,user.getUsername());
            ps.setString(2,user.getPassword());
            ps.setInt(3,user.getId());
            flag=ps.executeUpdate()>0?true:false;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return flag;
    }

    @Override
    public User queryUserById(int id) {
        String sql="select * from user where id=?";
        ResultSet rs=null;
        List<User> list=new ArrayList<>();
        User user=null;
        try {
            ps=connection.prepareStatement(sql);
            ps.setInt(1,id);
            rs=ps.executeQuery();
            while (rs.next()){
                user=new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("psw"));
                list.add(user);
            }
            user=list.get(0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public List<User> queryAll() {
        ResultSet rs=null;
        List<User> list=new ArrayList<>();
        try {
            String sql="select * from user order by id desc";
            ps=connection.prepareStatement(sql);
            rs=ps.executeQuery();
            User user=null;
            while (rs.next()){
                user=new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("psw"));
                list.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            if(rs!=null){
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if(ps!=null){
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return list;
    }
}
