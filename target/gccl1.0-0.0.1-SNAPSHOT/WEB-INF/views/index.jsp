<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/18
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>工程测量质量管理信息系统</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/BootSideMenu.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <!-- 自定义样式 -->
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!--悬浮抽拉样式-->
    <script src="js/jquery-1.11.3.min.js"></script>
    <script type="text/javascript" src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/BootSideMenu.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <style>
        body {
            background: #f5f5f5;
        }

    </style>

</head>
<body style="overflow-x: hidden; ">

<div class="container" style="margin:0px 0px;padding:0px 0px;width:100%;">
    <div class="row" style="margin:0px 0px; padding:0px 0px;">
        <%--上方页面--%>
        <nav class=" " >
                <div class="container-fluid bg-primary" style="background-color:#003366">
                    <div class="navbar-header">
                        <h4 class="" style="font-size: 25px; padding: 15px 15px"><span>工程测量质量管理信息系统</span></h4>
                    </div>
                    <div id="navbar" class="navbar-collapse collapse">
                        <ul class="nav navbar-nav navbar-right margin-top_30">
                            <li><span onclick="userinfo_click()" style="cursor:pointer;">
                                <img src="img/user.jpg" class="img-circle img-20">&nbsp;用户信息&nbsp;&nbsp;&nbsp;</span>
                            </li>
                            <li><span onclick="message()" style="cursor:pointer;" data-toggle="dropdown" class="dropdown-toggle"><i class="glyphicon glyphicon-bell"></i>&nbsp;消息通知&nbsp;<span class=" label orange-bg pull-right" id="messagecount"></span>&nbsp;&nbsp;</span></li>

                            <li><span onclick="window.location.href='login'" style="cursor:pointer;"><i class="glyphicon glyphicon-off"></i>&nbsp;退出系统</span></li>
                        </ul>
                    </div>
                </div>
            </nav>
        <%--下方页面--%>
        <div class="row" style="background:#f5f5f5;margin-bottom:5px;">
            <!-- 创建菜单树 ，左侧菜单栏-->
            <div class="col-md-2" id="ld" style="padding-right:0px;">
                <div id="ld5" class="panel-body" style="height:100%;overflow-y: auto;padding:10px 0px;">
                    <div id="ld3" class="panel-body" style="border:1px solid #ccc;width:90%;float:left;padding:0px 0px;height:100%;background:white;">
                        <ul id="main-nav" class="nav nav-tabs nav-stacked">
                            <li class="active" d_id="0" ><a style="cursor:pointer;" href="javascript:void(0)" onclick="tiaozhuan('Home_page')"><i class="glyphicon glyphicon-th-large"></i>&nbsp;首页</a></li>
                            <li d_id="1"><a href="#systemSetting" class="nav-header collapsed" data-toggle="collapse"><i class="glyphicon glyphicon-cog"></i>&nbsp;工程管理<span class="pull-right glyphicon glyphicon-chevron-down"></span></a>
                                <ul id="systemSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                    <li><a href="javascript:tiaozhuan('New_project')"><i class="glyphicon glyphicon-user"></i>&nbsp;新建工程</a></li>
                                    <li><a href="javascript:tiaozhuan('project_maintenance')"><i class="glyphicon glyphicon-th-list"></i>&nbsp;工程维护</a></li>
                                    <li><a href="javascript:tiaozhuan('Project_Query')"><i class="glyphicon glyphicon-asterisk"></i>&nbsp;工程查询</a></li>
                                </ul>
                            </li>
                            <li d_id="2"><a href="#jiance" data-toggle="collapse"><i class="glyphicon glyphicon-credit-card"></i>&nbsp;监测管理 <span class="pull-right glyphicon glyphicon-chevron-down"></span></a>
                                <ul id="jiance" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                    <li><a href="javascript:tiaozhuan('Production_report')"><i class="glyphicon glyphicon-globe"></i>&nbsp;监测上报</a></li>
                                    <li><a href="javascript:tiaozhuan('unqualified')"><i class="glyphicon glyphicon-globe"></i>&nbsp;上报反馈</a></li>
                                </ul>
                            </li>
                            <li d_id="3"><a href="#zhiliang" data-toggle="collapse"><i class="glyphicon glyphicon-globe"></i>&nbsp;质量管理<span class="pull-right glyphicon glyphicon-chevron-down"></span></a>
                                <ul id="zhiliang" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                    <li><a href="javascript:tiaozhuan('Quality_testing')"><i class="glyphicon glyphicon-wrench"></i>&nbsp;质量检查</a></li>
                                    <li><a href="javascript:tiaozhuan('quality_reply')"><i class="glyphicon glyphicon-wrench"></i>&nbsp;质量反馈</a></li>
                                    <li><a href="javascript:tiaozhuan('Report_statistics')"><i class="glyphicon glyphicon-wrench"></i>&nbsp;上报统计</a></li>
                                </ul>
                            </li>
                            <li d_id="4"><a href="#xitong" data-toggle="collapse"><i class="glyphicon glyphicon-cog"></i>&nbsp;系统管理<span class="pull-right glyphicon glyphicon-chevron-down"></span></a>
                                <ul id="xitong" class="nav nav-list collapse secondmenu" style="height: 0px;">
                                    <li><a href="javascript:tiaozhuan('User_management')"><i class="glyphicon glyphicon-user"></i>&nbsp;用户</a></li>
                                    <li><a href="javascript:tiaozhuan('updateprojectnumber')"><i class="glyphicon glyphicon-pencil"></i>&nbsp;工程编号修改</a></li>
                                </ul>
                            </li>
                        </ul>
                    </div>
                    <div class="panel-body" style="width:10%;float:left;padding:130% 0px;height:100%;"><span class="glyphicon glyphicon-chevron-left" style="width:20px;height:50px;line-height:50px;background:#ffffff;border:1px solid #ccc;border-left:0px;cursor: pointer;" onclick="hidden_div()"></span></div>
                </div>
            </div>
            <div id="s1" class="col-md-2" style="width:5%;padding-right:0px;height:100%;padding-top:20%;display: none;">
                <div class="panel-body" style="width:2%;height:100%;background:blue;padding:0px 0px;"><span class="glyphicon glyphicon-chevron-right" style="width:20px;height:50px;line-height:50px;background:#ffffff;border:1px solid #ccc;border-left:0px;cursor: pointer;" onclick="hidden_div2()"></span></div>
            </div>
            <%--右侧文本导航栏--%>
            <div class="col-md-10" id="ld2" style="padding-left:0px;padding-top:20px;padding-bottom:10px;">
                <div class="embed-responsive embed-responsive-16by9" id="ld4" style="border:1px solid #ccc;">
                    <iframe id ="iframe-page-content" class="embed-responsive-item" src="Home_page" name="mains"></iframe>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script>
    //判断用户是否登录
    var s="${userName}";
    if(s==""){
        $.alert("请重新登录", "提示", function () {
            parent.location.href = "login";
        })
    }

    var s=$("#ld2").outerHeight(true);
    $("#ld").css("height",s);

    function hidden_div(){
        $('#ld').hide();
        $('#s1').show();
        $('#ld2').css("width","90%");
    }
    function hidden_div2(){
        $('#s1').hide();
        $('#ld').show();
        $('#ld2').css("width",'');
    }

    function tiaozhuan(url){
        parent.frames['mains'].location.href=url;
    }
</script>
</html>
