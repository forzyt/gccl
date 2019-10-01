<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 15:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <meta name="renderer" content="webkit">
    <title>上报数量统计</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <script src="js/modal.js"></script>
    <script src="js/laydate.dev.js"></script>
    <script>
        $(function () {
            $("#END_TIME").val(getDay_num(0, 2, '-'));
            $("#detail").hide();
            $("#START_TIME").val(getDay_num(-7, 2, '-'));
            reportnum(1);
            selectsecondType()
            laydate({
                elem: '#END_TIME'
            });
            laydate({
                elem: '#START_TIME'
            });
        })
        var pagenum = 8;
        var project_report = null;
        function reportnum(index) {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            if (START_TIME == "") {
                $.alert("开始时间不能为空")
                return
            }
            if (END_TIME == "") {
                $.alert("结束时间不能为空")
                return
            }
            if (!dateCompare(START_TIME, END_TIME)) {
                $.alert("开始时间不能大于结束时间")
                return
            }
            var url = 'user/project_report_num';
            var restlt = '{"P_START_TIME":"' + getJSONDate(START_TIME) + '","P_END_TIME":"' + getJSONDate(END_TIME) + '","P_NAME":"' + $("#P_NAME").val() + '","P_TYPE":' + $("#P_TYPE").val() + ',"R_IS":' + index + ',"P_F_TYPE":' + pagenum + ',"F_NAME":"' + $("#captain").val() + '"}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ != null) {
                        project_report = obj.ResultOBJ.list;
                        liststr(project_report)
                        $("#page").html(paging(index, obj.ResultOBJ.pageCount, "reportnum", obj.ResultOBJ.RecordCount));
                    } else {

                    }
                } else {
                }
            }, function (obj) {
                $.alert("请求失败");

            })

        }
        function liststr(list) {
            var str = "";
            for (var i = 0; i < list.length; i++) {
                str += '<tr><td>' + list[i].P_NUMBER + '</td><td style="width:300px">' + list[i].P_NAME + '</td><td style="width:80px">' + list[i].P_CAPTAIN + '</td>';
                str += '<td style="width:100px">' + list[i].TYPE_NAME + '</td><td style="width:80px">' + list[i].REPORTNUM + '</td><td style="width:80px">' + list[i].REPULSENUM + '</td>';
                str += '<td><button type="button" class="btn btn-primary btn-sm btn-sm" onclick="chakan(' + JSON.stringify(list[i]).replace(/\"/g, "'") + ')">查看</button>&nbsp;&nbsp;</td></tr>';

            }
            $("#projectlist").html(str);
            if (str == "") {
                $("#projectlist").html('<tr><td colspan="6" class="text-center"><h5>暂无数据</h5></td></tr>');
            }
        }
        var projectid = 0;
        function chakan(data) {

            $("#productionlist").hide();
            $("#detail").show();
            projectid = data.P_NUMBER;
            reportstatistics(data.P_NAME);
            reportlist(1);

        }
        var row_count = 5//最多显示5页
        function paging(index, pagecount,onclick, recordcount) {
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
            if (count == row_count && (pagecount % row_count != 0)) {
                if (plus <= (pagecount - 1)) {
                    str += '<li><a  onclick="' + onclick + '(' + ((plus + 1) * row_count + 1) + ')">&raquo;</a></li>';
                }
            }
            str += '<li class="pull-left" style="margin:7px">共' + pagecount + ' 页' + recordcount + '条</li>'
            str += '<li class="pull-left" style="margin-left:7px"><input type="number" style="width:40px" id="' + onclick + '"/> 页  <button type="button" class="btn btn-default btn-sm" onclick="Jump(\'' + onclick + '\',' + pagecount + ')">跳转</button></li>'
            str += '</ul>';
            return str;
        }
        function Jump(onclick,maxcount) {
            var page = parseInt($("#" + onclick + "").val());
            if (isNaN(page) || page < 1 || page > maxcount) {
                onclick+="(1)";
            } else {
                onclick += "("+page+")";
            }
            eval(onclick);
        }
        var reportstatisticsdata=null
        function reportstatistics(P_name) {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            var url = 'user/reportstatistics';
            var result = '{"P_NUMBER":"' + projectid + '","P_START_TIME":"' + getJSONDate(START_TIME) + '","P_END_TIME":"' + getJSONDate(END_TIME) + '"}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    reportstatisticsdata = obj.ResultOBJ;
                    if (reportstatisticsdata.r_total != -1) {
                        //超时上报
                        reportstatisticsdata.r_qualified
                        //未上报
                        $("#reportmessage").html('<div class="col-sm-6 text-left "><h4 id="projectname" >' + P_name + '</h4></div><div class="col-sm-3 text-left "><h3 id="" class="title-color-blue" onclick="overtime()">超时上报&nbsp;&nbsp;<span class="title-color-radius">&nbsp;&nbsp;' + reportstatisticsdata.r_overtime + '&nbsp;&nbsp;</span></h3></div><div class="col-sm-3 text-left "><h3 id="" class="title-color-blue" onclick="unreported()">未上报&nbsp;&nbsp;<span class="title-color-radius">&nbsp;&nbsp;' + reportstatisticsdata.r_unreported + '&nbsp;&nbsp;</span></h3></div>')
                    } else {
                        $("#reportmessage").html('<div class="col-sm-12 text-left "><h4 id="projectname">' + P_name + '</h4></div>');
                    }

                } else {
                    $("#reportmessage").html('<div class="col-sm-12 text-left "><h4 id="projectname">' + P_name + '</h4></div>');
                }

            })
        }
        //详细的上报列表
        function reportlist(index) {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            var url = 'user/getreportlistbytime';
            var result = '{"P_ID":"' + projectid + '","PR_TIME":"' + getJSONDate(START_TIME) + '","CREAT_TIME":"' + getJSONDate(END_TIME) + '","ID":' + index + ',"U_ID":' + pagenum + '}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ.list != null) {
                        var str = "";
                        for (var i = 0; i < obj.ResultOBJ.list.length; i++) {
                            var sch = obj.ResultOBJ.list[i].FRACTION;
                            if (obj.ResultOBJ.list[i].PC_STATE == 2) {
                                sch = "已修改";
                            } else if (obj.ResultOBJ.list[i].PC_STATE == 3) {
                                sch = "已打回";
                            }
                            str += '<tr><td>' + obj.ResultOBJ.list[i].ID + '</td><td>' + dateFormat(obj.ResultOBJ.list[i].PR_TIME, "yyyy年MM月dd日") + '</td><td>' + dateFormat(obj.ResultOBJ.list[i].CREAT_TIME, "yyyy年MM月dd日") + '</td><td>' + obj.ResultOBJ.list[i].U_R_NAME + '</td>';
                            str += '<td>' + (sch == "" ? "无" : sch == null ? "无" : sch) + '</td>';
                            if (obj.ResultOBJ.list[i].C_ID != 0) {
                                if (obj.ResultOBJ.list[i].PC_STATE != 2) {//以检查过
                                    str += '<td><button type="button" class="btn btn-success btn-sm" onclick="scoreshow(' + obj.ResultOBJ.list[i].ID + ',' + obj.ResultOBJ.list[i].ID + ',' + obj.ResultOBJ.list[i].PS_ID + ')">详情</button>';
                                } else {//打回的检查
                                    var text = "未查看";
                                    var btnclass = "btn-primary";
                                    if (obj.ResultOBJ.list[i].PR_STATE == 1) {
                                        text = "已查看";
                                        btnclass = "btn-info";
                                    }
                                    str += '<td><button type="button" class="btn ' + btnclass + ' btn-sm" onclick="scoreshow(' + obj.ResultOBJ.list[i].R_ID + ',' + obj.ResultOBJ.list[i].ID + ',' + obj.ResultOBJ.list[i].PS_ID + ')">' + text + '</button>';
                                }
                            } else {//过程检查id等于0
                                var text = "未查看"
                                var btnclass = "btn-primary";
                                if (obj.ResultOBJ.list[i].PR_STATE == 1) {
                                    text = "已查看";
                                    btnclass = "btn-info";
                                }
                                str += '<td><button type="button" class="btn ' + btnclass + ' btn-sm" onclick="scoreshow(' + obj.ResultOBJ.list[i].ID + ',0,' + obj.ResultOBJ.list[i].PS_ID + ')">' + text + '</button>';
                            }
                            str += '</td>/tr>';
                        }
                        if (str == "") {
                            str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>';
                        }
                        $("#report").html(str);
                        $("#reportpage").html(paging(index, obj.ResultOBJ.pageCount, "reportlist", obj.ResultOBJ.RecordCount));
                    } else {
                        $("#report").html('<tr><td colspan="6"><h5>暂无数据</h5></td></tr>');
                        $("#reportpage").html("");
                    }
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");
            }, 0)
        }
        function returnup() {
            $("#productionlist").show();
            $("#detail").hide();
            reportnum(1);
        }
        function scoreshow(pid, c_id, ps_id) {
            window.location.href = 'reportlist.html?index=' + pid + '&checkedid=' + c_id + '&ps_id=' + ps_id;
        }
        function selectsecondType() {
            var url = 'user/selectsecondType';
            var result = '{"F_ID":0}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ != null) {
                        var str = '<option value="0">请选择</option>';
                        for (var i = 0; i < obj.ResultOBJ.length; i++) {
                            str += '<option value="' + obj.ResultOBJ[i].ID + '">' +obj.ResultOBJ[i].TYPE_NAME+ '</option>';
                        }
                        $("#P_TYPE").html(str);

                    }
                }
            })

        }
        ///清空
        function clear_() {
            $("#P_NAME").val("");
            $("#P_TYPE").val(0);

        }
        //未上报日期
        function unreported() {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            var url = 'user/selectunreport';
            var result = '{"P_NUMBER":"' + projectid + '","P_START_TIME":"' + getJSONDate(START_TIME) + '","P_END_TIME":"' + getJSONDate(END_TIME) + '"}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ != null) {
                        var str = '<ul class="list-group">'
                        for (var i = 0; i < obj.ResultOBJ.length; i++) {
                            str += '<li class="list-group-item">' + obj.ResultOBJ[i].S_YEAR + '年' + obj.ResultOBJ[i].S_MONTH + '月' + obj.ResultOBJ[i].S_DAY + '日 <span class="badge">' +obj.ResultOBJ[i].S_NAME + '</span></li>';
                        }
                        str += '</ul>'

                        modalinfo.body = str;
                        modalinfo.title = "未上报日期";

                        modalinfo.initial();
                        modalinfo.show();

                    }
                }
            })

        }
        var overtimelist = null;
        ///超时工程上报
        function overtime() {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            var url = 'user/Selectovertimebyp_id';
            var result = '{"P_NUMBER":"' + projectid + '","P_START_TIME":"' + getJSONDate(START_TIME) + '","P_END_TIME":"' + getJSONDate(END_TIME) + '"}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    var str = '';
                    if (obj.ResultOBJ != null) {
                        overtimelist = obj.ResultOBJ;

                        for (var i = 0; i < overtimelist.length; i++) {
                            var sch = overtimelist[i].FRACTION;
                            if (overtimelist[i].PC_STATE == 2) {
                                sch = "已修改";
                            } else if (overtimelist[i].PC_STATE == 3) {
                                sch = "已打回";
                            }
                            str += '<tr><td>' + overtimelist[i].ID + '</td><td>' + dateFormat(overtimelist[i].PR_TIME, "yyyy年MM月dd日") + '</td><td>' + dateFormat(overtimelist[i].CREAT_TIME, "yyyy年MM月dd日") + '</td><td>' + overtimelist[i].U_R_NAME + '</td>';
                            str += '<td>' + (sch == "" ? "无" : sch == null ? "无" : sch) + '</td>';
                            if (overtimelist[i].C_ID != 0) {
                                if (overtimelist[i].PC_STATE != 2) {//以检查过
                                    str += '<td><button type="button" class="btn btn-success btn-sm" onclick="scoreshow(' + overtimelist[i].ID + ',' + overtimelist[i].ID + ',' + overtimelist[i].PS_ID + ')">详情</button>';
                                } else {//打回的检查
                                    var text = "未查看";
                                    var btnclass = "btn-primary";
                                    if (overtimelist[i].PR_STATE == 1) {
                                        text = "已查看";
                                        btnclass = "btn-info";
                                    }
                                    str += '<td><button type="button" class="btn ' + btnclass + ' btn-sm" onclick="scoreshow(' + overtimelist[i].R_ID + ',' + overtimelist[i].ID + ',' + overtimelist[i].PS_ID + ')">' + text + '</button>';
                                }
                            } else {//过程检查id等于0
                                var text = "未查看"
                                var btnclass = "btn-primary";
                                if (overtimelist[i].PR_STATE == 1) {
                                    text = "已查看";
                                    btnclass = "btn-info";
                                }
                                str += '<td><button type="button" class="btn ' + btnclass + ' btn-sm" onclick="scoreshow(' + overtimelist[i].ID + ',0,' + overtimelist[i].PS_ID + ')">' + text + '</button>';
                            }
                            str += '</td></tr>';
                        }
                        if (str == "") {
                            str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>';
                        }

                    } else {
                        if (str == "") {
                            str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>';
                        }

                    }
                    var str_ = '<table class="table table-bordered table-hover text-center"><thead><tr><th>上报编号</th><th>上报时间</th><th>实际上报时间</th><th>上传人</th><th>上报质量</th><th>操作</th></tr></thead><tbody id="" class="text-left">'+str+'</tbody></table>'
                    modalinfo.body = str_;
                    modalinfo.title = "未上报日期";
                    modalinfo.initial();
                    modalinfo.show();
                }
            })

        }
        //全选按钮
        function selectall(e) {
            if ($(e).is(':checked')) {
                $("input[name='inlineCheckbox']").each(function () { this.checked = true; });
            } else {
                $("input[name='inlineCheckbox']").each(function () { this.checked = false; });
            }
        }
        function clickcheck(e) {
            if ($(e).is(':checked')) {

            } else {
                $("input[name='Checkbox']").each(function () { this.checked = false; });
            }
        }
        //导出数据
        function export_data() {
            var checklen = $("input[name='inlineCheckbox']:checked").length;
            var list = [];
            for (var i = 0; i < checklen; i++) {
                list.push(eval('(' + $("input[name='inlineCheckbox']:checked:eq(" + i + ")").attr("data") + ')'));
            }
            var export_ = { exclname: $("#START_TIME").val() + "至" + $("#END_TIME").val() + "平台数据总揽", project_user: [] }
            export_.project_user = list;
            var result = JSON.stringify(export_);
            var url = 'user/Export';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ) {
                        $("#target").attr("download", $("#START_TIME").val() + "至" + $("#END_TIME").val() + "平台数据总揽.xls");
                        $("#target").attr("href", "/Project/Temporary/" + obj.ResultMsg)
                        document.getElementById("target").click();
                    } else {
                        $.alert("失败")
                    }
                }
            })
        }
        //导出按钮
        function export_btn() {
            var START_TIME = $("#START_TIME").val();
            var END_TIME = $("#END_TIME").val();
            if (START_TIME == "") {
                $.alert("开始时间不能为空")
                return
            }
            if (END_TIME == "") {
                $.alert("结束时间不能为空")
                return
            }
            if (!dateCompare(START_TIME, END_TIME)) {
                $.alert("开始时间不能大于结束时间")
                return
            }
            var url = 'user/project_report_num';
            var restlt = '{"P_START_TIME":"' + getJSONDate(START_TIME) + '","P_END_TIME":"' + getJSONDate(END_TIME) + '","P_NAME":"' + $("#P_NAME").val() + '","P_TYPE":' + $("#P_TYPE").val() + ',"R_IS":1,"P_F_TYPE":1000,"F_NAME":"' + $("#captain").val() + '"}';
            FuncAjax(url, restlt, function (obj) {
                if (obj.ResultCode == 0) {
                    if (obj.ResultOBJ != null) {
                        project_report = obj.ResultOBJ.list;
                        var str = '';
                        for (var i = 0; i < project_report.length; i++) {
                            str += '<tr><td><input type="checkbox" name="inlineCheckbox" onclick="clickcheck()" data="' + JSON.stringify(project_report[i]).replace(/\"/g, "'") + '"></td><td style="width:80px">' + project_report[i].P_NUMBER + '</td><td style="width:300px">' + project_report[i].P_NAME + '</td><td style="width:80px">' + project_report[i].P_CAPTAIN + '</td>';
                            str += '<td style="width:100px">' + project_report[i].TYPE_NAME + '</td><td style="width:40px">' + project_report[i].REPORTNUM + '</td><td style="width:40px">' + project_report[i].REPULSENUM + '</td>';
                            str += '</tr>';
                        }
                        var str_ = '<table class="table table-bordered table-hover text-center"><thead><tr><th >全选&nbsp<input onclick="selectall(this)" type="checkbox" name="Checkbox"></th><th>工程编号</th><th>工程名称</th><th>项目负责人</th><th>工程类型</th><th>上报数量</th><th>打回数量</th></tr></thead><tbody id="" class="text-left">' + str + '</tbody></table>'
                        modalinfo.body = str_;
                        modalinfo.title = "未上报日期";
                        modalinfo.footer = '<button type="button" class="btn btn-primary" onclick="export_data()">导出</button>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'
                        modalinfo.initial();
                        modalinfo.show();
                    } else {

                    }
                } else {
                }
            }, function (obj) {
                $.alert("请求失败");

            })

        }
    </script>
</head>
<body>
<div class="container-fluid margin-20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="productionlist">
                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class=" row">
                                <label class="col-sm-1 text-right margin-top_6">从：</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" placeholder="" id="START_TIME" />
                                </div>
                                <label class="col-sm-1 text-right margin-top_6">至：</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" placeholder="" id="END_TIME" />
                                </div>
                                <label class="col-sm-2 text-right margin-top_6">负责人</label>
                                <div class="col-sm-2">
                                    <input type="text" class="form-control" placeholder="" id="captain" />
                                </div>
                                <div class="col-sm-1">
                                    <button class="btn btn-default" onclick="reportnum(1)">查询</button>
                                </div>

                            </div>
                            <div class="row margin-6">
                                <label class="col-sm-2 text-right margin-top_6">工程名称/编号：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" placeholder="请输入工程名称或过程编号" id="P_NAME" />
                                </div>
                                <label class="col-sm-2 text-right margin-top_6">工程类型：</label>
                                <div class="col-sm-3">
                                    <select class="form-control" id="P_TYPE">
                                        <option value="0">请选择</option>
                                    </select>
                                </div>
                                <div class="col-sm-1">
                                    <button class="btn btn-default" onclick="export_btn()">导出</button>
                                </div>
                            </div>
                            <table class="table table-bordered table-hover text-center">
                                <thead>
                                <tr>
                                    <th>工程编号</th>
                                    <th>工程名称</th>
                                    <th>项目负责人</th>
                                    <th>工程类型</th>
                                    <th>上报数量</th>
                                    <th>打回数量</th>
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
            <div class="row text-center" id="detail">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="returnup()"><span class="glyphicon glyphicon-home"></span>&nbsp;返回</p>
                </div>
                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <div class=" row" id="reportmessage">
                                <div class="col-sm-4 text-left ">
                                    <h4 id="projectname"></h4>
                                </div>
                            </div>
                        </div>
                        <table class="table table-bordered table-hover text-center">
                            <thead>
                            <tr>
                                <th>上报编号</th>
                                <th>上报时间</th>
                                <th>实际上报时间</th>
                                <th>上传人</th>
                                <th>上报质量</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody id="report" class="text-left">
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="text-center" id="reportpage">
                </div>
            </div>
        </div>
    </div>
</div>
<div id="modal"></div>
<a id="target" href="" class="hidden" download="" target="_blank">
</a>
</body>
</html>


