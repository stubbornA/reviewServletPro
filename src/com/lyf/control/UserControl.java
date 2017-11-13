package com.lyf.control;

import com.lyf.service.UserServiceImp;
import com.lyf.vo.User;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by fangjiejie on 2017/11/13.
 */
@WebServlet(
        name="usercontrol",
        urlPatterns = {"/user"},
        initParams = {
                @WebInitParam(name="show",value = "/show.jsp"),
                @WebInitParam(name="index",value = "/index.jsp")
        }
)
public class UserControl extends HttpServlet{
    private UserServiceImp service=new UserServiceImp();
    private Map<String,String> map=new HashMap<>();
    public UserControl() {
        super();
    }

    @Override
    public void init(ServletConfig config) throws ServletException {
        map.put("show",config.getInitParameter("show"));
        map.put("index",config.getInitParameter("index"));
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        this.doPost(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action=req.getParameter("action");
        String page=map.get("show");
         switch (action){
             case "queryAll":queryAll(req);break;
             case "add":{add(req);queryAll(req);break;}
             case "update":{update(req);queryAll(req);break;}
             case "delete":{delete(req);queryAll(req);break;}
             case "queryUser":{queryUser(req);queryAll(req);break;}
             default:break;
         }
        RequestDispatcher requestDispatcher=req.getRequestDispatcher(page);
        requestDispatcher.forward(req,resp);
    }

    private void queryUser(HttpServletRequest req) {
        String uid=req.getParameter("uid");
        User user=service.queryUserById(Integer.parseInt(uid));
        req.setAttribute("user",user);
    }

    private void queryAll(HttpServletRequest req) {
        List<User> list=service.queryAll();
        req.setAttribute("list",list);
    }

    private void delete(HttpServletRequest request) {
        String id=request.getParameter("id");
        UserServiceImp serviceImp=new UserServiceImp();
        boolean flag=serviceImp.delete(Integer.parseInt(id));
        if(flag){
            request.setAttribute("msg","删除成功！");
        }else{
            request.setAttribute("msg","删除失败！");
        }
    }

    private void update(HttpServletRequest req) throws UnsupportedEncodingException {
        String id=req.getParameter("id");
        if(id!="") {
//            String un=new String(req.getParameter("username").toString().getBytes("ISO8859-1"),"utf-8");
//            String ps=new String(req.getParameter("password").toString().getBytes("ISO8859-1"),"utf-8");
            String un=req.getParameter("username").toString();
            String ps=req.getParameter("password").toString();
            UserServiceImp serviceImp = new UserServiceImp();
            User user = new User();
            user.setId(Integer.parseInt(id));
            user.setUsername(un);
            user.setPassword(ps);
            boolean flag = false;
            flag = serviceImp.update(user);
            if (flag) {
                req.setAttribute("msg", "修改成功!");
            } else {
                req.setAttribute("msg", "修改失败!");
            }
        }
    }

    private void add(HttpServletRequest req) throws UnsupportedEncodingException {
        User user=new User();
//        String username=new String(req.getParameter("username").toString().getBytes("ISO8859-1"),"utf-8");
//        String password=new String(req.getParameter("password").toString().getBytes("ISO8859-1"),"utf-8");
        String username=req.getParameter("username").toString();
        String password=req.getParameter("password").toString();
        user.setUsername(username);
        user.setPassword(password);
        if(service.add(user)) {
            req.setAttribute("msg","添加成功！");
        }else{
            req.setAttribute("msg","添加失败！");
        }
    }

    @Override
    public void destroy() {
        super.destroy();
    }
}
