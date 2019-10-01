<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 15:31
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
    <script src="js/modal.js"></script>
    <script src="js/common.js"></script>
    <script>
        var RecordCount = 10;
        var userInfo_cookie = null;
        $(function () {
            $.showLoading("请稍等");
            setTimeout(function () {
                $.hideLoading();
            }, 1000)

            userInfo_cookie = eval('(' + getCookie('USERINFO') + ')');
            if (userInfo_cookie == null) {
                /*$.alert("请重新登录", "提示", function () {
                    location.href = "login.html";
                })*/
            } else {
                if (userInfo_cookie.U_TYPE == 1) {
                    getproject(0, 2, 1, "")
                } else {
                    getproject(userInfo_cookie.ID, 1, 1, "")
                }
            }
        })
        var dprojectdate = null;
        function reportshow(data) {
            modalinfo.body = '<form class="form-horizontal " role="form"><div class="form-group"><label for="firstname" style="text-align:left" class="col-sm-3 control-label">工程编号:</label><div class="col-sm-9"><input type="text" class="form-control" id="projectnumber" placeholder="请输入工程编号" value="' + data.P_NUMBER + '" id="P_NUMBER"></div></div><p class="red" id="errorp"></p></form> ';
            modalinfo.title = "编辑工程编号";
            modalinfo.footer = '<button type="button" class="btn btn-primary" onclick="eduname(\'' + data.P_NUMBER + '\')">修改</button><button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'
            modalinfo.height="100%"
            modalinfo.initial();
            modalinfo.show();
        }
        function eduname(old) {
            if ($("#projectnumber").val() == "") {
                $("#errorp").html("请填写编号");
            } else {
                var url = 'user/updateprojectnumber';
                var restlt = '{"P_NUMBER":"' + old + '","P_NAME":"' + $("#projectnumber").val() + '"}';
                FuncAjax(url, restlt, function (obj) {
                    if (obj.ResultCode == 0) {
                        if (obj.ResultOBJ) {
                            modalinfo.hide();
                            if (userInfo_cookie.U_TYPE == 1) {
                                getproject(0, 2, 1, "")
                            } else {
                                getproject(userInfo_cookie.ID, 1, 1, "")
                            }
                        } else {
                            $("#errorp").html(obj.ResultMsg);
                        }
                    } else {
                        $("#errorp").html(obj.ResultMsg);
                    }
                }, function (obj) {
                    $.alert("请求失败");

                })

            }
        }
        function listshow() {
            $("#report").hide();
            $("#productionlist").show();
        }
        function pageshow(index) {
            if (userInfo_cookie.U_TYPE == 1) {
                getproject(0, 2, index, $("#name_project").val())
            } else {
                getproject(userInfo_cookie.ID, 1, index, $("#name_project").val())
            }
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
            if (count == row_count && (pagecount % row_count != 0)) {
                if (plus <= (pagecount - 1)) {
                    str += '<li><a  onclick="pageshow(' + ((plus + 1) * row_count + 1) + ')">&raquo;</a></li>';
                }
            }
            str += '<li class="pull-left" style="margin:7px">共' + pagecount + ' 页' + recordcount + '条</li>';
            str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="jump"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(' + pagecount + ')">跳转</button></li>';
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
        var projectlist = null;
        function getproject(uid, state, index, name) {
            var url = 'user/Getprojectbypidandname';
            var restlt = '{"ID":' + uid + ',"P_STATE":' + state + ',"P_TYPE":' + index + ',"P_F_TYPE":' + RecordCount + ',"P_NAME":"' + name + '"}';
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

        function Del_project(p_id) {
            $.modal({
                title: "提示",
                text: "确定要删除该工程吗？",
                buttons: [
                    {
                        text: "取消", onClick: function () {

                        }
                    },
                    {
                        text: "确定", onClick: function () { //提交
                            var url = 'user/Del_project';
                            var restlt = '{"P_NUMBER":"' + p_id + '","U_ID":' + userInfo_cookie.ID + '}';
                            FuncAjax(url, restlt, function (obj) {
                                if (obj.ResultCode == 0) {
                                    setTimeout(function () {
                                        $.alert("删除成功", "提示", function () {
                                            if (userInfo_cookie.U_TYPE == 1) {
                                                getproject(0, 2, 1, $("#name_project").val())
                                            } else {
                                                getproject(userInfo_cookie.ID, 1, 1, $("#name_project").val())
                                            }
                                        })
                                    }, 500)




                                }
                            })
                        }
                    }
                ]
            });

        }
        function projectstr(list) {
            var str = "";
            for (var i = 0; i < list.length; i++) {
                str += '<tr><td>' + list[i].P_NUMBER + '</td><td style="width:300px">' + list[i].P_NAME + '</td><td style="width:80px">' + list[i].P_CAPTAIN + '</td>';
                str += '<td style="width:180px">' + dateFormat(list[i].P_END_TIME, "yyyy-MM-dd") + '</td><td style="width:100px">' + list[i].TYPE_NAME + '</td>';
                str += '<td><button type="button" class="btn btn-primary btn-sm btn-sm" onclick="reportshow(' + JSON.stringify(list[i]).replace(/\"/g, "'") + ')">编辑工程编号</button>&nbsp;&nbsp;<button type="button" class="btn btn-primary btn-sm btn-sm" onclick="Del_project(\'' + list[i].P_NUMBER + '\')">删除</button></td></tr>';
            }
            if (str == "") {
                str = '<tr><td colspan="8"><h5>暂无数据</h5></td></tr>'
            }
            $("#projectlist").html(str)
        }
        function select() {
            if (userInfo_cookie.U_TYPE == 1) {
                getproject(0, 2, 1, $("#name_project").val())
            } else {
                getproject(userInfo_cookie.ID, 1, 1, $("#name_project").val())
            }
        }

    </script>
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
                                <button class="btn btn-default" onclick="select()">查询</button></div>

                            </div>

                        </div>
                        <table class="table table-bordered table-hover text-center">
                            <thead>
                            <tr>
                                <th>工程编号</th>
                                <th>工程名称</th>
                                <th>项目负责人</th>
                                <th>结束时间</th>
                                <th>工程类型</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="projectlist" class="text-left">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="text-center" id="page">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="modal" class=""></div>
</body>
</html>

