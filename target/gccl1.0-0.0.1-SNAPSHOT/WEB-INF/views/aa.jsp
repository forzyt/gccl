<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="<%=basePath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <script src="js/jquery-1.11.3.min.js"></script>
</head>
<body>

<h1>Hello!!! Congratulations on you login success </h1>

<label>${sessionScope.username}</label>


<form id="up_wendang" surl="" class="file" eenctype="multipart/form-data">
    <input type="file" id="idCard" style="display: inline-block;" name="file" multiple="multiple" />选择
</form>


</body>
<script>
    var json = {
        "aaa":{"user_name":"aaa",
            "user_role_id":1},
        "bbb":{"username":"bbb",
            "userroleid":2}

    };
    //JQuery Ajax请求
    $.post("testPro",
        json,
        function(data){

        },
        'json'
    );
</script>
</html>
