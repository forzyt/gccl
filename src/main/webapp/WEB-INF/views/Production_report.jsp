<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 14:54
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
    <title>检测上报</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="css/sign2.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <script src="js/calendar2.js?io=1"></script>
    <script src="js/modal.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>
    <script>
        var userInfo_cookie = null;
        $(function () {
            $.showLoading("请稍等");
            setTimeout(function () {
                $.hideLoading();
            }, 1000);
            $("#report").hide();
            $("#s_projectlist").hide();
            $('#myTab a:first').tab('show');
            $('#myTab a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            })
            $(".progress-bar").parent().hide()
            userInfo_cookie ={id:'${user.id}',uName:'${user.uName}',pwd:'${user.pwd}',issubpackage:'${user.issubpackage}',uState:'${user.uState}',uType:'${user.uType}',uTime:'${user.uTime}',uRName:'${user.uRName}'};
            if (userInfo_cookie.uName== '') {
                $.alert("请重新登录", "提示", function () {
                    parent.location.href = "login";
                })
            } else {
                /*if (userInfo_cookie.uType == 1) {
                    getproject(0, 2, 1)
                } else {
                    getproject(userInfo_cookie.id, 1, 1)
                }*/
            }
            $("input[type='file']").addClass("bb");
            //上传文件
            $("#up_yuanshi.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(1, fileName);
                $(this).val("");
            })
            $("#up_guocheng.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(2, fileName);
                $(this).val("");
            })
            $("#up_xianchang.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(4, fileName);
                $(this).val("");
            })
            $("[type=radio]").click(function () {
                if ($("[type=radio]:checked").val() == 1) {
                    $("#yichang").addClass('hidden');
                } else {
                    $("#yichang").removeClass('hidden');
                }

            })

        })
        function upload(type, fileName) {
            $this = $(this);
            var options = {
                type: 'post',
                url: 'upload',
                dataType: "json",
                success: function (obj) {
                    var filepath=obj.filePath;
                    $this.removeClass("btn-default").addClass("btn-primary");
                    var str = "";
                    var filenewnamelist = obj.resultOBJ.split('&&');
                    var fileoldnamelist = obj.resultMsg.split('&&');
                    for (var i = 0; i < filenewnamelist.length; i++) {
                        var tempstr = "";
                        if (chooseicon(filenewnamelist[i], 2) == 1) {
                            tempstr = ' onclick="showmodal(\'' + filenewnamelist[i] + '\')"';
                        }
                        str += "<span  class='nowrap' fileName='" + fileoldnamelist[i] + "' s_type='" + type + "' name='new' s_id='" + filenewnamelist[i] + "'>&nbsp&nbsp<span " + tempstr + "><span class='" + chooseicon(filenewnamelist[i], 1) + "'></span>&nbsp;" + fileoldnamelist[i] + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(0,this,'"+filepath+"')></span></span>";
                    }
                    if (type == 1) {
                        $("#ys_label").html($("#ys_label").html() + str);
                    } else if (type == 2) {
                        $("#cg_label").html($("#cg_label").html() + str);
                    } else if (type == 4) {
                        $("#xc_label").html($("#xc_label").html() + str);
                    }
                    $(".progress-bar").attr("style", "min-width: 2em; width: 0%;");
                    $(".progress-bar").text("0%");
                    $(".progress-bar").parent().hide();

                },
                error: function (obj) {
                    alert(0);
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    $(".progress-bar").parent().show();
                    var prog = ((position / total) * 100).toFixed(0);
                    $(".progress-bar").attr("style", "min-width: 2em; width: " + prog + "%;");
                    $(".progress-bar").text(prog + "%")

                }
            };
            if (type == 1) {
                $("#up_yuanshi").ajaxSubmit(options);
            } else if (type == 2) {
                $("#up_guocheng").ajaxSubmit(options);
            } else if (type == 4) {
                $("#up_xianchang").ajaxSubmit(options);

            }
        }
        function showmodal(url) {
            modalinfo.body = '<img src="/Project/' + url + '" class="img-responsive" />';
            modalinfo.title = "图片预览"
            modalinfo.initial();
            modalinfo.show();
        }
        var worklistarray = new Array();
        var c_worklistarray = new Array();
        var dprojectdate = [];
        function reportshow(data) {
            dprojectdate.pNumber=data;
            $("#jd_input").show();
            //回显子任务
            $.ajax({
                url:'getSubtask?pNumber='+data,
                type:'Post',
                ansyc:'false',
                dataType:'json',
                success:function(data){
                    var subtask=data.subtask;
                    var sked=data.sked;
                    var noSubtask=data.noSubtask;
                    var noSked=data.noSked;
                    if (noSubtask==0) {//有子任务
                        $("#s_projectlist").show();
                        $("#productionlist").hide();
                        zliststr(subtask);
                    } else {//无子任务
                        $("#report").show();
                        $("#productionlist").hide();
                        worklistarray = new Array();
                        if (noSked==0) {//显示工作计划
                            $(".errorcal").html("")
                            dprojectdate.sked=sked;
                            showreport(0);
                        } else {
                            $("#worklist").html("");
                        }
                    }
                },
                error:function(data){
                    alert("请求失败");
                }
            });
        }

        function listshow() {
            if (addressurl == 1) {
                $("#report").hide();
                $("#productionlist").show();
                $("#s_projectlist").hide();
                //location.reload();
            } else if (addressurl == 2) {
                $("#s_projectlist").show();
                $("#productionlist").hide();
                $("#report").hide();
                //location.reload();
            }
            addressurl = 1;
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
        var RecordCount = 10;
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
                str += '<tr><td>' + list[i].P_NUMBER + '</td><td style="width:280px">' + list[i].P_NAME + '</td><td>' + list[i].P_CAPTAIN + '</td>';
                str += '<td>' + dateFormat(list[i].P_END_TIME, "yyyy-MM-dd") + '</td><td>' + list[i].TYPE_NAME + '</td><td style="width:180px">' + (list[i].P_PROGRESS == null ? "暂无" : list[i].P_PROGRESS )+ '</td>';
                str += '<td><button type="button" class="btn btn-primary btn-sm btn-sm" onclick="reportshow(' + JSON.stringify(list[i]).replace(/\"/g, "'") + ')">上报</button></td></tr>';
            }
            if (str == "") {
                str = '<tr><td colspan="7"><h5>暂无数据</h5></td></tr>'
            }
            $("#projectlist").html(str)
        }

        function addproject() {
            if ($(".red-bg").length == 1) {
                if ($("#reportremark").val() == "") {
                    $.alert("未按照工作计划的时间上报，请填写说明");
                    return;
                }
            }
            if ($(".progress-bar:hidden").length != 3) {//未上传完文件
                $.alert("文件正在上传");
                return;
            }
            var file=',"file":[]';
            if ($("span[name=new]").length > 0) {
                  file = ',"file":['
                for (var i = 0; i < $("span[name=new]").length; i++) {
                    if (i != 0) {
                        file += ","
                    }
                    file += ' {"id":-1,"fId":' + $("span[name=new]:eq(" + i + ")").attr("s_type") + ',"uId":' + userInfo_cookie.id + ',"fileName":"' + $("span[name=new]:eq(" + i + ")").attr("filename") + '","fileUrl":"' + $("span[name=new]:eq(" + i + ")").attr("s_id") + '"}';
                }
                file += ']'
            }
            var day = 1;
            if ($(".red-bg").text() != "") {
                day = $(".red-bg").text();
            }
            if ($(".blue-bg").text() != "") {
                day = $(".blue-bg").text();
            }
            var date = calUtil.showYear + "-" + calUtil.showMonth + "-" + day
            if ($(".blue-bg").text() == "" && $(".red-bg").text() == "") {
                date = new Date();
            }
            var datetime = new Date(date);
            var project={"pProgress":$("#Projectschedule").val(),"planIs":-1,"rIs":-1,"sIs":-1};
            var record={"id":-1,"pId":dprojectdate.pNumber,"uId":userInfo_cookie.id,"tId":1,"pSchedule":$("#Projectschedule").val(),"psId":S_projectid,"prState":0};
            var results = '{"record":'+JSON.stringify(record)+',"F_TYPE":"' + $("#yichang").val() + '","TYPE":"' + $("#reportremark").val() + '","project":' + JSON.stringify(project) + file + '}';
            var s=JSON.stringify(results);
            var result=JSON.parse(s);
            /*  取JSON对象中的值
                var json = eval("("+result+")");
                alert(json.record.id);*/
            alert(result)
            if (result != "") {
                //var url = 'SubmitReport';
                FuncAjaxs(url, result, function (obj) {
                    $.hideLoading();
                    if (obj.resultCode == 0) {
                        $.alert("上报成功", "提示", function () {
                            location.reload();
                        })
                    } else {
                        $.alert(obj.resultMsg);
                    }
                }, function (obj) {
                    $.alert("请求失败");
                })
            }
        }
        //子任务列表
        function zliststr(subtask) {
            var str = "";
            for (var i = 0; i < subtask.length; i++) {
                str += '<tr><td>' + subtask[i].id + '</td><td>' + subtask[i].sName + '</td><td>' + Wrapstr(subtask[i].sSummary, 1, 40) + '</td>';

                str += '<td><button type="button" class="btn btn-primary btn-sm btn-sm" onclick="showreport(' + subtask[i].id + ')">上报</button></td></tr>';

            }
            if (str == "") {
                str = '<tr><td colspan="6"><h5>暂无数据</h5></td></tr>'
            }
            $("#s_list").html(str)

        }
        var addressurl = 1;
        var S_projectid = 0;
        function showreport(s_projectid) {
            var url = 'selectLikeSked?pId='+dprojectdate.pNumber+"&psId="+s_projectid;
            var result = '';
            FuncAjax(url, result, function (obj) {
                if (obj.resultCode == 0) {
                    S_projectid = s_projectid;
                    if (s_projectid != 0) {
                        $("#jd_input").hide();
                        $("#Projectschedule").val("");
                    }
                    calUtil.reportlist = obj.resultOBJ.skeds;

                    if (s_projectid != 0) {
                        var data = obj.resultOBJ.skeds;
                        for (var i = 0; i < data.length; i++) {
                            if (data[i].psId == s_projectid) {
                                $("#s_projectlist").hide();
                                $("#productionlist").hide();
                                $("#report").show();
                                addressurl = 2;
                                if (data.length == 0) {
                                    worklistarray = new Array();
                                    $("#worklist").html("");
                                } else {
                                    var temp = JSON.stringify(data);
                                    temp = temp.replaceAll("sYear", "signYear");
                                    temp = temp.replaceAll("sMonth", "signMonth");
                                    temp = temp.replaceAll("sDay", "signDay");
                                    var a = eval('(' + temp + ')')
                                    calUtil.eventName = "load"
                                    calUtil.drawstr = "#worklist"
                                    calUtil.init(a, false);
                                }
                            }
                        }
                    } else {
                        var temp = JSON.stringify(dprojectdate.sked);
                        temp = temp.replaceAll("sYear", "signYear");
                        temp = temp.replaceAll("sMonth", "signMonth");
                        temp = temp.replaceAll("sDay", "signDay");
                        var a = eval('(' + temp + ')')
                        worklistarray = a;
                        calUtil.eventName = "load"
                        calUtil.drawstr = "#worklist"
                        calUtil.init(worklistarray, false);
                    }
                } else {
                    S_projectid = s_projectid;
                    $("#s_projectlist").hide();
                    $("#productionlist").hide();
                    $("#report").show();
                    $("#jd_input").remove();
                }
            }, function (obj) {
                $.alert("请求失败");
            }, 0)
        }
        function delimg(id, e, data) {
            if (id == 0) {
                $(e).parent().remove();
                $.ajax({
                    url:'deleteFile',
                    type:'Post',
                    data:{"filePath":data},
                    success:function(obj){
                        if(obj.resultCode==0){
                            $.alert("已删除!");
                        }else{
                            $.alert("删除失败!");
                        }
                    },
                    error:function(){
                        $.alert("请求失败！");
                    }
                });
            }
        }
        function updateproject() {
            var pNumber=dprojectdate.pNumber;
            var url = 'updatepProgress';
            var results = {"pNumber":  pNumber ,"pProgress":$("#P_PROGRESS").val()}
            $.ajax({
                url:url,
                type:"post",
                data:results,
                ansyc:"false",
                success:function(obj){
                    if (obj.resultCode == 0) {
                        $.hideLoading();
                        $.alert("成功")
                        $('#tb_departments').bootstrapTable('refresh');
                    } else {
                        $.hideLoading();
                        $.alert("失败")
                    }
                }
            });
        }
    </script>
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
        .bb{
            cursor:pointer;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-top_20 ">

    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="productionlist">
                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading" >
                            <div class=" row">
                                <div class="col-sm-8 text-left"><h4>监测上报</h4></div>
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
            <div class="row" id="report">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="listshow()"><span class="glyphicon glyphicon-home" style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
                </div>
                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">上报</h3>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal ">
                                <div class="form-group has-primary" id="">
                                    <div class="col-sm-offset-2 col-sm-8" id="worklist">
                                    </div>
                                </div>
                                <div class="form-group has-primary" id="jd_input">
                                    <label class="col-sm-2 control-label" for="name">工程进度：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="Projectschedule"
                                               placeholder="请输入工程进度（百分比）">
                                    </div>
                                </div>
                                <div class="form-group has-primary">
                                    <label class="col-sm-2 control-label" for="name">异常说明：</label>
                                    <div class="col-sm-2">
                                        <label class="radio-inline">
                                            <input type="radio" name="inlineRadioOptions" id="inlineRadio1" value="0" />
                                            有
                                        </label>
                                        <label class="radio-inline">
                                            <input type="radio" name="inlineRadioOptions" id="inlineRadio2" value="1" checked="checked" />
                                            无
                                        </label>
                                    </div>
                                    <div class="col-sm-6 ">
                                        <input type="text" class="form-control hidden" id="yichang"
                                               placeholder="请输入异常说明">
                                    </div>
                                </div>
                                <div class="form-group has-primary hidden" id="shuoming">
                                    <label class="col-sm-2 control-label" for="name">上报异常说明：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="reportremark"
                                               placeholder="请填写上报异常的说明" />
                                    </div>
                                </div>
                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 control-label" for="tel">上传资料：</label>
                                    <ul class="nav nav-tabs  col-sm-9" id="myTab">
                                        <li class="active "><a href="#home" class="text-primary">原始数据</a></li>
                                        <li><a href="#profile" class="text-primary">成果数据</a></li>
                                        <li><a href="#photos" class="text-primary">现场图片</a></li>
                                    </ul>
                                    <div class="tab-content has-primary col-sm-offset-2 col-sm-9" style="border-bottom: 1px solid #d6e9c6; border-left: 1px solid #d6e9c6; border-right: 1px solid #d6e9c6;">
                                        <div class="tab-pane active list-group " id="home">
                                            <br />
                                            <div class="list-group ">
                                                <label class="col-sm-2 control-label " for="idCard">原始数据：</label>
                                                <div class="col-sm-2">
                                                    <form id="up_yuanshi" surl="" class="file">
                                                        <input type="file" id="File2" style="display: inline-block;" name="file" multiple="multiple" />选择
                                                    </form>

                                                </div>
                                                <div class="col-sm-2">
                                                    <div class="progress ">
                                                        <div class="progress-bar" id="prog_ys" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                            <div class="list-group ">
                                                <div id="ys_label"></div>
                                            </div>
                                        </div>
                                        <div class="tab-pane list-group " id="profile">
                                            <br />
                                            <div class="list-group ">
                                                <label class="col-sm-2 control-label " for="idCard">成果资料：</label>
                                                <div class="col-sm-2">
                                                    <form id="up_guocheng" surl="" class="file">
                                                        <input type="file" id="File3" style="display: inline-block;" name="file" multiple="multiple" />选择
                                                    </form>

                                                </div>
                                                <div class="col-sm-2">
                                                    <div class="progress ">
                                                        <div class="progress-bar" id="prog_cg" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                            <div class="list-group ">
                                                <div id="cg_label"></div>
                                            </div>
                                        </div>
                                        <div class="tab-pane list-group " id="photos">
                                            <br />
                                            <div class="list-group ">
                                                <label class="col-sm-2 control-label " for="idCard">现场照片：</label>
                                                <div class="col-sm-2">
                                                    <form id="up_xianchang" surl="" class="file">
                                                        <input type="file" id="File1" style="display: inline-block;" name="file" multiple="multiple" />选择
                                                    </form>

                                                </div>
                                                <div class="col-sm-2">
                                                    <div class="progress ">
                                                        <div class="progress-bar" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <br />
                                            <div class="list-group ">
                                                <div id="xc_label"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-group has-success">
                                    <div class="col-sm-6 col-sm-offset-3">
                                        <button type="button" class="btn btn-primary  btn-lg btn-block" onclick="addproject()">提交</button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="row" id="s_projectlist">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="listshow()"><span class="glyphicon glyphicon-home"style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
                </div>
                <div class="col-sm-12">

                    <div class="panel panel-default">
                        <br />
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">总工程进度：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="P_PROGRESS"
                                       placeholder="请输入工程进度">
                            </div>
                            <div class="col-sm-2">
                                <button type="button" class="btn btn-primary" onclick="updateproject()">提交</button></div>
                        </div>
                        <br />
                        <div class="panel-body">
                            <table class="table table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>子任务编号</th>
                                    <th>子任务名称</th>
                                    <th>子任务描述</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="s_list">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<div id="modal"></div>
<!-- /.modal -->
</body>
<script>
    //(1)初始化在施工程
    $(function () {
        var oTable = new TableInit();
        oTable.Init();
    });
    var TableInit = function () {
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
                        field: 'pEndTime',
                        title: '结束时间',
                        formatter:aaFormatter,
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
            });
        };
        //操作栏的格式化
        function actionFormatter(value, row, index) {

            return "<span onclick=\"reportshow('" + row.pNumber + "')\" class='label label-primary' style='cursor:pointer;padding:5px 30px;'>上报</span>"
        }
        //结束时间栏格式化
        function aaFormatter(value, row, index) {
            Date.prototype.toLocaleString = function() {
                return this.getFullYear() + "年" + (this.getMonth() + 1) + "月" + this.getDate() + "日 ";
            };
            var unixTimestamp = new Date( value ) ;
            commonTime = unixTimestamp.toLocaleString();
            return commonTime;
        }
        //工程进度栏格式化
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
    function chakan(i){
        parent.frames['mains'].location.href='showCheckproject?pNumber='+i;
    }
    //(2)关键字检索
    $("#btn_query").click(function () {
        //点击查询是 使用刷新 处理刷新参数
        var opt = {
            url: "getLikeProject",
            silent: true,
            query: {
                pName: $("#name_project").val(),
            }
        };
        $('#tb_departments').bootstrapTable('refresh', opt);

    });

</script>
</html>

