<%@ page import="com.lyf.service.UserServiceImp" %>
<%@ page import="com.lyf.vo.User" %><%--
  Created by IntelliJ IDEA.
  User: fangjiejie
  Date: 2017/11/12
  Time: 13:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
    String id=request.getParameter("id");
    if(id!=""){
    String un=request.getParameter("username");
    String ps=request.getParameter("password");
    UserServiceImp serviceImp=new UserServiceImp();
    User user=new User();
    user.setId(Integer.parseInt(id));
    user.setUsername(un);
    user.setPassword(ps);
    boolean flag=false;
    flag=serviceImp.update(user);
    if(flag){
        request.setAttribute("msg","修改成功");
        %>
    <jsp:forward page="show.jsp"></jsp:forward>
<%
    }else{
        request.setAttribute("msg","修改失败");
%>
<jsp:forward page="show.jsp"></jsp:forward>
<%
    }
    }
%>
</body>
</html>
