<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/22
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,Chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="X-UA-Compatible" content="IE=9" />
    <meta name="author" content="Jophy" />
    <meta name="renderer" content="webkit">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>查看工程</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="css/custom.css" rel="stylesheet" />
    <link href="css/showLoading.css" rel="stylesheet" />
    <link href="css/sign2.css" rel="stylesheet" />
    <link href="img/favicon.ico" rel="shortcut icon" />
    <link href="css/font-awesome.min.css" rel="stylesheet" />
    <script src="js/jquery-1.11.3.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.form.js"></script>
    <script src="js/jquery.showLoading.js"></script>
    <script src="js/calendar2.js"></script>
    <script src="js/common.js"></script>
    <script src="js/modal.js"></script>

    <script>
        var userInfo_cookie = null;

        $(function () {
            userInfo_cookie ={id:'${user.id}',uName:'${user.uName}',pwd:'${user.pwd}',issubpackage:'${user.issubpackage}',uState:'${user.uState}',uType:'${user.uType}',uTime:'${user.uTime}',uRName:'${user.uRName}'};
            if (userInfo_cookie.uName== '') {
                $.alert("请重新登录", "提示", function () {
                    location.href = "login";
                })
            }
            $.showLoading("请稍等");
            setTimeout(function () {
                $.hideLoading();
            }, 1000)
            $('#myTab a:first').tab('show');
            $('#myTab a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            })
            projectshow()
        })
        var change = 0;
        var projectData = null;

        function projectshow() {
            $("#P_NUMBER").text("${project.pNumber}");
            $("#Projectname").text("${project.pName}");
            $("#Project_address").text("${project.pAddress}");
            $("#Head").text("${project.pCaptain}");
            $("#P_SOURCE").text("${project.pSource}");
            //回显开始时间
            Date.prototype.toLocaleString = function() {
                return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() ;
            };
            var unixTimestamp = new Date( '${project.pStartTime}' ) ;
            commonTime = unixTimestamp.toLocaleString();
            $("#P_START_TIME").text(commonTime);
            //回显结束时间
            var unixTimestamp = new Date( '${project.pEndTime}' ) ;
            commonTime = unixTimestamp.toLocaleString();
            $("#P_END_TIME").text(commonTime);
            //回显工程类型
            var ss=["","工程测量","地理信息","房产测绘","地籍","规划测量","矿山测量","地下管线测量","控制测量","地形测量","建筑工程测量","变形与形变与精密测量","市政工程测量","线路与桥隧测量","地理信息系统工程","地理信息数据采集","地理信息数据处理","不动产测绘","房产测绘","地籍测绘",];
            $("#P_TYPE").text(ss['${project.pType}'])
            $("#P_F_TYPE").text(ss['${project.pFType}']);
            //上报记录数
            //$("#reportcount").html("(" + data.reportcount+ ")")
            if ('${project.fIs}' == 1) {
                $("[name=jiafang]").attr("checked", "checked");
                $("#jiafang").removeClass("hidden");
                $("#First_Party_name").text('${project.fName}')
                $("#First_Party_contact").text('${project.fCaptain}');
                $("#First_Party_phone").text('${project.fPhone}');
            }
            if ('${project.sIs}'== 1) {
                $("[name=fenbao]").attr("checked", "checked");
                $("#fenbao").removeClass("hidden");
                $("#Subpackage_company").text('${project.sName}');
                $("#Subpackage_contact").text('${project.sCaptain}');
                $("#Subpackage_phone").text('${project.sPhone}');
            }
            if ('${project.rIs}' == 1) {
                $("[name=guahao]").attr("checked", "checked");
                $("#guahao").removeClass("hidden");
                $("#R_NAME").text('${project.rName}');
                $("#R_CAPTAIN").text('${project.rCaptain}');
                $("#R_PHONE").text('${project.rPhone}');
            }
            $("#Project_summary").text('${project.pSummary}');
            $("#headname").text('${project.pCCaptain}');
            $("#Project_remarks").text('${project.pRemark}' == "" ? "暂无" : '${project.pRemark}');
            $("#Project_type_F").text('${project.pFType}' == 0 ? 1 : '${project.pFType}');
            $("#Project_Ttype_S").text('${project.pType}');

            var str = '';//回显前期文件
            $.ajax({
                url: 'getFiles?pNumber='+'${project.pNumber}',
                ansyc: 'false',
                type: 'Post',
                dataType: 'json',
                success: function (data) {
                    //注意：当data是json字符串时，需要将data转化成json对象
                    var haveFile=data.haveFile;
                    if(haveFile==1){
                        var arr=data.files;
                        var str = '';//前期文件
                        for (var i = 0; i < arr.length; i++) {
                            var tempstr = "";
                            var bianqian=""
                            if (chooseicon(arr[i].fileName, 2) == 1) {
                                bianqian = "span"
                                tempstr = ' onclick="showmodal(\''+ arr[i].fileUrl +'\')"';
                            } else {
                                bianqian = "a"
                                tempstr = "href='" + arr[i].fileUrl + "' download='" + arr[i].fileName + "' target='_blank'"
                            }

                            str += "<span style='cursor:pointer;margin-bottom:5px;' class='nowrap' fileName='" + arr[i].fileName + "'>&nbsp&nbsp<" + bianqian + " " + tempstr + "><span class='" + chooseicon(arr[i].fileName, 1) + "'></span>&nbsp;" + arr[i].fileName + "&nbsp;</" + bianqian + "></span>";
                        }
                        if (str == '') {
                            str += '<span>暂无</span>'
                        }
                        $("#qianqi_label").html(str);
                    }else{
                        var s = '<span style="color:red;"><h4><strong>暂无相关文件</strong></h4></span>'
                        $("#qianqi_label").html(s);
                    }
                }, error: function (data) {
                    //alert("error:" + JSON.stringify(data));
                }
            });

            //回显子任务
            $.ajax({
                url:'getSubtask?pNumber='+'${project.pNumber}',
                type:'Post',
                ansyc:'false',
                dataType:'json',
                success:function(data) {
                    var subtask = data.subtask;
                    var sked = data.sked;
                    var noSubtask = data.noSubtask;
                    var noSked=data.noSked;
                    if (noSubtask== 0) {//有子任务
                        var str = "";
                        c_projectarray = subtask;
                        for (var i = 0; i < subtask.length; i++) {
                            str += "<div  class='zirenwu ' c_id='cid_" + subtask[i].id + "' ><strong>" + subtask[i].sName + "&nbsp;&nbsp;</strong></div>";
                        }
                        $("#C_list").html(str);
                        if (noSked == 0) {//有工作计划
                            $("[name=jihua]").attr("checked", "checked");
                            $("#jihua").removeClass("hidden");
                            worklistarray = new Array();
                            c_worklistarray = new Array();
                            $(".errorcal").html("")
                            var temp = JSON.stringify(sked);
                            temp = temp.replaceAll("sYear", "signYear");
                            temp = temp.replaceAll("sMonth", "signMonth");
                            temp = temp.replaceAll("sDay", "signDay");
                            var a = eval('(' + temp + ')')
                            c_worklistarray = a;
                            workliststr();
                        }

                    } else {//无子任务
                        $("#C_list").html('<span style="color:red;"><strong>暂无子任务</strong></span>');
                        if (noSked == 0) {//有工作计划
                            $("#jihua").removeClass("hidden")
                            worklistarray = new Array();
                            c_worklistarray = new Array();
                            $(".errorcal").html("")
                            var temp = JSON.stringify(sked);
                            temp = temp.replaceAll("sYear", "signYear");
                            temp = temp.replaceAll("sMonth", "signMonth");
                            temp = temp.replaceAll("sDay", "signDay");
                            var a = eval('(' + temp + ')')
                            worklistarray = a;
                            workliststr()
                        }
                    }
                }
            });

        }
        function showmodal(url) {
            modalinfo.body = '<img src="/' + url + '" class="img-responsive" />';
            modalinfo.title = "图片预览"
            modalinfo.initial();
            modalinfo.show();
        }
        var worklistarray = new Array();
        function workliststr() {
            $("#worklist").html();
            var nowdate = new Date();
            var lilength = $("#C_list div").length
            if (lilength == 0) {
                signList = [];
                calUtil.eventName = "load"
                calUtil.drawstr = "#worklist"
                calUtil.init(worklistarray, false);
            } else {
                var str_ul = '';
                var count = 0;
                for (var i = 0; i < lilength; i++) {
                    if (i % 2 == 0) {
                        str_ul+="<div class='row'>"
                    }
                    str_ul += '<label class="col-sm-4 margin-top_6 " c_id="' + $("#C_list div:eq(" + i + ")").attr("c_id") + '">' + $("#C_list div:eq(" + i + ")").text() + '</label><div class="col-sm-2 margin-top_6"  c_id="' + $("#C_list div:eq(" + i + ")").attr("c_id") + '">';
                    if ($("#C_list div:eq(" + i + ")").attr("c_id") != null || $("#C_list div:eq(" + i + ")").attr("c_id") != undefined) {
                        if (checktask($("#C_list div:eq(" + i + ")").attr("c_id").split('_')[1])) {
                            str_ul += '<button class="btn btn-primary btn-sm" type="button" onclick="c_addc_jihua(\'' + $("#C_list div:eq(" + i + ")").attr("c_id") + '\')">查看计划</button>';
                        }
                    }
                    str_ul+='</div>';
                    if (i % 2 == 1) {
                        str_ul += "</div>"
                    }
                }

                $("#C_list").html(str_ul)
            }
        }
        ///检查该子任务id是否有计划
        function checktask(taskid) {
            var flag= false
            for (var i = 0; i < c_worklistarray.length; i++) {
                if (c_worklistarray[i].SIGN == taskid) {
                    if (c_worklistarray[i].LIST.length > 0) {
                        flag = true;
                    }
                }
            }
            return flag;
        }
        var jihuadate = new Array();
        var c_worklistarray = Array();
        function c_addc_jihua(data) {
            var nowdate = new Date();
            var num = data.split('_')[1]
            var list = [];
            var inum = -1;
            for (var i = 0; i < c_worklistarray.length; i++) {
                if (c_worklistarray[i].SIGN == num) {
                    list = c_worklistarray[i].LIST;
                    inum = i;
                    break;
                }
            }
            var str = '<div><span class="red errorcal"></span><div id="modal_cal"></div></div>'
            $.modal({
                title: "子任务作业计划",
                text: str,
                buttons: [
                    {
                        text: "取消", onClick: function () {
                            $(".errorcal").html("")
                        }
                    },
                    {
                        text: "确定", onClick: function () { //提交

                            if (inum == -1) {
                                var a = { SIGN: num, LIST: list }
                                c_worklistarray.push(a);
                            } else {
                                c_worklistarray[inum].LIST = list;
                            }
                        }
                    }]
            })
            calUtil.eventName = "load"
            calUtil.drawstr = "#modal_cal";
            calUtil.init(list, false);
        }
        function showreportlist() {
            location.href="reportlist.html?index="+projectData.project.P_NUMBER
        }
        function fanhui(){
            var page='${page}';
            location.href="Home_page?pages="+page;
        }
    </script>
</head>
<body>
<div class="container-fluid margin-20">
    <p class="pull-left  label label-primary" onclick="fanhui();"><span class="glyphicon glyphicon-home"style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
    <div class="row">
        <div class="col-sm-12 ">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">查看工程</h3>
                </div>
                <div class="panel-body ">
                    <div class="form-horizontal ">
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">工程编号：</label>
                            <div class="col-sm-3">
                                <label class="control-label" id="P_NUMBER"></label>
                            </div>
                            <label class="col-sm-2 control-label" for="tel">工程来源：</label>
                            <div class="col-sm-3">
                                <label id="P_SOURCE" class="control-label"></label>

                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">工程名称：</label>
                            <div class="col-sm-8">
                                <label id="Projectname" class="control-label"></label>
                            </div>


                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="tel">工程地点：</label>
                            <div class="col-sm-8">
                                <label id="Project_address" class="control-label"></label>
                            </div>
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">工程类型：</label>
                            <div class="col-sm-3">
                                <label class="control-label" id="P_TYPE"></label>
                            </div>
                            <label class="col-sm-2 control-label" for="profession">工程子类型：</label>
                            <div class="col-sm-3">
                                <label class="control-label" id="P_F_TYPE"></label>
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">开始时间：</label>
                            <div class="col-sm-3">
                                <label id="P_START_TIME" class="control-label"></label>
                            </div>
                            <label class="col-sm-2 control-label" for="profession">结束时间：</label>
                            <div class="col-sm-3">
                                <label id="P_END_TIME" class="control-label"></label>
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">项目负责人：</label>
                            <div class="col-sm-3">
                                <label id="Head" class="control-label"></label>
                            </div>
                            <label class="col-sm-2 control-label" for="headname">负责人电话：</label>
                            <div class="col-sm-3">
                                <label id="headname" class="control-label"></label>
                            </div>
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">子任务：</label>
                            <div class="col-sm-8">

                                <div  id="C_list" >
                                </div>
                            </div>
                        </div>
                        <div id="jiafang" class="hidden">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">甲方名称：</label>
                                <div class="col-sm-8">
                                    <label id="First_Party_name" class="control-label"></label>
                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">甲方联系人：</label>
                                <div class="col-sm-3">
                                    <label id="First_Party_contact" class="control-label"></label>

                                </div>
                                <label class="col-sm-2 control-label" for="name">甲方电话：</label>
                                <div class="col-sm-3">
                                    <label id="First_Party_phone" class="control-label"></label>

                                </div>
                            </div>
                        </div>
                        <div id="fenbao" class="hidden">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">协作单位：</label>
                                <div class="col-sm-8">
                                    <label id="Subpackage_company" class="control-label"></label>

                                </div>

                            </div>

                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">协作负责人：</label>
                                <div class="col-sm-3">
                                    <label id="Subpackage_contact" class="control-label"></label>

                                </div>
                                <label class="col-sm-2 control-label" for="name">协作负责人电话：</label>
                                <div class="col-sm-3">
                                    <label id="Subpackage_phone" class="control-label"></label>

                                </div>
                            </div>
                        </div>
                        <div id="guahao" class="hidden">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">合作单位：</label>
                                <div class="col-sm-8">
                                    <label id="R_NAME" class="control-label"></label>

                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">合作负责人：</label>
                                <div class="col-sm-3">
                                    <label id="R_CAPTAIN" class="control-label"></label>

                                </div>
                                <label class="col-sm-2 control-label" for="name">合作负责人电话：</label>
                                <div class="col-sm-3">
                                    <label id="R_PHONE" class="control-label"></label>

                                </div>
                            </div>
                        </div>
                        <div id="jihua" class="hidden">
                            <div class="form-group has-primary">

                                <div class="col-sm-offset-2 col-sm-8">
                                    <span class="red errorcal text-center"></span>
                                    <div style="" id="worklist"></div>
                                </div>
                            </div>
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="tel">工程概述：</label>
                            <div class="col-sm-8">
                                <label id="Project_summary" ></label>
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="tel">备注：</label>
                            <div class="col-sm-8">
                                <label id="Project_remarks" style="color:red;"></label>
                            </div>
                        </div>
                        <div class="form-group has-primary ">
                            <label class="col-sm-2 control-label" for="tel">上传资料：</label>
                            <ul class="nav nav-tabs col-sm-8" id="myTab">
                                <li class="active "><a href="#home" class="text-primary">前期资料</a></li>
                                <li class="pull-right"><button type="button" class="btn btn-primary btn-sm" onclick="showreportlist()">上报记录<span id="reportcount"></span></button></li>
                            </ul>

                            <div class="tab-content has-primary col-sm-offset-2 col-sm-8" style="border-bottom: 1px solid #d6e9c6; border-left: 1px solid #d6e9c6; border-right: 1px solid #d6e9c6;">
                                <div class="tab-pane active list-group " id="home">
                                    <br />
                                    <div class="list-group ">
                                        <div id="qianqi_label" style="text-align:center;"></div>
                                    </div>
                                    <br />

                                </div>
                                <div class="tab-pane list-group " id="profile">
                                    <br />
                                    <label class="col-sm-4 control-label" for="idCard">上传甲方提供资料：</label>
                                    <div class="col-sm-2">
                                        <form id="up_guocheng" surl="">
                                            <input type="file" id="" style="display: inline-block;" name="file">
                                        </form>
                                    </div>
                                    <div class="col-sm-2 pull-right">
                                        <button class="btn btn-primary btn-sm" type="button" onclick="upload(1)">上传</button>
                                    </div>
                                    <br />
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
</body>
</html>

