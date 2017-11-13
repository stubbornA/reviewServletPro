<%@ page import="com.lyf.service.UserServiceImp,java.util.*" %>
<%@ page import="com.lyf.vo.User" %>
<%@ page language="java" pageEncoding="utf-8" contentType="text/html; ISO-8859-1" %>
<%@taglib prefix="ff" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head >
    <title></title>
    <meta charset="utf-8">
    <style>
        .username.ng-valid {
            background-color: lightgreen;
        }
        .username.ng-dirty.ng-invalid-required {
            background-color: red;
        }
        .username.ng-dirty.ng-invalid-minlength {
            background-color: yellow;
        }

        .email.ng-valid {
            background-color: lightgreen;
        }
        .email.ng-dirty.ng-invalid-required {
            background-color: red;
        }
        .email.ng-dirty.ng-invalid-email {
            background-color: yellow;
        }

    </style>
    <script type="text/javascript" src="js/jquery-1.11.0.js"></script>

    <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
    <link href="css/app.css" rel="stylesheet"/>
</head>
<body>
<div class="generic-container" >
    <div class="panel panel-default" >
        <div class="panel-heading">
            <jsp:useBean id="usernum" class="com.lyf.service.UserServiceImp"></jsp:useBean>
            <span class="lead">用户信息</span>
            <span class="lead">在线人数: ${usernum.OnlineUsersNumber()}</span>
            <%--<span class="lead"><%=request.getAttribute("msg")==null--%>
            <%--?"":request.getAttribute("msg").toString()%></span>--%>
               <span class="lead">${requestScope.get("msg")==null?"":requestScope.get("msg")}</span>
        </div>
        <jsp:useBean id="user" class="com.lyf.vo.User"></jsp:useBean>
        <ff:set var="user" target="${user}" value="${requestScope.user}"></ff:set>
        <%--<%--%>
            <%--String uid=request.getParameter("uid");--%>
            <%--if(uid!=null) {--%>
                <%--user = (User)request.getAttribute("user");--%>
            <%--}--%>
        <%--%>--%>
        <div class="formcontainer">
            <form  name="myForm" class="form-horizontal" id="form1" action='user' method="post">
                <div class="row">
                    <div class="form-group col-md-12">
                        <label class="col-md-2 control-lable">用户名：</label>
                        <div class="col-md-7">
                            <input type="hidden" name="action" value="${user==null?"add":"update"}" >
                            <input type="hidden" name="id"
                                   value="${user==null?"":user.getId()}" />
                            <input type="text" name="username" id="userName"
                                   value="${user==null?"":user.getUsername()}" class="username form-control input-sm" required/>
                            <div class="has-error">
                                <span id="uerror"></span>
                            </div>
                        </div>
                    </div>
                </div>


                <div class="row">
                    <div class="form-group col-md-12">
                        <label class="col-md-2 control-lable" >密码：</label>
                        <div class="col-md-7">
                            <input type="text" name="password" id="password"
                                   value="${user==null?"":user.getPassword()}"
                                   class="password form-control input-sm"
                                   placeholder=""
                                   required/>
                            <div class="has-error" >
                                <span id="perror"></span>

                            </div>
                        </div>
                    </div>
                </div>



                <div class="row">
                    <div class="form-actions floatRight">
                        <input type="submit" id="add"
                               value="提交"
                               class="btn btn-primary btn-sm"
                        >
                        <button type="button" id="rst"
                                class="btn btn-warning btn-sm">复原</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <div class="panel panel-default">
        <!-- Default panel contents -->
        <div class="panel-heading"><span class="lead">账号信息 </span></div>
        <div class="tablecontainer">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>用户名</th>
                    <th>密码</th>
                    <th width="20%">操作</th>
                </tr>
                </thead>
                <tbody>
                <%--<%--%>
                    <%--List<User> list=(List<User>) request.getAttribute("list");--%>
                    <%--Iterator<User> iterator=list.iterator();--%>
                    <%--int id=0;--%>
                    <%--while(iterator.hasNext())--%>
                    <%--{--%>
                        <%--User users=iterator.next();--%>
                <%--%>--%>
                <ff:forEach var="users" items="${requestScope.list}" varStatus="status" step="1">
                <tr>
                    <td>
                        <%--<%=++id%>--%>
                        ${status.index}
                    </td>
                    <td>
                        <%--<%=users.getUsername()%>--%>
                        ${users.getUsername()}
                    </td>
                    <td>
                        <%--<%=users.getPassword()%>--%>
                        ${users.getPassword()}
                    </td>
                    <td>
                        <a href="user?action=queryUser&uid=${users.getId()}" class="btn btn-success custom-width">编辑</a>
                        <a href="user?action=delete&id=${users.getId()}"  class="btn btn-danger custom-width">删除</a>
                    </td>
                </tr>
                </ff:forEach>
                <%--<%--%>
                    <%--}--%>
                <%--%>--%>
                </tbody>
            </table>
        </div>
    </div>
</div>


</body>
</html>