<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2019/1/9
  Time: 10:21
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
    <title>编辑工程</title>
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
    <script src="js/calendar2.js?dc=3"></script>
    <script src="js/common.js"></script>
    <script src="js/modal.js"></script>
    <script src="js/laydate.dev.js"></script>
    <script>

        $(function () {

            //判断用户是否登录
            var s="${userName}";
            if(s==""){
                $.alert("请重新登录", "提示", function () {
                    parent.location.href = "login";
                })
            }
            get_p_type(0);
            get_p_type(1);
            $.showLoading("请稍等");
            setTimeout(function () {
                $.hideLoading();
            }, 1000)
            $('#myTab a:first').tab('show');
            $('#myTab a').click(function (e) {
                e.preventDefault();
                $(this).tab('show');
            })

            projectshow();

            $("#Project_type_F").change(function () {
                get_p_type($(this).val());
            })
            //上传文件
            $("#up_wendang.file").on("change", "input[type='file']", function () {
                var filePath = $(this).val();
                $(".fileerrorTip").html("").hide();
                var arr = filePath.split('\\');
                var fileName = arr[arr.length - 1];
                upload(0, fileName);
                $(this).val("");
            })
            $("#prog").parent().hide();
            laydate({
                elem: '#P_END_TIME'
            });
            laydate({
                elem: '#P_START_TIME'
            });
        })

        function upload(type, fileName) {
            $this = $(this);
            var filePaths="Project/"+$("#ziliao").text()+"/"+$("#P_NUMBER").val();
            var options = {
                type: 'post',
                url: 'upload?filePaths='+filePaths,
                dataType: "json",
                success: function (obj) {
                    var filepath=obj.filePath;
                    $this.removeClass("btn-default").addClass("btn-primary");
                    if (type == 0) {
                        $("#up_wendang").attr("surl", obj.resultOBJ);
                        var str = "";
                        var filenewnamelist = obj.resultOBJ.split('&&');
                        var fileoldnamelist = obj.resultMsg.split('&&');
                        var filestr = "";
                        for (var i = 0; i < filenewnamelist.length; i++) {
                            var tempstr = "";
                            if (chooseicon(filenewnamelist[i], 2) == 1) {
                                tempstr = ' onclick="showmodal(\'' + filenewnamelist[i] + '\')"';
                                str += "&nbsp&nbsp&nbsp&nbsp<span class='nowrap' style='margin-bottom:5px;cursor:pointer;' fileName='" + fileoldnamelist[i] + "' name='new' sid='"+filenewnamelist[i] +"' fState='" + 0 + "'>&nbsp&nbsp<span " + tempstr + "><span class='" + chooseicon(filenewnamelist[i], 1) + "'></span>&nbsp;" + fileoldnamelist[i] + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(0,this,'"+filepath+"')></span></span>";
                            }else {
                                str += "&nbsp&nbsp&nbsp&nbsp<span class='nowrap' style='margin-bottom:5px;'  fileName='" + fileoldnamelist[i] + "' name='new' sid='" + filenewnamelist[i] + "' fState='" + 0 + "'>&nbsp&nbsp<span " + tempstr + "><span class='" + chooseicon(filenewnamelist[i], 1) + "'></span>&nbsp;" + fileoldnamelist[i] + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(0,this,'" + filepath + "')></span></span>";
                            }
                        }
                        str = $("#qianqi_label").html() + str;
                        $("#qianqi_label").html(str);
                        $("#prog").attr("style", "min-width: 2em; width: 0%;");
                        $("#prog").text("0%");
                        $("#prog").parent().hide();
                    }
                },
                error: function (obj) {
                    alert(0);
                },
                uploadProgress: function (event, position, total, percentComplete) {
                    $("#prog").parent().show();
                    var prog = ((position / total) * 100).toFixed(0);
                    $("#prog").attr("style", "min-width: 2em; width: " + prog + "%;");
                    $("#prog").text(prog + "%")

                }
            };
            if (type == 0) {
                $("#up_wendang").ajaxSubmit(options);
            } else if (type == 1) {
                $("#up_guocheng").ajaxSubmit(options);
            }
        }
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
                            $("#Project_type_F").html(str);
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
        function addproject() {
            var results = addProjectyanzheng();
            var result=JSON.parse(results);
            var temp=JSON.stringify(result);
            alert(temp);
            if (temp != "") {
                var url = 'updateAddProject';
                FuncAjaxs(url, temp, function (obj) {
                    if (obj.resultCode == 0) {
                        $.alert("修改成功", "提示", function () {
                            location.reload();
                        })
                    } else {
                        $.alert(obj.resultMsg);
                    }
                }, function (obj) {
                    $.alert("请求失败");
                }, 1)
            }
        }
        function projectshow() {
            $("#Projectname").val("${project.pName}");
            $("#Project_address").val("${project.pAddress}");
            $("#Head").val("${project.pCaptain}");
            $("#P_NUMBER").val("${project.pNumber}")
            $("#P_SOURCE").val("${project.pSource}");
            //回显开始时间
            Date.prototype.toLocaleString = function() {
                return this.getFullYear() + "-" + (this.getMonth() + 1) + "-" + this.getDate() ;
            };
            var unixTimestamp = new Date( '${project.pStartTime}' ) ;
            commonTime = unixTimestamp.toLocaleString();
            $("#P_START_TIME").val(commonTime)
            //回显结束时间
            var unixTimestamp = new Date( '${project.pEndTime}' ) ;
            commonTime = unixTimestamp.toLocaleString();
            $("#P_END_TIME").val(commonTime)

            $("#First_Party_name").val("${project.fName}");
            $("#First_Party_contact").val("${project.fCaptain}");
            $("#First_Party_phone").val("${project.fPhone}");
            if ("${project.sIs}" == 1) {
                $("[name=fenbao]").attr("checked", "checked");
                $("#fenbao").removeClass("hidden");
                $("#Subpackage_company").val("${project.sName}");
                $("#Subpackage_contact").val("${project.sCaptain}");
                $("#Subpackage_phone").val("${project.sPhone}");
            }
            if ("${project.rIs}" == 1) {
                $("[name=guahao]").attr("checked", "checked");
                $("#guahao").removeClass("hidden");
                $("#R_NAME").val("${project.rName}");
                $("#R_CAPTAIN").val("${project.rCaptain}");
                $("#R_PHONE").val("${project.rPhone}");
            }
            $("#Project_summary").val("${project.pSummary}");
            $("#headname").val("${project.pCCaptain}");
            if("${project.pRemark}"==""){
                $("#Project_remarks").val("暂无备注");
                $("#Project_remarks").css("color","red");
            }else{
                $("#Project_remarks").val("${project.pRemark}");
                $("#Project_remarks").css("color","red");
            }

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
                        for (var i = 0; i < arr.length; i++) {
                            var tempstr = "";
                            if (chooseicon(arr[i].fileName, 2) == 1) {
                                tempstr = ' onclick="showmodal(\''+ arr[i].fileUrl +'\')"';
                                str += "<span name='new' style='cursor:pointer;margin-bottom:5px;' class='nowrap' fileName='" + arr[i].fileName + "' sid='" + arr[i].fileUrl + "' fState='" + arr[i].fState + "'>&nbsp&nbsp<span " + tempstr + "><span class='" + chooseicon(arr[i].fileName, 1) + "'></span>&nbsp;" + arr[i].fileName + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(" + arr[i].id + ",this,null)></span></span>";
                            }else{
                                str += "<span name='new' style='margin-bottom:5px;' class='nowrap' fileName='" + arr[i].fileName + "' sid='" + arr[i].fileUrl + "' fState='" + arr[i].fState + "'>&nbsp&nbsp<span " + tempstr + "><span class='" + chooseicon(arr[i].fileName, 1) + "'></span>&nbsp;" + arr[i].fileName + "&nbsp;</span><span class='glyphicon glyphicon-remove red' onclick=delimg(" + arr[i].id + ",this,null)></span></span>";
                            }
                        }
                        $("#qianqi_label").html(str);
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
                success:function(data){
                    var subtask=data.subtask;
                    var sked=data.sked;
                    var noSubtask=data.noSubtask;
                    if (noSubtask==0) {//有子任务
                        $("[name=zirenwu]:eq(1)").prop("checked", "checked")
                        var str = "";
                        for (var i = 0; i < subtask.length; i++) {
                            str += "<li class='zirenwu' c_id='" + subtask[i].id + "' >" + subtask[i].sName + "&nbsp;&nbsp;<span class='glyphicon glyphicon-remove red' onclick=delimg(-1,this,null)></span></li>";
                        }
                        $("#C_list").html(str);

                        if (typeof sked!="undefined") {//有工作计划
                            var flag = true;
                            if (flag) {
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
                                workliststr()
                            }
                        }
                    } else {//无子任务
                        var sked=data.sked;
                        zirenwu_div(false);
                        if (typeof sked!="undefined") {//有工作计划
                            $("[name=jihua]").attr("checked", "checked");
                            $("#jihua").removeClass("hidden")
                            worklistarray = new Array();
                            c_worklistarray = new Array();
                            $(".errorcal").html("")
                            var temp = JSON.stringify(sked);
                            temp = temp.replaceAll("sYear", "signYear");
                            temp = temp.replaceAll("sMonth", "signMonth");
                            temp = temp.replaceAll("sDay", "signDay");
                            var a = eval('(' + temp + ')');
                            worklistarray = a;
                            workliststr()
                        }
                    }
                },
                error:function(data){
                    alert("请求失败");
                }
            });

        }
        function showmodal(url) {

            modalinfo.body = '<img src="/' + url + '" class="img-responsive" />';
            modalinfo.title = "图片预览"
            modalinfo.initial();
            modalinfo.show();
        }
        function addProjectyanzheng() {
            var c_projectstr = "";
            var zuoyejihua = "";
            var len=parseInt($("[name=zirenwu]:checked").val())
            if (len!=0) {//有子任务
                for(var i=0;i<c_projectarray.length;i++){
                    c_projectarray[i].sState=0;
                    c_projectarray[i].pId="${project.pNumber}";
                }
                c_projectstr = ',"subtask":' + JSON.stringify(c_projectarray);
                if ($("input[name=jihua]:checked").length == 1) {//有作业计划
                    zuoyejihua = ',"sked":' + JSON.stringify(c_worklistarray);
                    zuoyejihua = zuoyejihua.replaceAll("signYear", "sYear");
                    zuoyejihua = zuoyejihua.replaceAll("signMonth", "sMonth");
                    zuoyejihua = zuoyejihua.replaceAll("signDay", "sDay");
                }
            } else {//无子任务
                c_projectstr = ',"subtask":[]';
                if ($("input[name=jihua]:checked").length == 1) {//有作业计划
                    var temp = new Array();
                    for (var i = 0; i < worklistarray.length; i++) {
                        var id=-1;
                        if(worklistarray[i].id>0){
                            id=worklistarray[i].id;
                        }
                        var tempdata = {id:id,pId:"${project.pNumber}",sState:worklistarray[i].sState, sYear: worklistarray[i].signYear, sMonth: worklistarray[i].signMonth, sDay: worklistarray[i].signDay }
                        temp.push(tempdata);
                    }
                    zuoyejihua = ',"sked":' + JSON.stringify(temp);
                }else{
                    zuoyejihua = ',"sked":[]';
                }
            }
            if ($("#P_NUMBER").val().trim() == "") {
                $.alert("请填写工程编号");
                return "";
            }
            if ($("#Projectname").val().trim() == "") {
                $.alert("请填写工程名称");
                return "";
            }
            if ($("#Project_address").val().trim() == "") {
                $.alert("请填写工程地点");
                return "";
            }
            if ($("#Head").val().trim() == "") {
                $.alert("请填写工程负责人");
                return "";
            }
            if ($("#P_SOURCE").val().trim() == "") {
                $.alert("请填写工程来源");
                return "";
            }
            var p_str = ""

            if ($("#First_Party_name").val().trim() == "") {
                $.alert("请填写甲方名称");
                return "";
            }
            if ($("#First_Party_contact").val().trim() == "") {
                $.alert("请填写甲方负责人");
                return "";
            }
            if ($("#First_Party_phone").val().trim() == "") {
                $.alert("请填写甲方电话");
                return "";
            }
            p_str += '"fIs":1,"fName":"' + $("#First_Party_name").val().trim() + '","fCaptain":"' + $("#First_Party_contact").val().trim() + '","fPhone":"' + $("#First_Party_phone").val().trim() + '",'

            if ($("input[name=fenbao]:checked").length == 1) {
                if ($("#Subpackage_company").val().trim() == "") {
                    $.alert("请填写协作单位");
                    return "";
                }
                if ($("#Subpackage_contact").val().trim() == "") {
                    $.alert("请填写协作负责人");
                    return "";
                }
                if ($("#Subpackage_phone").val().trim() == "") {
                    $.alert("请填写协作负责人电话");
                    return "";
                }
                p_str += '"sIs":1,"sName":"' + $("#Subpackage_company").val().trim() + '","sCaptain":"' + $("#Subpackage_contact").val().trim() + '","sPhone":"' + $("#Subpackage_phone").val().trim() + '",'
            }
            if ($("input[name=guahao]:checked").length == 1) {
                if ($("#R_NAME").val().trim() == "") {
                    $.alert("请填写合作单位");
                    return "";
                }
                if ($("#R_CAPTAIN").val().trim() == "") {
                    $.alert("请填写合作负责人");
                    return "";
                }
                if ($("#R_PHONE").val().trim() == "") {
                    $.alert("请填写合作负责人电话");
                    return "";
                }
                p_str += '"rIs":1,"rName":"' + $("#R_NAME").val().trim() + '","rCaptain":"' + $("#R_CAPTAIN").val().trim() + '","rPhone":"' + $("#R_PHONE").val().trim() + '",'
            }
            if ($("#Project_summary").val().trim() == "") {
                $.alert("请填写工程概要");
                return "";
            }
            if ($("#P_START_TIME").val() == "") {
                $.alert("请填写工程的开始时间");
                return "";
            }
            if ($("#P_END_TIME").val() == "") {
                $.alert("请填写工程的结束时间");
                return "";
            }
            if (!dateCompare($("#P_START_TIME").val(), $("#P_END_TIME").val())) {
                $.alert("开始时间大于结束时间");
                return "";
            }
            if ($("#prog:hidden").length == 0) {//未上传完文件
                $.alert("文件正在上传");
                return;
            }
            var start = new Date($("#P_START_TIME").val());
            var end = new Date($("#P_END_TIME").val());
            p_str += '"pStartTime":"' + getJSONDate(start) + '","pEndTime":"' + getJSONDate(end) + '",'
            var file = ',"file":[]';
            if ($("span[name=new]").length > 0) {
                file = ',"file":['
                for (var i = 0; i < $("span[name=new]").length; i++) {
                    if (i != 0) {
                        file += ","
                    }
                    file += ' {"id":-1,"fId":0,"uId":' + "${Uid}" + ',"pId":"${project.pNumber}","fileName":"' + $("span[name=new]:eq(" + i + ")").attr("filename") + '","fileUrl":"' + $("span[name=new]:eq(" + i + ")").attr("sid") + '","fState":"' + $("span[name=new]:eq(" + i + ")").attr("fState") + '"}';
                }
                file += ']'
            }
            var result = '{"project":{"pNumber":"' + $("#P_NUMBER").val() + '","pName":"' + $("#Projectname").val().trim() + '","pAddress":"' + $("#Project_address").val().trim() + '","pCaptain":"' + $("#Head").val().trim() + '","pSource":"' + $("#P_SOURCE").val().trim() + '","pFType":' + $("#Project_type_F option:selected").val() + ',"pType":' + $("#Project_Ttype_S option:selected").val() + ',' + p_str + '"pRemark":"' + $("#Project_remarks").val().trim() + '","pSummary":"' + $("#Project_summary").val().trim() + '","pCCaptain":"' + $("#headname").val().trim() + '"}' + file + zuoyejihua + c_projectstr + '}';
            //
            return result

        }
        var c_worklistarray = new Array();
        function checked(e) {
            $.ajax({
                url:'selectSkeds',
                type:'Post',
                data:{"pNumber":$("#P_NUMBER").val()},
                success:function(obj){
                    if(obj.resultCode==1){
                        if ($(e.children[0]).context.checked) {
                            if ($(e.children[0]).context.value == "jihua") {
                                worklistarray = new Array();
                                c_worklistarray = new Array();
                                $(".errorcal").html("")
                                workliststr()
                            }
                            $("#" + $(e.children[0]).context.value + "").removeClass("hidden");
                        } else {
                            $("#" + $(e.children[0]).context.value + "").addClass("hidden");
                        }
                    }else{
                        worklistarray = new Array();
                        c_worklistarray = new Array();
                        $(".errorcal").html("")
                        var temp = JSON.stringify(obj.resultOBJ);
                        temp = temp.replaceAll("sYear", "signYear");
                        temp = temp.replaceAll("sMonth", "signMonth");
                        temp = temp.replaceAll("sDay", "signDay");
                        var a = eval('(' + temp + ')');
                        worklistarray = a;
                        workliststr()
                    }
                },
                error:function(){
                    $.alert("请求失败，请联系管理人员！");
                }
            });

        }
        var worklistarray = new Array();
        function workliststr() {
            $("#worklist").html();
            var nowdate = new Date();
            var lilength = $("[name=zirenwu]:checked").val()
            if (lilength == 0) {
                signList = [];
                calUtil.eventName = "load"
                calUtil.drawstr = "#worklist"
                $("#worklist").html("")
                calUtil.init(worklistarray);
            } else {
                var str_ul = '';
                lilength = $("#C_list li").length
                for (var i = 0; i < lilength; i++) {
                    if (i % 2 == 0) {
                        str_ul += "<div class='row'>"
                    }
                    str_ul += '<div class="col-sm-4 margin-top_6 " c_id="' + $("#C_list li:eq(" + i + ")").attr("c_id") + '">' + $("#C_list li:eq(" + i + ")").text() + '</div><div class="col-sm-2 margin-top_6 " c_id="' + $("#C_list li:eq(" + i + ")").attr("c_id") + '"><button class="btn btn-primary btn-sm" type="button" onclick="c_addc_jihua(\'' + $("#C_list li:eq(" + i + ")").attr("c_id") + '\')">添加计划</button></div>';
                    if (i % 2 == 1) {
                        str_ul += "</div>"
                    }
                }
                $("#worklist").html(str_ul)
            }
        }
        var c_project_count = -1;
        var c_projectarray = new Array();
        function add_c_project() {
            $.modal({
                title: "添加子任务",
                text: '<div class="panel-body"><div class="form-group has-primary" ><label class="col-sm-3 control-label" for="tel">名称：</label><div  class="col-sm-8"><input type="text" class="form-control" id="C_NAME"placeholder="子任务名称"/></div></div><div class="form-group has-primary " style="margin-top:50px"><label class="col-sm-3 control-label" for="tel">概述：</label><div class="col-sm-8"><textarea class="form-control" id="C_SUMMARY" rows="3" style="resize: none" placeholder="子任务概述"></textarea><span id="error" class="red"></span></div></div></div>',
                buttons: [
                    {
                        text: "取消", onClick: function () {
                            $.closeModal();
                        }
                    },
                    {
                        text: "确定", onClick: function () { //提交
                            if ($("#C_NAME").val() == "") {
                                $("#error").html("请填写子任务名称");
                            }
                            if ($("#C_SUMMARY").val() == "") {
                                $("#error").html("请填写子任务概述");
                                return
                            }
                            $.closeModal();
                            var temp = { sName: $("#C_NAME").val(), sSummary: $("#C_SUMMARY").val(), uName: "${userName}", uId: "${Uid}", id: c_project_count, sState: -1 }
                            c_projectarray.push(temp);
                            var str = "<li class='zirenwu' c_id='cid_" + c_project_count + "' >" + $("#C_NAME").val() + "&nbsp;&nbsp;<span class='glyphicon glyphicon-remove red' onclick=delimg(-1,this,null)></span></li>"
                            $("#C_list").html($("#C_list").html() + str);
                            workliststr()
                            c_project_count--;
                        }
                    }], autoClose: false
            })
        }
        var c_worklistarray = Array();
        function c_addc_jihua(data) {
            var s=data.substring(0,3);
            alert(s)
            if(s=='cid'){
                c_worklistarray=new Array();
                var stu=$("#C_list li[c_id='"+data+"']").text();
                var s=stu.substring(0,stu.length-2);
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
                                    for(var i=0;i<list.length;i++){
                                        list[i].pId=$("#P_NUMBER").val();
                                        list[i].psName=s;
                                    }
                                    var a = { SIGN: num, LIST: list }
                                    c_worklistarray.push(a);
                                } else {
                                    for(var i=0;i<list.length;i++){
                                        list[i].pId=$("#P_NUMBER").val();
                                        list[i].psName=s;
                                    }
                                    c_worklistarray[inum].LIST = list;
                                }
                            }
                        }]
                })
                calUtil.eventName = "load"
                calUtil.drawstr = "#modal_cal";
                calUtil.init(list);
            }else{
                c_worklistarray=new Array();
                $.ajax({
                    url:'selectSkeds',
                    type:'Post',
                    data:{"pNumber":$("#P_NUMBER").val(),"psId":data},
                    success:function(obj){
                        if(obj.resultCode==0){
                            var temp = JSON.stringify(obj.resultOBJ);
                            temp = temp.replaceAll("sYear", "signYear");
                            temp = temp.replaceAll("sMonth", "signMonth");
                            temp = temp.replaceAll("sDay", "signDay");
                            var a = eval('(' + temp + ')');
                            c_worklistarray = a;
                            calUtil.eventName = "load";
                            calUtil.drawstr = "#modal_cal";
                            calUtil.init(c_worklistarray);
                        }else{
                            alert("out: "+JSON.stringify(c_worklistarray))
                            calUtil.eventName = "load";
                            calUtil.drawstr = "#modal_cal";
                            c_worklistarray=new Array();
                            calUtil.init(c_worklistarray);
                        }
                    },
                    error:function(){
                        $.alert("请求失败，请联系管理人员！");
                    }
                });

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
                                for(var i=0;i<c_worklistarray.length;i++){
                                    c_worklistarray[i].pId="${project.pNumber}";
                                    c_worklistarray[i].psId=data;
                                }
                                alert(JSON.stringify(c_worklistarray))
                            }
                        }]
                })
            }
        }
        function delimg(id, e, data) {//删除
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
            } else if (id == -1) {
                var str = $(e).parent().attr("c_id");
                $("[c_id=" + str + "]").remove();
                var subId={"id":str};
                $.ajax({
                    url:"deleteSubtask",
                    type:"post",
                    data:subId,
                    ansyc:"false",
                    success:function(obj){
                        if(obj.resultOBJ==0){
                            $.alert("成功删除子任务");
                        }else{
                            $.alert("删除失败子任务");
                        }
                    }
                });
                //删除子任务工作计划
                for (var i = 0; i < c_worklistarray.length; i++) {
                    if (c_worklistarray[i].SIGN == str.split('_')[1]) {
                        c_worklistarray.splice(i, 1);
                    }
                }
                for (var i = 0; i < projectData.file.length; i++) {
                    projectData.file[i].F_STATE = 1;
                }
            } else {
                $.ajax({
                    url:'updateFileState?id='+id,
                    type:"post",
                    async:'false',
                    dataType:"json",
                    success:function(obj){
                        if (obj.resultCode == 0) {
                            $(e).parent().remove();
                        }
                    },
                    error:function(){
                        $.alert("文件删除失败");
                    }
                });
            }
        }
        function zirenwu_div(state) {
            if (state) {
                $("#zirenwu").show();
                for (var i = 0; i < c_projectarray.length; i++) {//修改子任务状态

                    c_projectarray[i].S_STATE = 0;
                    //子任务工作计划的状态

                }
                for (var i = 0; i < c_worklistarray.length; i++) {
                    if (parseInt(c_worklistarray[i].SIGN) < 0) {//新计划

                    } else {//旧的计划
                        for (j = 0; j < c_worklistarray[i].LIST.length; j++) {
                            c_worklistarray[i].LIST[j].S_STATE = 0;
                        }
                    }
                }

            } else {
                $("#zirenwu").hide();
                for (var i = 0; i < c_projectarray.length; i++) {//删除子任务
                    if (c_projectarray[i].S_STATE != 0) {//新添加的
                        c_projectarray.splice(i, 1);
                    } else {
                        c_projectarray[i].S_STATE = 1;
                        //删除子任务工作计划

                    }
                }
                for (var i = 0; i < c_worklistarray.length; i++) {
                    if (parseInt(c_worklistarray[i].SIGN) < 0) {//新计划
                        c_worklistarray.splice(i, 1);
                    } else {//旧的计划
                        for (j = 0; j < c_worklistarray[i].LIST.length; j++) {
                            c_worklistarray[i].LIST[j].S_STATE = 1;
                        }
                    }
                }
            }
            if ($("[name=jihua]:checked").length == 1) {
                //worklistarray = new Array();
                //c_worklistarray = new Array();
                $(".errorcal").html("");
                workliststr()
            }
        }
        function fanhui(){
            var page='${page}';
            location.href="project_maintenance?pages="+page;
        }
    </script>
