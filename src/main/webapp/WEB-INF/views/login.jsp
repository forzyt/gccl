<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/18
  Time: 10:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <meta name="renderer" content="webkit">
    <title>工程测量质量管理信息系统</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <!-- 自定义样式 -->
    <link href="css/custom.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <script>
        $(document).ready(function(e) {
            $(this).keydown(function (e){
                if(e.which == "13"){
                    login();//触发该事件
                }
            })
        });
        function login() {
            var result = $('#form_tj').serialize();
            if($("#nickname").val()==""||$("#Password").val()==""){
                $.alert("请输入昵称或密码！","提示")
            }else{
                var submitData=decodeURIComponent(result,true);
                var url = 'user/login';
                FuncAjax(url, submitData, function (obj) {
                    if (obj.resultCode == 0) {
                        parent.window.location.href = "index"
                    } else {
                        $.alert(obj.resultMsg);
                    }
                }, function () {
                    $.alert("请求失败");
                }, true)
            }
        }
    </script>
</head>
<body class="login">
<div>
    <div class="container">
        <div class="row " style="margin-top: 200px">
            <div class="col-sm-4"></div>
            <div class="col-sm-4  login_padding" style="background-color: rgba(271, 266, 336, 0.77);">
                    <span style="font-size: 22px; color: #3a6284; text-align: center;">工程测量质量管理信息系统
                    </span>
                <form id="form_tj" class="form-signin" style="margin-top: 20px; background-color: rgba(255,255,255,.15); margin-bottom: 20px">
                    <div class="input-group">
                        <span class="input-group-addon" id="basic-addon1">昵称&nbsp;<span class="glyphicon glyphicon-user"></span></span>
                        <input type="text" name="uName" id="nickname" class="form-control" placeholder="请输入昵称" required autofocus aria-describedby="basic-addon1">
                    </div>

                    <br />
                    <div class="input-group">
                        <span class="input-group-addon" id="Span1">密码&nbsp;<span class="glyphicon glyphicon-eye-close"></span></span>
                        <input type="password" name="pwd" id="Password" class="form-control" placeholder="请输入密码" required>
                    </div>
                    <div class="checkbox">
                        <label>
                            <input type="checkbox" value="remember-me">
                            记住密码
                        </label>
                    </div>
                    <button class="btn btn-lg btn-primary btn-block" type="button" onclick="login()">登录</button>
                </form>
            </div>
            <div class="col-sm-4"></div>

        </div>

    </div>
</div>
</body>
</html>

