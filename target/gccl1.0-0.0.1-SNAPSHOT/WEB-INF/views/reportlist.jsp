<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 9:58
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
    <title>上报列表</title>
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
    <link href="css/bootstrap-table.css" rel="stylesheet" />
    <script src="js/bootstrap-table.js"></script>
    <script src="js/bootstrap-table-zh-CN.js"></script>

    <style>
        .table th, .table td {
            text-align: center;
            vertical-align: middle!important;
        }
    </style>
</head>
<body>
<div class="container-fluid margin-20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row text-center" id="qualitylist">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="history.go(-1)"><span class="glyphicon glyphicon-home" style="padding:5px 15px;cursor:pointer;">&nbsp;返回</span></p>
                </div>
                <h3>上报记录</h3>
                <div class="col-sm-12 ">
                    <table id="up_table" class="table table-bordered table-hover"></table>
                </div>
                <div class="text-center" id="page">
                </div>

            </div>
            <div class="row" id="Score">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="qualitylistshow()"><span class="glyphicon glyphicon-triangle-left"></span>&nbsp;返回</p>
                </div>
                <div class="row">
                    <div class="col-sm-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">上报详情</h3>
                            </div>
                            <div class="panel-body ">
                                <div class="form-horizontal ">
                                    <div class="form-group has-primary " id="file_list">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row" id="check_div">
                    <div class="col-sm-12">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">检查</h3>
                            </div>
                            <div class="panel-body ">
                                <!--  <div class="form-horizontal " id="write_check">
                                      <div class="form-group has-primary ">
                                          <label class="col-sm-2 control-label" for="tel">反馈类型：</label>
                                          <div class="col-sm-8 text-left">
                                              <label class="radio-inline">
                                                  <input type="radio" name="inlineRadioOptions" id="jiancha" value="0" checked="checked">检查反馈
                                              </label>
                                              <label class="radio-inline">
                                                  <input type="radio" name="inlineRadioOptions" id="dahui" value="3">打回
                                              </label>

                                          </div>
                                      </div>
                                      <div class="form-group has-primary  ">
                                          <label class="col-sm-2 control-label " name="jiancha_div" for="tel">评估：</label>
                                          <div class="col-sm-3 text-left " name="jiancha_div">
                                               <select id="Select1" class="form-control">
                                              <option value="优">优</option>
                                              <option value="良">良</option>
                                              <option value="合格">合格</option>
                                              <option value="不合格">不合格</option>
                                          </select>
                                          </div>
                                          <label class="col-sm-2 control-label" for="idCard">附件：</label>

                                          <div class="col-sm-4">
                                            <div class="progress pull-left "style="width:100px" >
                                                          <div class="progress-bar col-sm-1" id="prog_ys" role="progressbar" aria-valuenow="2" aria-valuemin="0" aria-valuemax="100" style="">
                                                          </div>
                                                      </div>

                                              <div class="col-sm-8" id="wendang_label"></div>
                                              <form id="up_wendang" class="file pull-right col-sm-3" surl="">
                                                  <input type="file" id="idCard" style="display: inline-block;" name="file"   multiple="multiple"  />选择
                                              </form>
                                          </div>
                                      </div>
                                      <div class="form-group has-primary ">
                                          <label class="col-sm-2 control-label" for="tel">意见：</label>
                                          <div class="col-sm-8 text-left">
                                              <textarea class="form-control" rows="3" style="resize: none" id="opinion"></textarea>
                                          </div>
                                      </div>
                                      <div class="form-group has-success" id="submit_btn">
                                          <div class="col-sm-6 col-sm-offset-3">
                                              <button type="button" class="btn btn-primary btn-lg btn-block" onclick="submit()">确定</button>
                                          </div>
                                      </div>
                                  </div>-->
                                <div class="form-horizontal" id="check_detail">
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">评估：</label>
                                        <div class="col-sm-4 text-left " id="fenshu">
                                        </div>
                                        <label class="col-sm-1 " for="">附件：</label>
                                        <div class="col-sm-3 text-left" id="fujian">

                                        </div>
                                    </div>
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">意见：</label>
                                        <div class="col-sm-8 text-left" id="yijian">
                                        </div>
                                    </div>
                                </div>

                            </div>

                        </div>

                    </div>
                </div>

                <div class="row hidden" id="fankui">
                    <div class="col-sm-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">反馈</h3>
                            </div>
                            <div class="panel-body ">
                                <div class="form-horizontal">
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">文件：</label>
                                        <div class="col-sm-8 text-left " id="fk_file">
                                        </div>

                                    </div>
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">反馈内容：</label>
                                        <div class="col-sm-8 text-left" id="fk_content">
                                        </div>
                                    </div>
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
<script>
    //(1)初始化质量通报
    $(function () {
        var oTable = new TableInits();
        oTable.Init();
    });
    var TableInits = function () {
        var oTableInit = new Object();
        oTableInit.Init = function () {
            $('#up_table').bootstrapTable({
                contentType: "application/x-www-form-urlencoded",
                url: '/getRecord', //请求后台的URL（*）
                method: 'post', //请求方式（*）
                striped: false, //是否显示行间隔色
                cache: false, //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true, //是否显示分页（*）
                sortable: false, //是否启用排序
                sortOrder: "asc", //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "server", //分页方式：client客户端分页，server服务端分页（*）
                //height: 500, //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "id", //每一行的唯一标识，一般为主键列
                paginationDetailHAlign:"right",
                columns: [{
                    field: 'pId',
                    title: '上报编号',
                },{
                    field: 'pRTime',
                    title: '上传时间',
                },{
                    field: 'uName',
                    title: '上传人',

                },{
                    field: 'fraction',
                    title: '上报质量',

                },{
                    field:'ID',
                    title: '操作',
                    width: 120,
                    align: 'center',
                    valign: 'middle',
                    formatter: actionsFormatter
                }],
            });
        };

        //操作栏的格式化
        function actionsFormatter(value, row, index) {
            var i=row.id;
            return "<span onclick='chakan2("+i+")' class='label label-primary' style='cursor:pointer;padding:5px 30px;'>未查看</span>"
        }
        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = { //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                rows: params.limit,                         //页面大小
                page: (params.offset / params.limit) + 1,   //页码
                sort: params.sort,      //排序列名
                sortOrder: params.order //排位命令（desc，asc）
            };
            alert(JSON.stringify(temp));
            return temp;
        };
        return oTableInit;
    };
</script>
</html>

