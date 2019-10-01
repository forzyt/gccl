<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/18
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>首页</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/BootSideMenu.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!-- 自定义样式 -->
    <!--悬浮抽拉样式-->
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>
    <!--    <script src="js/BootSideMenu.js"></script>-->
    <!--悬浮抽拉js-->
    <%-- <script>
         var userInfo_cookie = null;
         var typeshow = GetQueryString('type') == null ? 0 : GetQueryString('type');
         $(function () {
             userInfo_cookie = eval('(' + getCookie('USERINFO') + ')');
             if (userInfo_cookie == null) {
                /* $.alert("请重新登录", "提示", function () {
                     location.href = "login.html";
                 })*/
             } else {
                 if (userInfo_cookie.U_TYPE == 1) {
                     getproject(0, 2, 1)
                     getproject_checked(0, 1);
                 } else {
                     getproject(userInfo_cookie.ID, 1, 1)
                     getproject_checked(userInfo_cookie.ID, 1)
                 }
             }
             $('#homepageTab a:eq(' + typeshow + ')').tab('show');
             $('#homepageTab a').click(function (e) {
                 e.preventDefault();
                 $(this).tab('show');
             })
             $.showLoading("请稍等");
             setTimeout(function () {
                 $.hideLoading();
             }, 1000)

         })
         var row_count = 5//最多显示5页
         function paging(index, pagecount, onclick, recordcount) {
             var str = '<ul class="pagination" style="margin: 0px 0px;">';
             var plus = (Math.ceil(index / row_count) - 1) * row_count
             if (plus != 0) {
                 str += '<li><a  onclick="' + onclick + '(' + (plus) + ')">&laquo;</a></li>';
             }
             var count = 0;
             for (var i = 1; i <= row_count; i++) {
                 var temp = i + plus;
                 if (temp > pagecount)
                     continue;
                 count++;
                 if (temp == index) {
                     str += '<li class="active"><a  onclick="' + onclick + '(' + temp + ')">' + temp + '</a></li>';
                 } else {
                     str += '<li><a onclick="' + onclick + '(' + temp + ')">' + temp + '</a></li>';
                 }
             }
             if (count == row_count && (pagecount != (plus + count))) {
                 if (plus <= (pagecount - 1)) {
                     str += '<li><a  onclick="' + onclick + '(' + ((plus + 1) + count) + ')">&raquo;</a></li>';
                 }
             }
             str += '<li class="pull-left" style="margin:7px">共' + pagecount + ' 页' + recordcount + '条</li>'
             str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="' + onclick + '"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(\'' + onclick + '\',' + pagecount + ')">跳转</button></li>'
             str += '</ul>';
             return str;
         }
         function Jump(onclick,maxcount) {
             var page = parseInt($("#"+onclick+"").val());
             if (isNaN(page) || page < 1 || page > maxcount) {
                 onclick += "(1)";
             } else {
                 onclick +="(" + page + ")";
             }
             eval(onclick);
         }
         function pageshow(index) {
             if (userInfo_cookie.U_TYPE == 1) {
                 getproject(0, 2, index)
             } else {
                 getproject(userInfo_cookie.ID, 1, index)
             }
         }
         function pageshow2(index) {
             if (userInfo_cookie.U_TYPE == 1) {
                 getproject_checked(0, index)
             } else {
                 getproject_checked(userInfo_cookie.ID, index)
             }
         }
         var projectlist = null;
         var RecordCount = 10;
         function getproject(uid, state, index) {
             var url = 'user/Getprojectbyid';
             var restlt = '{"U_ID":' + uid + ',"C_STATE":' + state + ',"ID":' + index + ',"PID":' + RecordCount + '}';
             FuncAjax(url, restlt, function (obj) {
                 if (obj.ResultCode == 0) {
                     projectlist = null;
                     if (obj.ResultOBJ != null) {
                         projectlist = obj.ResultOBJ.list;
                         nowproject(projectlist);
                         $("#page").html(paging(index, obj.ResultOBJ.pageCount, "pageshow", obj.ResultOBJ.RecordCount));

                     } else {

                     }
                 } else {
                     $.alert(obj.ResultMsg);
                 }
             }, function (obj) {
                 $.alert("请求失败");

             })
         }
         var projectcheckedlist = null;
         function getproject_checked(uid, index) {
             var url = 'user/getmessagebyuid';
             var restlt = '{"ID":' + uid + ',"T_ID":' + index + ',"U_ID":' + RecordCount + '}';
             FuncAjax(url, restlt, function (obj) {
                 if (obj.ResultCode == 0) {
                     projectlist = null;
                     if (obj.ResultOBJ != null) {
                         projectcheckedlist = obj.ResultOBJ.list;
                         projectcheck(projectcheckedlist);
                         $("#pagelist").html(paging(index, obj.ResultOBJ.pageCount, "pageshow2", obj.ResultOBJ.RecordCount));
                     } else {

                     }
                 } else {
                     $.alert(obj.ResultMsg);
                 }
             }, function (obj) {
                 $.alert("请求失败");

             })
         }
         function check(pid, c_id, ps_id) {
             window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id' + ps_id;
         }
         function projectcheck(list) {
             list.sort(function (a, b) {
                 return b.PC_STATE - a.PC_STATE;
             })
             var str = "";
             for (var i = 0; i < list.length; i++) {
                 var temstr = "";
                 if (list[i].FRACTION < 60) {
                     temstr = ' class="danger"'
                 }
                 var fenshu = list[i].FRACTION
                 if (list[i].PC_STATE == 3 || list[i].PC_STATE == 2) {
                     fenshu = "已打回"
                 }
                 str += '<tr ' + temstr + '>';
                 str += '<td style="width:400px">' + list[i].P_NAME + '</td>';
                 str += '<td>' + list[i].P_CAPTAIN + '</td>';
                 str += '<td>' + list[i].U_R_NAME + '</td>';
                 str += ' <td>' + dateFormat(list[i].C_TIME, "yyyy-MM-dd") + '</td>';
                 str += '<td>' + fenshu + '</td>';
                 str += '<td><button type="button" class="btn btn-primary btn-sm" onclick="check(' + list[i].R_ID + ',' + list[i].ID + ',' + list[i].PS_ID + ')" >查看</button></td>';
                 str += '</tr>';
             }
             if (str == "") {
                 str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>'
             }
             $("#project_checked").html(str);
         }
         function nowproject(list) {
             var str = "";
             for (var i = 0; i < list.length; i++) {

                 str += '<tr>';
                 str += '<td style="width:400px">' + list[i].P_NAME + '</td>';
                 str += '<td>' + list[i].P_CAPTAIN + '</td>';
                 str += ' <td style="width:200px">' + (list[i].P_PROGRESS == null ? "未上传进度" : list[i].P_PROGRESS) + '</td>';
                 str += '<td>' + (list[i].P_STATE == 0 ? "赶工中" : "结束") + '</td>';
                 str += '<td>';
                 str += '<button type="button" class="btn btn-primary btn-sm" onclick="chakan(\'' + list[i].P_NUMBER + '\')">查看</button>';
                 str += '     </td>';
                 str += '  </tr>';
             }
             if (str == "") {
                 str = '<tr><td colspan="5"><h5>暂无数据</h5></td></tr>'
             }
             $("#project_list").html(str)
         }
         function chakan(id) {
             window.location.href = 'checkproject.html?index=' + id
         }
     </script>--%>
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-top_20 ">
    <div class="form-group has-primary" style="border-bottom: 1px solid #d6e9c6;">
        <ul class="nav  nav-pills" id="homepageTab">
            <li id="x" class="active "><a href="#" onclick="xx()" class="text-primary">在施工程</a></li>
            <li id="z"><a href="#" onclick="zz()" class="text-primary">质量通报</a></li>
        </ul>

        <div class="tab-content has-primary margin-top_20" style="text-align: center">
            <div class="tab-pane active list-group " id="engineering">
                <div class="row text-center">
                    <div class="col-sm-12 ">
                        <table id="tb_departments" style="table-layout:fixed"></table>
                    </div>
                    <div class="text-center" id="page">
                    </div>
                </div>
            </div>
            <div class="tab-pane active list-group " id="quality_bulletin">
                <div class="row ">
                    <div class="col-sm-12">
                        <table id="tb_department" style=""></table>
                    </div>
                    <div class="text-center" id="pagelist">
                    </div>
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
            window.location.href = "login";
        })
    }
    //初始化质量通报
    $("#quality_bulletin").hide();

    //(1)初始化在施工程
    $(function () {
        var oTable = new TableInit();
        oTable.Init();
    });
    var TableInit = function () {
        var pagenumber='${pages}';
        var s=1;
        if(pagenumber!=""){
            s=pagenumber;
        }
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#tb_departments').bootstrapTable({
                contentType: "application/x-www-form-urlencoded",
                url: '/getProject', //请求后台的URL（*）
                method: 'get', //请求方式（*）
                //toolbar: '#toolbar', //工具按钮用哪个容器
                striped: false, //是否显示行间隔色
                cache: true, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                sortable: false, //是否启用排序
                sortOrder: "asc", //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: s, //初始化加载第一页，默认第一页
                pageSize: 10, //每页的记录行数（*）
                pageList: [10, 25, 50, 100], //可供选择的每页的行数（*）
                clickToSelect: true, //是否启用点击选中行
                //height: ld3, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "id", //每一行的唯一标识，一般为主键列
                columns: [
                    {
                        field: 'pName',
                        title: '名称',
                    },{
                        field: 'pCaptain',
                        title: '负责人',
                    },{
                        field: 'pProgress',
                        title: '进度',
                        formatter: aaFormatter
                    },{
                        field: 'pState',
                        title: '状态',
                        formatter: zzFormatter
                    },{
                        field:'ID',
                        title: '操作',
                        align: 'center',
                        valign: 'middle',
                        formatter: actionFormatter
                    }],
                onLoadSuccess: function (data) {  //加载成功时执行
                    if(pagenumber!=""){
                        $(".pagination li:eq('"+pagenumber+"')").addClass("active");
                    }
                    var s=$('#tb_departments').bootstrapTable('getOptions').pageNumber;
                    if(pagenumber!=s){
                        $(".pagination li:eq('"+pagenumber+"')").removeClass("active");
                    }
                }
            });
        };

        //操作栏的格式化
        function actionFormatter(value, row, index) {
            var s=$('#tb_departments').bootstrapTable('getOptions').pageNumber;
            return "<span onclick=\"chakan('" + row.pNumber + "','"+s+"')\" class='label label-primary' style='cursor:pointer;padding:5px 30px;'>查看</span>"
        }

        //操作栏的格式化
        function zzFormatter(value, row, index) {
            return (row.pState == 0 ? "赶工中" : "结束");
        }

        //操作栏的格式化
        function aaFormatter(value, row, index) {
            if(row.pProgress=='null'){
                return "<span class=\"label label-danger\">未上传进度</span>"
            }
            return (row.pProgress == null ? "<span class=\"label label-danger\">未上传进度</span>" : row.pProgress);
        }

        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = {
                rows: params.limit,                         //页面大小
                page: (params.offset / params.limit) + 1,   //页码
                sort: params.sort,      //排序列名
                sortOrder: params.order //排位命令（desc，asc）
            };
            return temp;
        };
        return oTableInit;
    };

    //(1)初始化质量通报
    $(function () {
        var oTable = new TableInits();
        oTable.Init();
    });
    var TableInits = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#tb_department').bootstrapTable({
                contentType: "application/x-www-form-urlencoded",
                url: '/getProcess', //请求后台的URL（*）
                method: 'post', //请求方式（*）
                striped: false, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                sortable: false, //是否启用排序
                sortOrder: "asc", //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
                //height: 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "id", //每一行的唯一标识，一般为主键列
                paginationDetailHAlign:"right",
                columns: [{
                    field: 'pName',
                    title: '工程名称',
                },{
                    field: 'pCaptain',
                    title: '负责人',
                },{
                    field: 'uName',
                    title: '质量检查人',

                },{
                    field: 'cTime',
                    title: '最新检查时间',

                },{
                    field: 'fraction',
                    title: '分数',

                },{
                    field:'ID',
                    title: '操作',
                    align: 'center',
                    valign: 'middle',
                    formatter: actionsFormatter
                }],
            });
        };

        //操作栏的格式化
        function actionsFormatter(value, row, index) {
            var i=row.id;
            return "<span onclick='chakan2("+i+")' class='label label-primary' style='cursor:pointer;padding:5px 30px;'>查看</span>"
        }
        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                rows: params.limit,                         //页面大小
                page: (params.offset / params.limit) + 1,   //页码
                sort: params.sort,      //排序列名
                sortOrder: params.order //排位命令（desc，asc）
            };
            return temp;
        };
        return oTableInit;
    };

    //查看按钮
    function chakan(i,j){
        parent.frames['mains'].location.href='showCheckproject?pNumber='+i+"&page="+j+"&option=1";
    }
    //查看按钮
    function chakan2(i){
        alert(i);
        parent.frames['mains'].location.href='Inspect';
    }
    //质量通报按钮
    function zz(){
        $("#engineering").hide();
        $("#quality_bulletin").show();
        $("#z").attr("class","active");
        $("#x").attr("class","");
    }
    //在施工程按钮
    function xx(){
        $("#quality_bulletin").hide();
        $("#engineering").show();
        $("#x").attr("class","active");
        $("#z").attr("class","");
    }
</script>
</html>

