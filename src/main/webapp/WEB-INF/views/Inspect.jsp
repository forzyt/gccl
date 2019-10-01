<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2018/12/20
  Time: 10:22
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
    <title>检查</title>
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

</head>
<body>
<div class="container-fluid margin-20">
    <div class="tab-content has-primary  text-center">
        <div class="tab-pane active list-group " id="engineering">
            <div class="row" id="Score">
                <div class="col-sm-12">
                    <p class="pull-left  label label-primary" onclick="qualitylistshow()"><span class="glyphicon glyphicon-triangle-left"></span>&nbsp;返回</p>
                </div>
                <div class="row">
                    <div class="col-sm-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title" id="Secret">上报详情</h3>
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
                <div class="row" id="h_check_detail">
                    <div class="col-sm-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">检查历史</h3>
                            </div>
                            <div class="panel-body ">
                                <div class="form-horizontal ">
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">评估：</label>
                                        <div class="col-sm-4 text-left " id="h_pinggu">
                                        </div>
                                        <label class="col-sm-1 " for="">附件：</label>
                                        <div class="col-sm-3 text-left" id="h_fujian">

                                        </div>
                                    </div>
                                    <div class="form-group has-primary ">
                                        <label class="col-sm-2 " for="tel">意见：</label>
                                        <div class="col-sm-8 text-left" id="h_yijian">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 ">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">检查</h3>
                            </div>
                            <div class="panel-body ">
                                <div class="form-horizontal " id="write_check">
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
                                            <select id="score" class="form-control">
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
                                </div>
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
</html>

