$(function () {
    //<!--头部-->
    var header = '<nav class=" navbar-default "><div class="container-fluid bg-primary"><div class="navbar-header"><h4 class="navbar-brand " style="font-size: 25px;">中天路通监测生产管理系统</h4></div>';
    header+='<div id="navbar" class="navbar-collapse collapse">'
    header+='  <ul class="nav navbar-nav navbar-right">'
    header+='   <li><a href="#">用户信息</a></li>'
    header+='   <li><a href="#">退出系统</a></li>'
    header+='  </ul>'
    header+='  <form class="navbar-form navbar-right">'
    header+='     <input type="text" class="form-control" placeholder="搜索">'
    header+='  </form>'
    header+=' </div>'
    header+='</div>'
    header += '</nav>';
    //<!--左侧悬浮框-->
    var dom = "";
    dom+= '<div id="demo" style="margin-top:75px">';
    dom += '<div class="row">'
    dom += '<div class="col-md-12">';
    dom += '<ul id="main-nav" class="nav nav-tabs nav-stacked" style="">';
    dom += '<li class="active" d_id="0">';
    dom += '<a href="#">';
    dom += '<i class="glyphicon glyphicon-th-large"></i>&nbsp;首页</a></li>';
    dom += '<li d_id="1"><a href="#systemSetting" class="nav-header collapsed" data-toggle="collapse">';
    dom += '<i class="glyphicon glyphicon-cog"></i>&nbsp;工程管理'
    dom += '<span class="pull-right glyphicon glyphicon-chevron-down"></span></a>';
    dom += '<ul id="systemSetting" class="nav nav-list collapse secondmenu" style="height: 0px;">';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-user"></i>&nbsp;新建工程</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;工程维护</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-asterisk"></i>&nbsp;工程查询</a></li>';
    dom += '</ul>';
    dom += '</li>';
    dom += '<li d_id="2">';
    dom += '<a href="#jiance" data-toggle="collapse">';
    dom += ' <i class="glyphicon glyphicon-credit-card"></i>&nbsp;监测管理 ';
    dom += '<span class="pull-right glyphicon glyphicon-chevron-down"></span>';
    dom += '</a>';
    dom += '<ul id="jiance" class="nav nav-list collapse secondmenu" style="height: 0px;">';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-globe"></i>&nbsp;监测上报</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;监测分析</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-asterisk"></i>&nbsp;监测预警</a></li>';
    dom += '</ul>';
    dom += '</li>';
    dom += '<li d_id="3">';
    dom += '<a href="#zhiliang" data-toggle="collapse">';
    dom += '<i class="glyphicon glyphicon-globe"></i>';
    dom += '&nbsp;质量管理';
    dom += '<span class="pull-right glyphicon glyphicon-chevron-down"></span>';
    dom += '</a>';
    dom += '<ul id="zhiliang" class="nav nav-list collapse secondmenu" style="height: 0px;">';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;质量检查</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;质量分析</a></li>';
    dom += '</ul>';
    dom += '</li>';
    dom += '<li d_id="4">';
    dom += '<a href="#xitong" data-toggle="collapse">';
    dom += ' <i class="glyphicon glyphicon-cog"></i>';
    dom += '&nbsp;系统管理';
    dom += '<span class="pull-right glyphicon glyphicon-chevron-down"></span>';
    dom += '</a>';
    dom += '<ul id="xitong" class="nav nav-list collapse secondmenu" style="height: 0px;">';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-user"></i>&nbsp;用户</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;角色</a></li>';
    dom += '<li><a href="#"><i class="glyphicon glyphicon-th-list"></i>&nbsp;权限</a></li>';
    dom += '</ul>';
    dom += '</li>';
    dom += '</ul>';
    dom += '</div>';
    dom += '</div>';
    dom += '</div></div>';
    $("body").prepend(header + dom);
    $('#demo').BootSideMenu({
        side: "left", // left or right
        autoClose: false // auto close when page loads
    });
    $("#demo .nav-stacked>li").click(function (e) {
        $("#demo .nav-stacked>li").removeClass('active')
        var index = $(e).attr("d_id");
        $("#demo .nav-stacked>li:eq("+index+")").removeClass('active')
    })
})
