<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 14:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <meta name="renderer" content="webkit">
    <title>工程维护</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>

    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-top_20 ">
    <div class="tab-content has-primary  ">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="productionlist">
                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading" >
                            <div class=" row">
                                <div class="col-sm-8 text-left"><h4 >工程维护</h4></div>
                                <div class="col-sm-3"><input type="text" class="form-control" placeholder="请输入工程名称" id="name_project" /></div><div class="col-sm-1">
                                <button class="btn btn-default" id="btn_query">查询</button></div>

                            </div>

                        </div>
                        <table id="tb_departments" style="table-layout:fixed" class="table table-bordered table-hover text-center">

                        </table>
                    </div>
                </div>
                <div class="text-center" id="page">
                </div>
            </div>
        </div>
    </div>
</div>

</body>
<script>
    //(1)初始化在施工程
    $(function () {
        userInfo_cookie ={id:'${user.id}',uName:'${user.uName}',pwd:'${user.pwd}',issubpackage:'${user.issubpackage}',uState:'${user.uState}',uType:'${user.uType}',uTime:'${user.uTime}',uRName:'${user.uRName}'};
        if (userInfo_cookie.uName== '') {
            $.alert("请重新登录", "提示", function () {
                location.href = "login";
            })
        }
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
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
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
                        field: 'pNumber',
                        title: '工程编号',
                    },{
                        field: 'pName',
                        title: '工程名称',
                    },{
                        field: 'pCaptain',
                        title: '项目负责人',
                    },{
                        field: 'pEndTime',
                        title: '结束时间',
                        formatter:zzFormatter,
                    },{
                        field: 'pType',
                        title: '工程类型',
                        formatter:xxFormatter,
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
            return "<span onclick=\"updates('" + row.pNumber + "','"+s+"')\" class='label label-primary' style='cursor:pointer;padding:5px 10px;'>编辑</span>&nbsp;&nbsp;"+"<span onclick=\"deletes('" + row.pNumber + "')\" class='label label-primary' style='cursor:pointer;padding:5px 10px;'>删除</span>"
        }
        //结束时间栏格式化
        function zzFormatter(value, row, index) {
            Date.prototype.toLocaleString = function() {
                return this.getFullYear() + "年" + (this.getMonth() + 1) + "月" + this.getDate() + "日 ";
            };
            var unixTimestamp = new Date( value ) ;
            commonTime = unixTimestamp.toLocaleString();
            return commonTime;
        }
        //工程类型栏格式化
        function xxFormatter(value, row, index) {
            var ss=["","","","","","规划测量","矿山测量","地下管线测量","控制测量","地形测量","建筑工程测量","变形与形变与精密测量","市政工程测量","线路与桥隧测量","地理信息系统工程","地理信息数据采集","地理信息数据处理","不动产测绘","房产测绘","地籍测绘",];
            return ss[value];
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
    //编辑按钮
    function updates(pNumber,j){
        location.href="updateProject?pNumber="+pNumber+"&page="+j;
    }
    //删除按钮
    function deletes(pNumber){
        //alert(pNumber);
        $.ajax({
            url:"deleteProject",
            type:"Post",
            data:{"pNumber":pNumber},
            success:function(obj){
                if(obj.resultMsg==0){
                    $.alert("删除成功！","提示",function(){
                        location.reload();
                    });
                }else{
                    $.alert("删除失败！")
                }
            },
            error:function(){
                $.alert("请求失败，请联系管理人员！")
            }
        });

    }
    //(2)关键字检索
    $("#btn_query").click(function () {
        //点击查询是 使用刷新 处理刷新参数
        var opt = {
            url: "getProject",
            silent: true,
            query: {
                pName: $("#name_project").val(),
            }
        };
        $('#tb_departments').bootstrapTable('refresh', opt);

    });

</script>
</html>

