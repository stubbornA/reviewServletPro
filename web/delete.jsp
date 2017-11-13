<%@ page import="com.lyf.service.UserServiceImp" %><%--
  Created by IntelliJ IDEA.
  User: fangjiejie
  Date: 2017/11/12
  Time: 13:27
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
    UserServiceImp serviceImp=new UserServiceImp();
    boolean flag=serviceImp.delete(Integer.parseInt(id));
    if(flag){
        request.setAttribute("msg","删除成功！");
%>
<jsp:forward page="show.jsp"></jsp:forward>
<%
}else{
    request.setAttribute("msg","删除失败！");
%>
<jsp:forward page="show.jsp"></jsp:forward>
<%
    }
%>
</body>
</html>