</head>
<body>
<div class="container-fluid margin-20">
    <p class="pull-left  label label-primary" onclick="fanhui()"><span class="glyphicon glyphicon-home" style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
    <div class="row">
        <div class="col-sm-12 ">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">编辑工程</h3>
                </div>
                <div class="panel-body ">
                    <div class="form-horizontal ">
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="tel">工程编号：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="P_NUMBER"
                                       placeholder="请输入工程来源" disabled>
                            </div>
                            <label class="col-sm-2 control-label" for="tel">工程来源：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="P_SOURCE"
                                       placeholder="请输入工程来源">
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">工程名称：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="Projectname"
                                       placeholder="请输入工程名称">
                            </div>


                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">工程地点：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="Project_address"
                                       placeholder="请输入工程的地点">
                            </div>


                        </div>

                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">工程类型：</label>
                            <div class="col-sm-3">
                                <select id="Project_type_F" class="form-control">
                                    <option>类型1</option>
                                    <option>类型2</option>
                                    <option>类型3</option>
                                    <option>类型4</option>
                                </select>
                            </div>
                            <label class="col-sm-2 control-label" for="profession">工程子类型：</label>
                            <div class="col-sm-3">
                                <select id="Project_Ttype_S" class="form-control">
                                    <option>类型1</option>
                                    <option>类型2</option>
                                    <option>类型3</option>
                                    <option>类型4</option>
                                </select>
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">开始时间：</label>
                            <div class="col-sm-3">
                                <input type="text" id="P_START_TIME" class="form-control" />
                            </div>
                            <label class="col-sm-2 control-label" for="profession">结束时间：</label>
                            <div class="col-sm-3">
                                <input type="text" id="P_END_TIME" class="form-control" />
                            </div>

                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">项目负责人：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="Head"
                                       placeholder="请输入工程负责人">
                            </div>
                            <label class="col-sm-2 control-label" for="name">负责人电话：</label>
                            <div class="col-sm-3">
                                <input type="text" class="form-control" id="headname"
                                       placeholder="负责人电话">
                            </div>
                        </div>
                        <div id="jiafang">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">甲方名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="First_Party_name"
                                           placeholder="请输入甲方名称">
                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">甲方联系人：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="First_Party_contact"
                                           placeholder="请输入甲方联系人">
                                </div>
                                <label class="col-sm-2 control-label" for="name">甲方电话：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="First_Party_phone"
                                           placeholder="请输入甲方电话">
                                </div>
                            </div>
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="tel">工程概述：</label>
                            <div class="col-sm-8">
                                <textarea class="form-control" id="Project_summary" rows="3" style="resize: none" placeholder="请输入工程概述"></textarea>
                            </div>
                            <!--   <label class="col-sm-1 control-label" for="tel">备注：</label>
                            <div class="col-sm-4">
                                <textarea class="form-control"  id="Project_remarks" rows="3" style="resize: none" placeholder="请输入工程备注"></textarea>
                            </div>-->
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="profession">有无子任务：</label>
                            <div class="col-sm-2">
                                <label class="radio-inline">
                                    <input type="radio" name="zirenwu" id="optionsRadios3" value="0" checked onclick="zirenwu_div(false)">无
                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="zirenwu" id="optionsRadios4" value="1" onclick="zirenwu_div(true)">有
                                </label>
                            </div>
                            <div class="col-sm-6" id="zirenwu">
                                <button class="btn btn-primary btn-sm " type="button" onclick="add_c_project()">添加</button>
                                <ul class="list-inline " id="C_list" style="float: left; margin-left: 10px;">
                                </ul>
                            </div>
                        </div>
                        <div class="form-group has-primary">
                            <label class="col-sm-2 control-label" for="name">其他信息：</label>
                            <!--    <div class="col-sm-2">
                                <div class="checkbox">
                                    <label onclick="checked(this)">
                                        <input type="checkbox" value="jiafang" name="jiafang">
                                        甲方信息
                                    </label>
                                </div>
                            </div>-->
                            <div class="col-sm-2">
                                <div class="checkbox">
                                    <label onclick="checked(this)">
                                        <input type="checkbox" value="fenbao" name="fenbao">
                                        协作信息
                                    </label>
                                </div>
                            </div>
                            <div class="col-sm-2">
                                <div class="checkbox">
                                    <label onclick="checked(this)">
                                        <input type="checkbox" value="guahao" name="guahao" />
                                        合作信息
                                    </label>
                                </div>

                            </div>
                            <div class="col-sm-2">
                                <div class="checkbox">
                                    <label onclick="checked(this)">
                                        <input type="checkbox" value="jihua" name="jihua" />
                                        作业计划
                                    </label>
                                </div>

                            </div>
                        </div>

                        <div id="fenbao" class="hidden">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">协作单位：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="Subpackage_company"
                                           placeholder="请输入协作单位名称">
                                </div>

                            </div>

                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">协作负责人：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="Subpackage_contact"
                                           placeholder="请输入协作负责人姓名">
                                </div>
                                <label class="col-sm-2 control-label" for="name">协作负责人电话：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="Subpackage_phone"
                                           placeholder="请输入协作负责人电话">
                                </div>
                            </div>
                        </div>
                        <div id="guahao" class="hidden">
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">合作单位：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="form-control" id="R_NAME"
                                           placeholder="请输入合作单位名称">
                                </div>

                            </div>
                            <div class="form-group has-primary">
                                <label class="col-sm-2 control-label" for="name">合作负责人：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="R_CAPTAIN"
                                           placeholder="请输入合作负责人姓名">
                                </div>
                                <label class="col-sm-2 control-label" for="name">合作负责人电话：</label>
                                <div class="col-sm-3">
                                    <input type="text" class="form-control" id="R_PHONE"
                                           placeholder="请输入合作负责人电话">
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
                            <label class="col-sm-2 control-label" for="tel">备注：</label>
                            <div class="col-sm-8">
                                <input type="text" class="form-control" id="Project_remarks"
                                       placeholder="请输入工程备注">
                            </div>
                        </div>
                        <div class="form-group has-primary ">
                            <label class="col-sm-2 control-label" for="tel">上传资料：</label>
                            <ul class="nav nav-tabs col-sm-8" id="myTab">
                                <li class="active "><a href="#home" id="ziliao" class="text-primary">前期资料</a></li>

                            </ul>

                            <div class="tab-content has-primary col-sm-offset-2 col-sm-8" style="border-bottom: 1px solid #d6e9c6; border-left: 1px solid #d6e9c6; border-right: 1px solid #d6e9c6;">
                                <div class="tab-pane active list-group " id="home">
                                    <div class="list-group ">
                                        <label class="col-sm-3 control-label " for="idCard">前期资料：</label>
                                        <div class="col-sm-2">
                                            <form id="up_wendang" surl="" class="file">
                                                <input type="file" id="idCard" style="display: inline-block;cursor:pointer;" name="file" multiple="multiple" />选择
                                            </form>

                                        </div>
                                        <div class="col-sm-2">
                                            <div class="progress ">
                                                <div class="progress-bar" id="prog" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <br />
                                    <div class="list-group ">
                                        <div id="qianqi_label"></div>
                                    </div>
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
                        <div class="form-group has-success">
                            <div class="col-sm-6 col-sm-offset-3">
                                <button type="button" class="btn btn-primary btn-lg btn-block" onclick="addproject()">提交</button>
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

</body>
</html>
