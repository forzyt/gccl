<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 15:13
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
    <title>质量反馈</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/BootSideMenu.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <!-- 自定义样式 -->
    <link href="css/custom.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <!--悬浮抽拉样式-->
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <!-- <script src="js/Master.js"></script>-->
    <script src="js/common.js"></script>
    <script src="js/BootSideMenu.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <!--悬浮抽拉js-->
    <script>
        var userInfo_cookie = null;
        $(function () {
            userInfo_cookie = eval('(' + getCookie('USERINFO') + ')');
            if (userInfo_cookie == null) {
               /* $.alert("请重新登录", "提示", function () {
                    location.href = "login.html";
                })*/
            } else {
                if (userInfo_cookie.U_TYPE == 1) {
                    getproject_checked(0, 1);
                } else {
                    getproject_checked(userInfo_cookie.ID, 1)
                }
            }
        })
        var RecordCount = 8;
        var projectcheckedlist = null;
        function getproject_checked(uid, index) {
            var url = 'user/getcheckreplybyuid';
            var restlt = '{"ID":' + uid + ',"T_ID":' + index + ',"U_ID":' + RecordCount + ',"P_SCHEDULE":"' + $("#name_project").val() + '","PS_ID":' + parseInt($("#checkstate").val()) + '}';
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
        function projectcheck(list) {
            var str = "";
            for (var i = 0; i < list.length; i++) {
                str += '<tr>';
                str += '<td>' + list[i].P_ID + '</td>';
                str += '<td style="width:380px">' + list[i].P_NAME + '</td>';
                str += '<td>' + list[i].P_CAPTAIN + '</td>';
                str += '<td>' + list[i].U_R_NAME + '</td>';
                str += ' <td>' + dateFormat(list[i].C_TIME, "yyyy-MM-dd") + '</td>';
                var FRACTION = list[i].FRACTION;
                var chakan = "未查看";
                var btn_class = "btn btn-primary"
                if (list[i].PC_STATE == 2) {//修改后的上报
                    FRACTION = "已修改"
                    if (list[i].PR_STATE == 1) {
                        chakan = "已查看";
                        btn_class = "btn btn-info"
                    }
                }
                str += '<td>' + FRACTION + '</td>';


                if (list[i].R_TYPE == 1 && list[i].PC_STATE != 2) {
                    chakan = "已查看";
                    btn_class = "btn btn-info"
                }
                var noupdate = 0;//0需要修改1：不需要修改
                if (chakan == "已查看") {
                    noupdate = 1;
                }
                str += '<td><button type="button" class="btn ' + btn_class + ' btn-sm" onclick="check(' + list[i].R_ID + ',' + list[i].ID + ',' + list[i].PS_ID + ',' + list[i].PC_STATE + ',' + noupdate + ',\'' + list[i].P_ID + '\')" >' + chakan + '</button></td>';
                str += '</tr>';
            }
            if (str == "") {
                str = '<tr><td colspan="7"><h5 class="text-center">暂无数据</h5></td></tr>'
            }
            $("#project_checked").html(str);
        }
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
            str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="jump"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(' + pagecount + ',\'' + onclick + '\')">跳转</button></li>'
            str += '</ul>';
            str += '</ul>';
            return str;
        }
        function pageshow2(index) {
            if (userInfo_cookie.U_TYPE == 1) {
                getproject_checked(0, index)
            } else {
                getproject_checked(userInfo_cookie.ID, index)
            }
        }
        function Jump(maxcount, onclick) {
            var page = parseInt($("#jump").val());
            if (isNaN(page) || page < 1 || page > maxcount) {
                onclick += "(1)";
            } else {
                onclick += "(" + page + ")";
            }
            eval(onclick);
        }
        function check(pid, c_id, ps_id, pc_state, noupdate, P_ID) {
            if (pc_state == 2) {//已修改
                if (noupdate == 1) {
                    window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id + '&type=2&pc_state=' + pc_state + '&P_ID=' + P_ID;;
                } else {
                    var url = 'user/updatereportstate';
                    var result = '{"ID":' + pid + '}';
                    FuncAjax(url, result, function (obj) {
                        if (obj.ResultCode == 0) {
                            window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id + '&type=2&pc_state=' + pc_state;
                        } else {
                            window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id + '&type=2&pc_state=' + pc_state + '&P_ID=' + P_ID;
                        }
                    }, function () { window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id + '&type=2&pc_state=' + pc_state + '&P_ID=' + P_ID;; })
                }
            } else {
                if (noupdate == 1) {
                    window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id;
                } else {
                    var url = 'user/updatereplybyid';
                    var restlt = '{"PC_ID":' + c_id + '}';
                    FuncAjax(url, restlt, function (obj) {

                        window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id;

                    }, function (obj) {
                        window.location.href = 'Inspect.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id;
                    })
                }
            }

        }
    </script>
</head>
<body>
<div class="container-fluid  margin-top_20">
    <div class="tab-pane list-group " id="quality_bulletin">
        <div class="panel-heading">
            <div class=" row">
                <div class="col-sm-5 text-left">
                    <h4>质量反馈</h4>
                </div>
                <div class="col-sm-3">
                    <select class="form-control" id="checkstate">
                        <option value="1" selected>全部</option>
                        <option value="0">未查看</option>
                    </select>
                </div>
                <div class="col-sm-3">
                    <input type="text" class="form-control" placeholder="请输入工程编号/工程名称" id="name_project" />
                </div>
                <div class="col-sm-1">
                    <button class="btn btn-default" onclick="pageshow2(1)">查询</button>
                </div>
            </div>

        </div>
        <div class="row">
            <div class="col-sm-12">
                <table class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th>工程编号
                        </th>
                        <th>工程名称</th>
                        <th>负责人</th>
                        <th>质量检查人</th>
                        <th>最新检查时间</th>
                        <th>分数</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody id="project_checked" class="text-left">
                    </tbody>
                </table>
            </div>
            <div class="text-center" id="pagelist">
            </div>
        </div>
    </div>
</div>
</body>
</html>

