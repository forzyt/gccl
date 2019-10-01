<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 15:19
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
    <title>用户管理</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/BootSideMenu.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <!-- 自定义样式 -->
    <link href="css/custom.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!--悬浮抽拉样式-->
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- <script src="js/Master.js"></script>-->
    <script src="js/common.js"></script>
    <script src="js/BootSideMenu.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <!--悬浮抽拉js-->
    <script>
        var RecordCount = 10;
        var rownum = 10;
        $(function () {
            $("#management").hide();
            getuserList(1)
        })
        //显示添加用户页面
        function manaement_user(data) {
            user = null;
            $("[name=usertype]").prop("checked", "");
            $("#Username").val("");
            $("#Userpwd").val("");
            $("#U_R_NAME").val("");
            addlistarray = null;
            havinglistarray = null;
            addproject_ = [];
            remove = [];
            getproject(user != null ? user.ID : 0, 1, 1, 1)
            $("#management").show();
            $("#userlist").hide();
            if (data == undefined) {

            }
        }
        //返回用户列表
        function returnuserlist() {
            $("#management").hide();
            $("#userlist").show();
            getuserList(1);
        }
        var addproject_ = [];
        ///添加工程
        function addproject() {
            var checkedlength = $("#addlist input[name]:checked").length;
            for (var i = 0; i < checkedlength; i++) {
                addproject_.push($("#addlist input[name]:checked:eq(" + i + ")").val());
            }
            for (var i = 0; i < checkedlength; i++) {
                $("#addlist input[name]:checked:eq(" + i + ")").parent().parent().remove();
            }
            havinglist(havinglistarray, addlistarray);
            $('#myModal').modal('toggle')

        }
        var RecordCount = 10;
        function pageshow(index) {
            getuserList(index)
        }
        //获取用户信息
        function getuserList(index) {
            var url = 'user/SelectAllUser';
            var restlt = '{"ID":' + index + ',"P_ID":"' + RecordCount + '"}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ.list != null) {
                        var list = obj.ResultOBJ.list;
                        var str = "";
                        for (var i = 0; i < list.length; i++) {
                            str += liststr(list[i])
                        }
                        $("#userlisttr").html(str);
                        $("#page").html(paging(index, obj.ResultOBJ.pageCount, "pageshow", obj.ResultOBJ.RecordCount));
                    } else {
                        $("#userlisttr").html('<tr><td colspan="7"><h4>暂无数据</h4></td></tr>');
                    }
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");

            })

        }
        ///分页
        var row_count = 5//最多显示5页
        function paging(index, pagecount, functions, recordcount) {
            var str = '<ul class="pagination" style="margin: 0px 0px;">';
            var plus = (Math.ceil(index / row_count) - 1) * row_count
            if (plus != 0) {
                str += '<li><a  onclick="' + functions + '(' + (plus) + ')">&laquo;</a></li>';
            }
            var count = 0;
            for (var i = 1; i <= row_count; i++) {
                var temp = i + plus;
                if (temp > pagecount)
                    continue;
                count++;
                if (temp == index) {
                    str += '<li class="active"><a  onclick="' + functions + '(' + temp + ')">' + temp + '</a></li>';
                } else {
                    str += '<li><a onclick="' + functions + '(' + temp + ')">' + temp + '</a></li>';
                }
            }
            if (count == row_count && (pagecount != (plus + count))) {
                if (plus <= (pagecount - 1)) {
                    str += '<li><a  onclick="' + functions + '(' + ((plus + 1) + count) + ')">&raquo;</a></li>';
                }
            }
            str += '<li class="pull-left" style="margin:7px">共' + pagecount + ' 页' + recordcount + '条</li>'
            str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="'+functions+'"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(' + pagecount + ',\''+functions+'\')">跳转</button></li>'
            str += '</ul>';
            return str;
        }
        function Jump(maxcount,onclick) {
            var page = parseInt($("#"+onclick+":visible").val());
            if (isNaN(page) || page < 1 || page > maxcount) {
                onclick+="(1)";
            } else {
                onclick+="("+page+")";
            }
            eval(onclick);
        }
        ///拼用户列表
        function liststr(data) {
            var str = '<tr>';
            str += '<td>' + data.ID + '</td>';
            str += '<td>' + data.U_R_NAME + '</td>';
            str += '<td>' + (data.ISSUBPACKAGE == 0 ? "否" : "是") + '</td>';
            str += '<td>' + judgeUserType(data.U_TYPE) + '</td>';

            str += '<td>' + dateFormat(data.U_TIME, "yyyy/MM/dd") + '</td>';
            str += '<td>';
            str += '<button type="button" class="btn btn-primary btn-sm" onclick="userupdate(' + data.ID + ')">修改</button>&nbsp;';
            str += '<button type="button" class="btn btn-danger btn-sm" onclick="deluser(' + data.ID + ')">删除</button>';
            str += '</td>';
            str += '</tr>';
            return str;
        }
        function deluser(id) {
            $.modal({
                title: "提示",
                text: "确定要删除该用户？",
                buttons: [
                    {
                        text: "取消", onClick: function () {
                        }
                    },
                    {
                        text: "确定", onClick: function () { //提交
                            var url = 'user/DelUser';
                            var restlt = '{"ID":' + id + '}';
                            FuncAjax(url, restlt, function (obj) {
                                if (obj.ResultCode == 0) {
                                    getuserList(1);
                                }
                            })
                        }
                    }
                ]
            });

        }
        ///添加用户
        function adduser() {
            var checklenght = $("[name=usertype]:checked").length;
            if (checklenght == 0) {
                $.alert("请选择用户的类型", "提示");
                return
            }
            if ($("#Username").val().trim() == "") {
                $.alert("请输入用户名", "提示");
                return
            }
            if ($("#Userpwd").val().trim() == "") {
                $.alert("请输入密码", "提示");
                return
            }
            if ($("#U_R_NAME").val().trim() == "") {
                $.alert("请输入真实姓名", "提示");
                return
            }
            if ($("[name=isSub]:checked").length == 0) {
                $.alert("请选择是否协作", "提示");
                return
            }
            var usertype = 0;
            for (var i = 0; i < checklenght; i++) {
                usertype += parseInt($("[name=usertype]:checked:eq(" + i + ")").val());
            };
            var addstr = "";
            var count = 0;
            for (var i = 0; i < addproject_.length; i++) {
                if (addproject_[i] != 0) {
                    if (count != 0) {
                        addstr += ',';
                    }
                    count++
                    addstr += '{"ID":-1,"P_ID":"' + addproject_[i] + '","C_STATE":0}';
                }
            }
            var removestr = "";
            count = 0
            for (var i = 0; i < remove.length; i++) {
                if (remove[i] != 0) {
                    if (count != 0) {
                        removestr += ',';
                    }
                    count++
                    removestr += '{"ID":0,"P_ID":"' + remove[i] + '","C_STATE":1,"U_ID":' + user.ID + '}';
                }
            }
            var uid = -1;
            if (user != null) {
                uid = user.ID;
            }
            var result = '{"user":{"ID":' + uid + ',"U_NAME":"' + $("#Username").val() + '","PWD":"' + $("#Userpwd").val() + '","U_R_NAME":"' + $("#U_R_NAME").val() + '","ISSUBPACKAGE":' + $("[name=isSub]:checked").val() + ',"U_TYPE":' + usertype + '},"addcopula":[' + addstr + '],"delcopula":[' + removestr + ']}'
            $.ajax({
                url: 'user/NewUser',  //ajax请求地址
                type: "POST",
                dataType: "json",
                contentType: 'text/json',
                data: result,//请求成功后的回调函数
                success: function (obj) {
                    if (obj.ResultCode == 0) {
                        returnuserlist();
                    } else {
                        $.alert(obj.ResultMsg);
                    }

                },
                //请求失败时调用此函数。有以下三个参数：XMLHttpRequest 对象、错误信息、（可选）捕获的异常对象。
                //如果发生了错误，错误信息（第二个参数）除了得到null之外，还可能是"timeout", "error", "notmodified" 和 "parsererror"。
                error: function (obj) {
                    $.alert("请求失败");
                }
            });

        }

        var havinglistarray = null;
        var projectlist = null;
        ///获取工程type1:用户的工程,type2:用户没有的工程
        function getproject(uid, type, state, index) {
            var url = 'user/Getprojectbyid';
            var restlt = '{"U_ID":' + uid + ',"C_STATE":' + state + ',"ID":' + index + ',"PID":' + RecordCount + '}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    projectlist = null;
                    if (obj.ResultOBJ != null) {
                        projectlist = obj.ResultOBJ.list;
                        if (type == 2) {
                            addlistarray = projectlist;
                            addlist(addlistarray, havinglistarray);
                            $("#pagelist").html(paging(index, obj.ResultOBJ.pageCount, "pagelist_", obj.ResultOBJ.RecordCount));
                        } else if (type == 1) {
                            havinglistarray = projectlist;
                            havinglist(havinglistarray, addlistarray)

                        }
                    } else {

                    }
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");

            })
        }
        function pagelist_(index) {
            getproject(user != null ? user.ID : 0, 2, 2, index);
        }
        var addlistarray = null;
        //添加工程按钮
        function addlistbtn() {
            if (addlistarray == null) {
                getproject(user != null ? user.ID : 0, 2, 2, 1);
            } else {
                addlist(addlistarray, havinglistarray);
            }
        }
        ///添加工程列表
        function addlist(list, removelist) {
            var str = '';
            if (removelist != null) {
                for (var i = 0; i < removelist.length; i++) {
                    for (var j = 0; j < remove.length; j++) {
                        if (remove[j] == removelist[i].P_NUMBER) {
                            str += '<tr><td><input type="checkbox" value="' + removelist[i].P_NUMBER + '" name="project" ></td>';
                            str += '<td>' + removelist[i].P_NUMBER + '</td><td>' + removelist[i].P_NAME + '</td><td>' + removelist[i].P_ADDRESS + '</td><td>' + removelist[i].TYPE_NAME + '</td>';
                            str += '</tr>';
                        }
                    }
                }
            }
            for (var i = 0; i < list.length; i++) {
                var flg = true;
                for (var j = 0; j < addproject_.length; j++) {
                    if (addproject_[j] == list[i].P_NUMBER) {
                        flg = false;
                    }
                }
                if (flg) {
                    str += '<tr><td><input type="checkbox" value="' + list[i].P_NUMBER + '" name="project" ></td>';
                    str += '<td>' + list[i].P_NUMBER + '</td><td>' + list[i].P_NAME + '</td><td>' + list[i].P_ADDRESS + '</td><td>' + list[i].TYPE_NAME + '</td>';
                    str += '</tr>';
                }

            }
            if (str == "") {
                str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>'
            }
            $("#addlist").html(str);
        }
        function havinglist(list, addlist) {
            var str = '';
            var count = 0;
            if (addlist != null) {
                for (var i = 0; i < addlist.length; i++) {
                    for (var j = 0; j < addproject_.length; j++) {
                        if (addproject_[j] == addlist[i].P_NUMBER) {
                            if (i < rownum) {
                                count++;
                                str += '<tr id="tr_' + addlist[i].P_NUMBER.replace(/\s+/g, "") + '">';
                                str += '<td>' + addlist[i].P_NUMBER + '</td><td>' + addlist[i].P_NAME + '</td><td>' + addlist[i].P_ADDRESS + '</td><td>' + addlist[i].TYPE_NAME + '</td><td>' + addlist[i].P_CAPTAIN + '</td>';
                                str += '<td><button type="button" class="btn btn-primary btn-sm" onclick="removeproject(\'' + addlist[i].P_NUMBER + '\',2)">移除</button></td></tr>';
                            }
                        }
                    }
                }
            }
            for (var i = 0; i < list.length; i++) {
                if (count < rownum) {
                    count++;
                    str += '<tr id="tr_' + list[i].P_NUMBER.replace(/\s+/g, "") + '">';
                    str += '<td>' + list[i].P_NUMBER + '</td><td>' + list[i].P_NAME + '</td><td>' + list[i].P_ADDRESS + '</td><td>' + list[i].TYPE_NAME + '</td><td>' + list[i].P_CAPTAIN + '</td>';
                    str += '<td><button type="button" class="btn btn-primary btn-sm" onclick="removeproject(\'' + list[i].P_NUMBER + '\',1)">移除</button></td></tr>';
                }
            }
            if (str == "") {
                str = '<tr><td colspan="6"><h5>暂无工程</h5></td></tr>'
            }
            $("#havingproject").html(str);
        }
        var remove = [];
        ///type1：本来就有的2：虚拟添加的
        function removeproject(id, type) {
            if (type == 1) {
                $("#tr_" + (id.replace(/\s+/g, "")) + "").remove();
                remove.push(id);
            } else {
                $("#tr_" + id + "").remove();
                for (var i = 0; i < addproject_.length; i++) {
                    if (addproject_[i] == id) {
                        addproject_[i] = 0;
                    }
                }
            }

        }
        var user = null;
        //用户修改
        function userupdate(uid) {
            var url = 'user/GetUserbyid';
            var restlt = '{"ID":' + uid + '}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    user = obj.ResultOBJ;
                    $("#Username").val(user.U_NAME);
                    $("#Userpwd").val(user.PWD);
                    $("#U_R_NAME").val(user.U_R_NAME);
                    var length = $("[name=usertype]").length;
                    for (var i = 0; i < length; i++) {
                        var temp = parseInt($("[name=usertype]:eq(" + i + ")").val());
                        if ((user.U_TYPE & temp) == temp) {
                            $("[name=usertype]:eq(" + i + ")").prop("checked", "checked");
                        } else {
                            $("[name=usertype]:eq(" + i + ")").prop("checked", "");
                        }
                    }
                    if (user.ISSUBPACKAGE == 1) {
                        $("[name=isSub]:eq(0)").prop("checked", "checked")
                    } else {
                        $("[name=isSub]:eq(1)").prop("checked", "checked")
                    }
                    addlistarray = null;
                    havinglistarray = null;
                    addproject_ = [];
                    remove = [];
                    getproject(uid, 1, 1, 1)
                    $("#management").show();
                    $("#userlist").hide();

                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");

            })
        }

    </script>
