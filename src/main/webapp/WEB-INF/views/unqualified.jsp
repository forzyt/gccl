<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 14:58
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
    <title>上报反馈</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <script src="http://apps.bdimg.com/libs/html5shiv/3.7/html5shiv.min.js"></script>
    <script src="http://apps.bdimg.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/common.js"></script>
    <script src="js/modal.js"></script>
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>
    <script>

        var userInfo_cookie = null;
        $(function () {
            userInfo_cookie ={id:'${user.id}',uName:'${user.uName}',pwd:'${user.pwd}',issubpackage:'${user.issubpackage}',uState:'${user.uState}',uType:'${user.uType}',uTime:'${user.uTime}',uRName:'${user.uRName}'};
            if (userInfo_cookie.uName== '') {
                $.alert("请重新登录", "提示", function () {
                    parent.location.href = "login";
                })
            }
            ///上传进度条进行隐藏
            $(".progress-bar").attr("style", "min-width: 2em; width: 0%;");
            $(".progress-bar").text("0%");
            $(".progress-bar").parent().hide();
            $("#report").hide();

            $('#myTab a:first').tab('show');
            $('#myTab a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            });
            //修改文件选择按钮变小手
            $("input[type='file']").addClass("bb");

            $("[type=radio]").click(function () {
                if ($("[type=radio]:checked").val() == 1) {
                    $("#yichang").addClass('hidden');
                    $("#yichang").val("");
                } else {
                    $("#yichang").removeClass('hidden');
                }
            })
            //上传文件
            $("#up_yuanshi.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(2, fileName);
                $(this).val("");
            })
            $("#up_guocheng.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(3, fileName);
                $(this).val("");
            })
            $("#up_xianchang.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(5, fileName);
                $(this).val("");
            })
            //上传文件
            $("#wjfrom.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(6, fileName);
                $(this).val("");
            })
        })

        var reportDetails = new Array();
        var imglist = [];
        var P_ID_ID = -1;
        var R_ID_ID = -1;
        var R_IS_ID = -1;
        var S_IS_ID = -1;
        var ceckedid = -1;

        function filedata(id,state,progress){
            $("#report").show();
            $("#qualitylist").hide();
            $("#shangbao").removeClass('hidden');
            check_detail(id);
            if (state == 3) {//打回
                $("#shangbao").removeClass('hidden');
                $("#fankui").addClass('hidden');
                var url = 'getDrecord?id='+id;
                var result = '';
                FuncAjax(url, result, function (obj) {
                    if (obj.resultCode == 0) {
                        reportDetails = obj.resultOBJ;
                        $("#report").show();
                        $("#qualitylist").hide();
                        $("#Projectschedule").val(progress);
                        $("#fk_detail").addClass('hidden');
                        var ysstr = '';
                        var cgstr = '';
                        var xcstr = '';
                        for (var i = 0; i < obj.resultOBJ.length; i++) {
                            if (obj.resultOBJ[i].tpId == 5) {
                                $("[type=radio]:eq(0)").attr("checked", "checked");
                                $("#yichang").removeClass('hidden');
                                $("#yichang").val(obj.resultOBJ[i].pdrValue);
                            } else if (obj.resultOBJ[i].tpId == 6) {//异常上报说明
                                $("#shuoming").removeClass('hidden');
                                $("#reportremark").val(obj.resultOBJ[i].pdrValue);
                            } else if (obj.resultOBJ[i].tpId == 1) {
                                var temp = "";
                                temp = obj.resultOBJ[i].pdrValue;
                                temp = temp.substr(temp.lastIndexOf('/') + 1);
                                var tempstr = "";
                                if (chooseicon(obj.resultOBJ[i].pdrValue, 2) == 1) {
                                    tempstr = ' onclick="showmodal(\'' + obj.resultOBJ[i].pdrValue + '\',\'' + obj.resultOBJ[i].dRemark + '\')"';
                                }
                                ysstr += "<span class='nowrap' " + tempstr + " fileName='" + temp + "' s_type='2'  s_id='" + obj.resultOBJ[i].id + "'>&nbsp&nbsp<span class='" + chooseicon(obj.resultOBJ[i].pdrValue, 1) + "'></span>&nbsp;" + obj.resultOBJ[i].dRemark + "&nbsp;<span class='glyphicon glyphicon-remove red' onclick='delimg(" + obj.resultOBJ[i].id + ",this,null)'></span></span>";
                                var temparray = { ID: obj.resultOBJ[i].id, F_ID: 0, U_ID: userInfo_cookie.id, FILE_NAME: obj.resultOBJ[i].dRemark, FILE_URL: obj.resultOBJ[i].pdrValue }
                                imglist.push(temparray)
                            } else if (obj.resultOBJ[i].tpId == 2) {//成果数据
                                var temp = "";
                                temp = obj.resultOBJ[i].pdrValue;
                                temp = temp.substr(temp.lastIndexOf('/') + 1);
                                var tempstr = "";
                                var bianqian = "";
                                if (chooseicon(obj.resultOBJ[i].pdrValue, 2) == 1) {//如果是图片
                                    tempstr = ' onclick="showmodal(\'' + obj.resultOBJ[i].pdrValue + '\')"';
                                    bianqian = "span"
                                } else {
                                    bianqian = "a"
                                    tempstr = "href='" + obj.resultOBJ[i].pdrValue + "' download='" + obj.resultOBJ[i].dRemark + "' target='_blank'"
                                }
                                cgstr += "<" + bianqian + " class='nowrap' " + tempstr + " fileName='" + temp + "' s_type='3'  s_id='" + obj.resultOBJ[i].id + "'>&nbsp&nbsp<span class='" + chooseicon(obj.resultOBJ[i].pdrValue, 1) + "'></span>&nbsp;" + obj.resultOBJ[i].dRemark + "&nbsp;<span class='glyphicon glyphicon-remove red' onclick='delimg(" + obj.resultOBJ[i].id + ",this,null)'></span></" + bianqian + ">";
                                var temparray = { ID: obj.resultOBJ[i].id, F_ID: 0, U_ID: userInfo_cookie.id, FILE_NAME: obj.resultOBJ[i].dRemark, FILE_URL: obj.resultOBJ[i].pdrValue }
                                imglist.push(temparray)
                            } else if (obj.resultOBJ[i].tpId == 4) {//现场图片
                                var temp = "";
                                temp = obj.resultOBJ[i].pdrValue;
                                temp = temp.substr(temp.lastIndexOf('/') + 1);
                                var tempstr = "";
                                var bianqian = "";
                                if (chooseicon(obj.resultOBJ[i].pdrValue, 2) == 1) {//如果是图片
                                    tempstr = ' onclick="showmodal(\'' + obj.resultOBJ[i].pdrValue + '\')"';
                                    bianqian = "span"
                                } else {
                                    bianqian = "a"
                                    tempstr = "href='" + obj.resultOBJ[i].pdrValue + "' download='" + obj.resultOBJ[i].dRemark + "' target='_blank'"
                                }
                                xcstr += "<" + bianqian + "  " + tempstr + " class='nowrap' fileName='" + temp + "' s_type='5'  s_id='" + obj.resultOBJ[i].id + "'><span class='" + chooseicon(obj.resultOBJ[i].pdrValue, 1) + "'></span>&nbsp;" + obj.resultOBJ[i].dRemark + "&nbsp;<span class='glyphicon glyphicon-remove red' onclick='delimg(" + obj.resultOBJ[i].id + ",this,null)'></span></" + bianqian + ">";
                                var temparray = { ID: obj.resultOBJ[i].id, F_ID: 0, U_ID: userInfo_cookie.id, FILE_NAME: obj.resultOBJ[i].dRemark, FILE_URL: obj.resultOBJ[i].pdrValue}
                                imglist.push(temparray)
                            } else if (obj.resultOBJ[i].tpId == -1) {
                                $("#zrw").removeClass("hidden");
                                $("#s_projectname").html(obj.resultOBJ[i].pdrValue);
                            }
                        }

                        $("#ys_label").html(ysstr);
                        $("#xc_label").html(xcstr);
                        $("#cg_label").html(cgstr);
                    } else {
                        $.alert(obj.ResultMsg);
                    }
                }, function (obj) {
                    $.alert("请求失败");
                }, 0)
            } else if (state == 0) {//未反馈
                $("#shangbao").addClass('hidden');
                $("#fankui").removeClass('hidden');
                $("#fk_detail").addClass('hidden');
                $("#report").show();
                $("#qualitylist").hide();
                reply.PC_ID = ID;
                reply.PS_ID = ps_id
                reply.R_ID = r_id;
                reply.P_ID = P_ID;

            } else if (state == -1) {//已反馈
                selectreply(ID);
            }
        }
        function selectreply(pc_id) {
            var url = 'user/Selectreplybyid_';
            var result = '{"PC_ID":' + pc_id + '}';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    $("#report").show();
                    $("#qualitylist").hide();
                    $("#shangbao").addClass('hidden');
                    $("#fankui").addClass('hidden');
                    $("#fk_detail").removeClass('hidden');
                    $("#fk_content").html(obj.ResultOBJ.R_CONTENT);
                    var str = "";
                    if (obj.ResultOBJ.R_FILE == null) {
                        obj.ResultOBJ.R_FILE = "";
                        obj.ResultOBJ.R_REMARK = "";
                        str += "<span>暂无文件</span>"
                    } else {
                        var file = obj.ResultOBJ.R_FILE.split('#');
                        var name = obj.ResultOBJ.R_REMARK.split('#');


                        for (var i = 0; i < file.length; i++) {
                            var tempstr = "";
                            if (chooseicon(name[i], 2) == 1) {
                                tempstr = ' onclick="showmodal(\'' + file[i] + '\')"';
                            }
                            str += "<span " + tempstr + " class='nowrap' s_type='5'>&nbsp&nbsp<span class='" + chooseicon(file[i], 1) + "'></span>&nbsp;" + name[i] + "&nbsp;</span>";
                        }
                    }
                    $("#fk_file").html(str);

                }
            })

        }
        function listshow() {
            $("#report").hide();
            $("#qualitylist").show();
            $("#ys_label").html("");
            $("#xc_label").html("");
            $("#cg_label").html("");
            $("#shuoming").addClass('hidden');
            $("#reportremark").val("");
            $("[type=radio]:eq(1)").attr("checked", "checked");
            $("#yichang").addClass('hidden');
            $("#yichang").val("");
            $('#myTab a:first').tab('show');
            $("#zrw").addClass("hidden");
            $("#s_projectname").html("");
            $("#fujian").html("");
            $("#R_CONTENT").val("");
            $("#wjlabel").html("");
            getlist(1)
        }
        //上报反馈详情
        function check_detail(id) {
            var url = 'getCheck?id='+id;
            var result = '';
            FuncAjax(url, result, function (obj) {
                if (obj.resultCode == 0) {
                    //回显分数
                    Detail_Date = obj.resultOBJ
                    if (Detail_Date.pcState == 3) {//打回
                        $("#fenshu").html("已打回");
                    } else {
                        $("#fenshu").html(Detail_Date.fraction);
                    }
                    //回显附件
                    $.ajax({
                        url:"getRecords",
                        type:"Post",
                        data:{"id":id},
                        success:function(objs){
                            Detail_Dates=objs.resultOBJ;
                            var temp = "";
                            if (objs.resultCode==0) {
                                for (var i = 0; i < Detail_Dates.length; i++) {
                                    var tempstr = "";
                                    var biaoqian=""
                                    if (chooseicon(Detail_Dates[i].crRemark, 2) == 1) {
                                        tempstr = ' onclick="showmodal(\'' + Detail_Dates[i].value + '\')"';
                                        biaoqian = "span";
                                    } else {
                                        biaoqian = "a";
                                        tempstr = 'href="' + Detail_Dates[i].value + '" download="' + Detail_Dates[i].crRemark + '" target="_blank"';
                                    }
                                    temp += '<span class="nowrap"  filename="' + Detail_Dates[i].crRemark + '">&nbsp;&nbsp;<'+ biaoqian +' ' + tempstr + '><span class="' + chooseicon(Detail_Dates[i].crRemark, 1) + '"></span>&nbsp;' + Detail_Dates[i].crRemark + '&nbsp;&nbsp;<'+biaoqian +'></span>';
                                }
                                if (temp == "") {
                                    temp = "无文件"
                                    $("#fujianurl").hide();;
                                } else {
                                    $("#fujianurl").show();;
                                }
                                $("#fujian").html(temp);
                            }else{
                                if (temp == "") {
                                    temp = "无文件"
                                    $("#fujianurl").hide();;
                                } else {
                                    $("#fujianurl").show();;
                                }
                                $("#fujian").html(temp);
                            }
                        }
                    });
                    //回显意见
                    $("#yijian").html(Detail_Date.remark);
                } else {
                    $.alert(obj.resultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");
            }, 0)

        }
        function showmodal(url, temp) {
            modalinfo.body = '<img src="' + url + '" class="img-responsive" />';
            modalinfo.title = "图片预览";
            if (temp != undefined) {
                modalinfo.footer = '<a href="/' + url + '" download="' + temp + '"><i class="file-excel-o"></i><button type="button" class="btn btn-primary" >下载</button></a>&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>'
            }
            modalinfo.initial();
            modalinfo.show();
        }
        var project = { PLAN_IS: -1, R_IS: -1, S_IS: -1, ID: -1, P_PROGRESS: "", F_IS: 0 }
        var projectData
        function addproject() {
            var file = "";
            if ($(".progress-bar:hidden").length != 4) {//未上传完文件
                $.alert("文件正在上传");
                return;
            }
            file = ',"file":['
            if ($("span[name=new]").length > 0) {

                for (var i = 0; i < $("span[name=new]").length; i++) {
                    if (i != 0) {
                        file += ","
                    }
                    file += ' {"ID":-1,"F_ID":' + $("span[name=new]:eq(" + i + ")").attr("s_type") + ',"U_ID":' + userInfo_cookie.ID + ',"FILE_NAME":"' + $("span[name=new]:eq(" + i + ")").attr("filename") + '","FILE_URL":"' + $("span[name=new]:eq(" + i + ")").attr("s_id") + '"}';
                }
            }
            if (imglist.length != 0) {
                if (file.indexOf('{') > -1) {
                    file += "," + JSON.stringify(imglist).replace('[', '').replace(']', '')
                } else {
                    file += JSON.stringify(imglist).replace('[', '').replace(']', '')
                }
            }
            file += ']'
            project.P_NUMBER = P_ID_ID;
            project.PLAN_IS = R_ID_ID;
            project.R_IS = R_IS_ID;
            project.S_IS = S_IS_ID;
            project.F_IS = ceckedid;
            project.P_PROGRESS = $("#Projectschedule").val();
            var result = '{"F_TYPE":"' + $("#yichang").val() + '","TYPE":"' + $("#reportremark").val() + '","project":' + JSON.stringify(project) + file + '}';
            if (result != "") {
                var url = 'user/SubmitReport';
                FuncAjax(url, result, function (obj) {
                    if (obj.ResultCode == 0) {
                        $.hideLoading();
                        $.alert("成功", "提示", function () {
                            location.reload();
                        })
                    } else {
                        $.alert(obj.ResultMsg);
                    }
                }, function (obj) {
                    $.alert("请求失败");
                })
            }
        }
        //删除上传文件
        function delimg(id, e, data) {
            if (id == 0) {
                $(e).parent().remove();
            } else {
                $(e).parent().remove();
                for (var i = 0; i < imglist.length; i++) {
                    if (imglist[i].ID == id) {
                        imglist[i].F_ID = -1;
                    }
                }
            }
        }
        //上传图片
        function upload(type, fileName) {
            $this = $(this);
            var options = {
                type: 'post',
                url: 'UploadFile.ashx',
                dataType: "json",
                timeout: 600000,
                success: function (obj) {
                    $this.removeClass("btn-default").addClass("btn-primary");
                    var str = "";
                    var filenewnamelist = obj.ResultOBJ.split('&&');
                    var fileoldnamelist = obj.ResultMsg.split('&&');
                    for (var i = 0; i < filenewnamelist.length; i++) {
                        var tempstr = "";
                        if (chooseicon(filenewnamelist[i], 2) == 1) {
                            tempstr = ' onclick="showmodal(\'Project/Temporary/' + filenewnamelist[i] + '\',\'' + fileoldnamelist + '\')"';
                        }
                        str += "<span class='nowrap' fileName='" + fileoldnamelist[i] + "' s_type='" + type + "' name='new' s_id='" + filenewnamelist[i] + "'>&nbsp&nbsp<span " + tempstr + " ><span class='" + chooseicon(fileoldnamelist[i], 1) + "'></span>&nbsp;" + fileoldnamelist[i] + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(0,this,null)></span></span>";
                    }
                    if (type == 2) {
                        $("#ys_label").html($("#ys_label").html() + str);
                    } else if (type == 3) {
                        $("#cg_label").html($("#cg_label").html() + str);
                    } else if (type == 5) {
                        $("#xc_label").html($("#xc_label").html() + str);
                    }
                    else if (type == 6) {
                        $("#wjlabel").html($("#wjlabel").html() + str);
                    }
                    $(".progress-bar").attr("style", "min-width: 2em; width: 0%;");
                    $(".progress-bar").text("0%");
                    $(".progress-bar").parent().hide();

                },
                error: function (obj) {
                    alert("上传超时");
                },complete : function(XMLHttpRequest,status){ //请求完成后最终执行参数
                    if(status=='timeout'){//超时,status还有success,error等值的情况
                        console.log("上传超时");

                    }
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    $(".progress-bar").parent().show();
                    var prog = ((position / total).toFixed(2) * 100).toFixed(0);
                    $(".progress-bar").attr("style", "min-width: 2em; width: " + prog + "%;");
                    $(".progress-bar").text(prog + "%")

                }
            };
            if (type == 2) {
                $("#up_yuanshi").ajaxSubmit(options);
            } else if (type == 3) {
                $("#up_guocheng").ajaxSubmit(options);
            } else if (type == 5) {
                $("#up_xianchang").ajaxSubmit(options);

            } else if (type == 6) {
                $("#wjfrom").ajaxSubmit(options);
            }
        }
        var reply = { ID: -1, P_ID: 0, PS_ID: 0, R_ID: 0, PC_ID: 0, R_TYPE: 0, R_CONTENT: "", R_REMARK: "", R_FILE: "", U_STATE: 0, U_ID: 0 }
        //提交反馈
        function addreply() {
            if ($("#R_CONTENT").val() == "") {
                $.alert("请填写反馈内容");
                return
            }
            reply.R_CONTENT = $("#R_CONTENT").val();
            reply.U_ID = userInfo_cookie.ID;
            reply.R_FILE = ""
            reply.R_REMARK = "";
            if ($(".progress-bar:hidden").length != 4) {//未上传完文件
                $.alert("文件正在上传");
                return;
            }
            if ($("#wjlabel span[name=new]").length > 0) {

                for (var i = 0; i < $("#wjlabel span[name=new]").length; i++) {
                    if (i != 0) {
                        reply.R_FILE += "#"
                        reply.R_REMARK += "#"
                    }
                    reply.R_FILE += $("span[name=new]:eq(" + i + ")").attr("s_id")
                    reply.R_REMARK += $("#wjlabel span[name=new]:eq(" + i + ")").attr("filename");

                }
            }
            var result = JSON.stringify(reply);
            var url = 'user/addreply';
            FuncAjax(url, result, function (obj) {
                if (obj.ResultCode == 0) {
                    $.hideLoading();
                    $.alert("添加成功", "提示", function () {
                        listshow()
                    })
                } else {
                    $.alert(obj.ResultMsg);
                }
            }, function (obj) {
                $.alert("请求失败");
            })

        }
    </script>
    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
        .aa{
            background:#bfbfff;
        }
        .bb{
            cursor:pointer;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-top_20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="qualitylist">
                <div class="col-sm-12">
                </div>
                <h3>上报反馈</h3>
                <div class="col-sm-12 ">
                    <table id="tb_departments" style="table-layout:fixed" class="table table-bordered table-hover text-center"></table>
                </div>
                <div class="text-center" id="page">
                </div>

            </div>
            <div class="row" id="report">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="listshow()"><span class="glyphicon glyphicon-home"style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
                </div>

                <div class="col-sm-12 ">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">上报反馈</h3>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal" id="check_detail">
                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 " for="tel">分数：</label>
                                    <div class="col-sm-4 text-left " id="fenshu">
                                    </div>
                                    <label class="col-sm-1 " for="">附件：</label>

                                    <div class="col-sm-5 text-left " id="fujian">
                                    </div>

                                </div>
                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 " for="tel">意见：</label>
                                    <div class="col-sm-8 text-left " id="yijian">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default hidden" id="shangbao">
                        <div class="panel-heading">
                            <h3 class="panel-title">上报</h3>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal ">
                                <div class="form-group has-primary hidden" id="zrw">
                                    <label class="col-sm-2 control-label" for="name">子任务：</label>
                                    <div class="col-sm-6 text-left " id="s_projectname">
                                    </div>
                                </div>
                                <div class="form-group has-primary" id="">
                                    <div class="col-sm-offset-2 col-sm-8" id="worklist">
                                    </div>
                                </div>
                                <div class="form-group has-primary">
                                    <label class="col-sm-2 control-label" for="name">工程进度：</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="Projectschedule"
                                               placeholder="请输入工程进度（百分比）">
                                    </div>
                                </div>
                                <div class="form-group has-primary">
                                    <label class="col-sm-2 control-label" for="name">异常说明：</label>
                                    <div class="col-sm-2" style="text-align: left;">
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
                                               placeholder="请输入异常说明" s_id="">
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
                                                        <input type="file" id="File2" style="display: inline-block;cursor:pointer;" name="file" multiple="multiple" />选择
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
                    <div class="panel panel-default hidden" id="fankui">
                        <div class="panel-heading">
                            <h3 class="panel-title">反馈</h3>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal ">
                                <div class="form-group has-primary hidden">
                                    <label class="col-sm-2 control-label" for="name">子任务：</label>
                                    <div class="col-sm-6 text-left text-primary" id="Div2">
                                    </div>
                                </div>
                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 " for="name">文件：</label>
                                    <div class="col-sm-8">
                                        <div class="progress pull-left" style="width: 100px">
                                            <div class="progress-bar col-sm-2 " role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                            </div>
                                        </div>
                                        <div id="wjlabel" class="col-sm-8"></div>
                                        <form id="wjfrom" surl="" class="file pull-right col-sm-2">
                                            <input type="file" id="wenjian" style="display: inline-block;" name="file" multiple="multiple" />选择
                                        </form>

                                    </div>


                                </div>

                            </div>
                            <div class="form-group has-primary ">
                                <label class="col-sm-2 control-label" for="name">反馈内容：</label>
                                <div class="col-sm-8">
                                    <div class="form-group">
                                        <textarea class="form-control" rows="3" id="R_CONTENT"></textarea>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group has-success">
                                <div class="col-sm-6 col-sm-offset-3">
                                    <button type="button" class="btn btn-primary  btn-lg btn-block" onclick="addreply()">提交</button>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default hidden" id="fk_detail">
                        <div class="panel-heading">
                            <h3 class="panel-title">反馈</h3>
                        </div>
                        <div class="panel-body ">
                            <div class="form-horizontal ">
                                <div class="form-group has-primary hidden">
                                    <label class="col-sm-2 control-label" for="name">子任务：</label>
                                    <div class="col-sm-6 text-left text-primary" id="Div3">
                                    </div>
                                </div>
                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 " for="tel">文件：</label>
                                    <div class="col-sm-8 text-left text-primary" id="fk_file"></div>
                                </div>


                                <div class="form-group has-primary ">
                                    <label class="col-sm-2 " for="tel">反馈内容：</label>
                                    <div class="col-sm-8 text-left text-primary" id="fk_content"></div>
                                </div>

                                <div class="form-group has-success">
                                    <div class="col-sm-6 col-sm-offset-3">
                                        <button type="button" class="btn btn-primary  btn-lg btn-block" onclick="listshow()">返回</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div id="modal"></div>
</div>
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
                url: 'getChecks', //请求后台的URL（*）
                method: 'post', //请求方式（*）
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
                        field: 'pName',
                        title: '工程名称',
                    },{
                        field: 'pCaptain',
                        title: '负责人',
                    },{
                        field: 'uRName',
                        title: '质量检查人',
                    },{
                        field: 'fraction',
                        title: '分数',
                        formatter:fenshuFormatter,
                    },{
                        field: 'cTime',
                        title: '检查时间',
                        formatter:aaFormatter,
                    },{
                        field:'ID',
                        title: '操作',
                        width: 120,
                        align: 'center',
                        valign: 'middle',
                        formatter: actionFormatter
                    }],
                onLoadSuccess: function (data) {  //加载成功时执行
                    var s=data.rows;
                    $.each(s,function(i,val){
                        if(s[i].pcState==3){
                            getTdValue(i+1);
                        }
                    });
                }
            });
        };
        //分数栏格式化
        function fenshuFormatter(value,row,index){
            if(row.pcState==3){
                return "<strong>已打回</strong>"
            }
            return row.fraction;
        }
        //操作栏的格式化
        function actionFormatter(value, row, index) {
            return "<span onclick=\"filedata('" + row.id+ "','"+row.pcState+"','"+row.pSchedule+"')\" class='label label-primary' style='cursor:pointer;padding:5px 30px;'>查看</span>"
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
    //将已批准的数据改变背景颜色
    function getTdValue(index){
        //js版改变tr标签背景色
        var tableId = document.getElementById("tb_departments");
        tableId.rows[index].setAttribute("style","background: #bfbfff;");
        //jquery版改变tr标签背景色
        //$("tr:eq('"+index+"')").addClass("aa");
    }

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

