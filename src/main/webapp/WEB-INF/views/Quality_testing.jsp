<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 15:08
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
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <meta name="renderer" content="webkit">
    <title>质量检查</title>
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
    <script>
        var RecordCount = 10;
        var userInfo_cookie = null;
        $(function () {
            userInfo_cookie = eval('(' + getCookie('USERINFO') + ')');
            if (userInfo_cookie == null) {
                /*$.alert("请重新登录", "提示", function () {
                    location.href = "login.html";
                })*/
            } else {
                if (userInfo_cookie.U_TYPE == 1) {
                    getproject(0, 2, 1);
                } else {
                    getproject(userInfo_cookie.ID, 1, 1);
                }
            }
            $.showLoading("请稍等");
            setTimeout(function () {
                $.hideLoading();
            }, 1000)
        })
        function testshow(id) {
            window.location.href = "Inspect.html?index=" + id;
        }
        var row_count = 5//最多显示5页
        function paging(index, pagecount, recordcount) {
            var str = '<ul class="pagination" style="margin: 0px 0px;">';
            var plus = (Math.ceil(index / row_count) - 1) * row_count

            if (plus != 0) {
                str += '<li><a  onclick="pageshow(' + (plus) + ')">&laquo;</a></li>';
            }
            var count = 0;
            for (var i = 1; i <= row_count; i++) {
                var temp = i + plus;
                if (temp > pagecount)
                    continue;
                count++;
                if (temp == index) {
                    str += '<li class="active"><a  onclick="pageshow(' + temp + ')">' + temp + '</a></li>';
                } else {
                    str += '<li><a onclick="pageshow(' + temp + ')">' + temp + '</a></li>';
                }
            }
            if (count == row_count && (pagecount != (plus + count))) {
                if (plus <= (pagecount - 1)) {
                    str += '<li><a  onclick="pageshow(' + ((plus + 1) + count) + ')">&raquo;</a></li>';
                }
            }
            str += '<li class="pull-left" style="margin:7px">共' + pagecount + ' 页' + recordcount + '条</li>'
            str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="jump"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(' + pagecount + ')">跳转</button></li>'
            str += '</ul>';
            $("#page").html(str);
        }
        function Jump(maxcount) {
            var page = parseInt($("#jump").val());
            if (isNaN(page) || page < 1 || page > maxcount) {
                pageshow(1);
            } else {
                pageshow(page);
            }
        }
        function pageshow(index) {
            if (userInfo_cookie.U_TYPE == 1) {
                getproject(0, 2, index)
            } else {
                getproject(userInfo_cookie.ID, 1, index)
            }
        }
        var projectlist = null;
        function getproject(uid, state, index) {
            var url = 'user/Getprojectbyid';
            var restlt = '{"U_ID":' + uid + ',"C_STATE":' + state + ',"ID":' + index + ',"PID":' + RecordCount + ',"P_NAME":"' + $("#name_project").val() + '"}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    projectlist = null;
                    if (obj.ResultOBJ != null) {
                        projectlist = obj.ResultOBJ.list;
                        projectstr(projectlist);
                        paging(index, obj.ResultOBJ.pageCount, obj.ResultOBJ.RecordCount);
                    } else {

                    }
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");

            })
        }
        function projectstr(list) {
            var str = "";
            for (var i = 0; i < list.length; i++) {
                str += '<tr><td>' + list[i].P_NUMBER + '</td><td>' + list[i].P_NAME + '</td><td>' + list[i].P_CAPTAIN + '</td>';
                str += '<td>' + list[i].TYPE_NAME + '</td><td>' + list[i].NOCHECK + '</td>';
                str += '<td><button type="button" class="btn btn-primary btn-sm" onclick="testshow(\'' + list[i].P_NUMBER + '\')">检查</button></td></tr>';
            }
            if (str == "") {
                str = '<tr><td colspan="7"><h5>暂无数据</h5></td></tr>'
            }
            $("#projectlist").html(str)
        }
        function showpage() {
            if (userInfo_cookie.U_TYPE == 1) {
                getproject(0, 2, 1);
            } else {
                getproject(userInfo_cookie.ID, 1, 1);
            }
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
<div class="container-fluid margin-top_20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="qualitylist">

                <div class="col-sm-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class=" row">
                                <div class="col-sm-8 text-left">
                                    <h4>质量检查</h4>
                                </div>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" placeholder="请输入工程编号/工程名称" id="name_project" /></div>
                                <div class="col-sm-1">
                                    <button class="btn btn-default" id="btn_query">查询</button></div>
                                </div>
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
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#tb_departments').bootstrapTable({
                contentType: "application/x-www-form-urlencoded",
                url: '/getProjectCheck', //请求后台的URL（*）
                method: 'get', //请求方式（*）
                //toolbar: '#toolbar', //工具按钮用哪个容器
                striped: false, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                sortable: false, //是否启用排序
                sortOrder: "asc", //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
                pageNumber: 1, //初始化加载第一页，默认第一页
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
                        field: 'noCheck',
                        title: '未检查数量',
                    },{
                        field:'ID',
                        title: '操作',
                        width: 120,
                        align: 'center',
                        valign: 'middle',
                        formatter: actionFormatter
                    }],
            });
        };
        //操作栏的格式化
        function actionFormatter(value, row, index) {

            return "<span onclick=\"deletes('" + row.pNumber + "')\" class='label label-primary' style='cursor:pointer;padding:5px 30px;'>检查</span>"
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
    function updates(pNumber){
        location.href="updateProject?pNumber="+pNumber;
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
            url: "getLikeProjectCheck",
            silent: true,
            query: {
                pName: $("#name_project").val(),
            }
        };
        $('#tb_departments').bootstrapTable('refresh', opt);

    });
</script>
</html>

