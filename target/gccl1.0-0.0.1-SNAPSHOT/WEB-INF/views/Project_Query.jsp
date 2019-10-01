<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 14:52
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
    <title>工程查询</title>
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
    <script>
        $(function () {
            get_p_type(0);
            $("#Project_type_F").change(function () {
                get_p_type($(this).val(),2);
            })
            userInfo_cookie ={id:'${user.id}',uName:'${user.uName}',pwd:'${user.pwd}',issubpackage:'${user.issubpackage}',uState:'${user.uState}',uType:'${user.uType}',uTime:'${user.uTime}',uRName:'${user.uRName}'};
            if (userInfo_cookie.uName== '') {
                $.alert("请重新登录", "提示", function () {
                    parent.location.href = "login";
                })
            } else {
                setTimeout(function () {
                },500)
            }
        })
        function get_p_type(type) {
            var pType="${project.pType}";
            var pFType="${project.pFType}";
            var url = '/getPtype';
            var result = 'F_ID='+type;
            FuncAjax(url, result, function (obj) {
                if (obj.resultCode == 0) {
                    if (obj.resultOBJ != null) {
                        var str = "";
                        for (var i = 0; i < obj.resultOBJ.length; i++) {
                            if(type==0){
                                if(pFType!="" && pFType==obj.resultOBJ[i].id){
                                    str += '<option value="' + obj.resultOBJ[i].id + '" selected>' + obj.resultOBJ[i].typeName + '</option>';
                                }else{
                                    str += '<option value="' + obj.resultOBJ[i].id + '">' + obj.resultOBJ[i].typeName + '</option>';
                                }
                            }else{
                                if(pType!="" && pType==obj.resultOBJ[i].id){
                                    str += '<option value="' + obj.resultOBJ[i].id + '" selected>' + obj.resultOBJ[i].typeName + '</option>';
                                }else{
                                    str += '<option value="' + obj.resultOBJ[i].id + '">' + obj.resultOBJ[i].typeName + '</option>';
                                }
                            }
                        }
                        if (type == 0) {
                            str = '<option selected value="0">请选择工程类型</option>' + str;
                            $("#Project_type_F").html(str);
                            str = '<option selected value="0">请选择工程子类型</option>' + str;
                            $("#Project_Ttype_S").html(str);
                        } else {
                            $("#Project_Ttype_S").html(str);
                        }
                        $("#userlisttr").html(str);
                    } else {

                    }
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                //$.alert("请求失败");
            }, 0)
        }
    </script>
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-top_20 ">
    <div class=" row" style="margin-bottom:20px;">
        <div class="col-sm-3">
            <input type="text" class="form-control" id="name" placeholder="请输入工程名称">
        </div>
        <div class="col-sm-3">
            <select class="form-control" id="Project_type_F">
                <option>请选择工程类型</option>

            </select>
        </div>
        <div class="col-sm-3">
            <select class="form-control" id="Project_Ttype_S">
                <option>请选择工程子类型</option>

            </select>
        </div>
        <button class="btn btn-default" id="btn_query">查询</button>
    </div>

    <table id="tb_departments" style="table-layout:fixed" class="table table-bordered table-hover text-center">

    </table>
</div>
</body>
<script>
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
                url: '/getLikeProject', //请求后台的URL（*）
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
                        field: 'pType',
                        title: '工程类型',
                        formatter:xxFormatter,
                    },{
                        field: 'pProgress',
                        title: '工程进度',
                        formatter:zzFormatter,
                    },{
                        field:'ID',
                        title: '操作',
                        width: 120,
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
        //结束时间栏格式化
        function zzFormatter(value, row, index) {
            if(row.pProgress=='null'){
                return "<span class=\"label label-danger\">未上传进度</span>"
            }
            return (row.pProgress == null ? "<span class=\"label label-danger\">未上传进度</span>" : row.pProgress);
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
    //查看按钮
    function chakan(i,s){
        parent.frames['mains'].location.href='showCheckproject?pNumber='+i+"&page="+s+"&option=2";
    }
    //(2)关键字检索
    $("#btn_query").click(function () {
        //点击查询是 使用刷新 处理刷新参数
        var opt = {
            url: "getLikeProject",
            silent: true,
            query: {
                pName: $("#name").val(),
                pFType:$("#Project_type_F").val(),
                pType:$("#Project_Ttype_S").val()
            }
        };
        $('#tb_departments').bootstrapTable('refresh', opt);

    });

</script>
</html>