</head>
<body>
<div class="container-fluid margin-top_20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="userlist">
                <div class="col-sm-12">
                    <p class="pull-right  " onclick="manaement_user()">
                        <button type="button" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span>&nbsp;添加用户</button>
                    </p>
                </div>
                <div class="col-sm-12 ">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>用户id</th>
                            <th>用户名称</th>
                            <th>是否分包</th>
                            <th>用户角色</th>

                            <th>创建时间</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="userlisttr">
                        </tbody>
                    </table>
                </div>
                <div class="text-center">
                    <ul class="pagination" style="margin: 0px 0px;" id="page">
                    </ul>
                </div>

            </div>
            <div id="management">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">添加用户</h3>
                    </div>
                    <div class="panel-body ">
                        <div class="form-horizontal ">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">登录名：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="Username"
                                           placeholder="请输入登录名">
                                </div>
                                <label class="col-sm-2 control-label" for="tel">密码：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="Userpwd"
                                           placeholder="请输入密码">
                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">真实姓名：</label>
                                <div class="col-sm-4">
                                    <input type="text" class="form-control" id="U_R_NAME"
                                           placeholder="请输入真实姓名">
                                </div>


                            </div>
                            <div class="form-group has-primary text-left">
                                <label class="col-sm-2 control-label" for="name">用户角色：</label>
                                <div class="col-sm-4 ">
                                    <label class="checkbox-inline">
                                        <input type="checkbox" value="1" name="usertype">
                                        管理员
                                    </label>


                                    <label class="checkbox-inline">
                                        <input type="checkbox" value="2" name="usertype">
                                        监测人员
                                    </label>


                                    <label class="checkbox-inline">
                                        <input type="checkbox" value="4" name="usertype">
                                        检查人员
                                    </label>
                                </div>
                                <label class="col-sm-2 control-label" for="name">是否分包：</label>
                                <div class="col-sm-4">
                                    <label class="radio-inline">
                                        <input type="radio" name="isSub" id="" value="1">
                                        是
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="isSub" id="" value="0">
                                        否
                                    </label>
                                </div>
                            </div>
                            <div class="form-group has-primary">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <b class="pull-left">工程列表：</b><span class="pull-right">
                                            <button type="button" class="btn btn-primary btn-sm " data-toggle="modal" data-target="#myModal" onclick="addlistbtn()">添加工程</button></span>
                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <div class="col-sm-10 col-sm-offset-1">
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                        <tr>
                                            <th>工程编号</th>
                                            <th>工程名称</th>
                                            <th>工程地点</th>
                                            <th>工程类型</th>
                                            <th>项目负责人</th>
                                            <th>操作</th>
                                        </tr>
                                        </thead>
                                        <tbody id="havingproject">
                                        </tbody>
                                    </table>
                                </div>

                                <div class="form-group has-success margin-top_20">
                                    <div class="col-sm-4 col-sm-offset-2">
                                        <button type="button" class="btn btn-danger btn-lg btn-block" onclick="returnuserlist()">返回</button>
                                    </div>
                                    <div class="col-sm-4 ">
                                        <button type="button" class="btn btn-primary btn-lg btn-block" onclick="adduser()">提交</button>
                                    </div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">工程列表</h4>
                </div>
                <div class="modal-body" style="max-height: 300px; overflow: auto;">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <tr>
                            <th>选择</th>
                            <th>工程编号</th>
                            <th>工程名称</th>
                            <th>工程地点</th>
                            <th>工程类型</th>

                        </tr>
                        </thead>
                        <tbody id="addlist">
                        </tbody>
                    </table>
                </div>
                <div class="text-center">
                    <ul class="pagination" style="margin: 0px 0px;" id="pagelist">
                        <li><a href="#">&laquo;</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li class="#"><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">&raquo;</a></li>
                    </ul>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" onclick="addproject()">添加</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

