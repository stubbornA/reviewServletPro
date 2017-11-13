<%@ page import="com.lyf.service.UserServiceImp" %><%--
  Created by IntelliJ IDEA.
  User: fangjiejie
  Date: 2017/11/11
  Time: 20:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<jsp:useBean id="user" class="com.lyf.vo.User"></jsp:useBean>
<%
    UserServiceImp service=new UserServiceImp();
    String username=request.getParameter("username");
    String password=request.getParameter("password");
    user.setUsername(username);
    user.setPassword(password);
    if(service.add(user)){
        %>
<script>
    alert("添加成功！");
    window.location="show.jsp";
</script>
<%
    }else{
%>
<script>
    alert("添加失败！");
    window.location="show.jsp";
</script>
<%
    }
%>
</body>
</html>
