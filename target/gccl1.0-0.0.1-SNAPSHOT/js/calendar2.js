var calUtil = {
    //当前日历显示的年份
    showYear: 2015,
    //当前日历显示的月份
    showMonth: 1,
    //当前日历显示的天数
    showDays: 1,
    eventName: "load",
    //初始化日历
    drawstr: "#worklist",
    reportlist:[],
    init: function (signList, flag, s) {
        calUtil.setMonthAndDay();
        if (typeof (flag) == 'undefined') {
            flag = true;
        }
        if (typeof (s) == 'undefined') {
        } else {
            var datenow = new Date();
            if (dateCompare(datenow.getFullYear() + "-" + (datenow.getMonth() + 1) + "-" + datenow.getDate(), s.signYear + "-" + s.signMonth + "-" + s.signDay)) {
                signList.splice('', '', s);
                $(".errorcal").html("");
            } else {
                $(".errorcal").html("计划时间不能小于今天");
            }
        }
        calUtil.draw(signList);
        calUtil.bindEnvent(signList, flag);
    }, del: function (signList, isclick, s) {
        calUtil.setMonthAndDay();
        if (typeof (s) == 'undefined') {
        } else {
            for (var i = 0; i < signList.length; i++) {
                var cur_person = signList[i];
                if (cur_person.signDay == s.signDay && cur_person.signMonth == s.signMonth && cur_person.signYear == s.signYear) {
                    if (cur_person.id == -1) {//新加的作业计划
                        signList.splice(i, 1);
                    } else {
                        signList[i].sState = 1;
                    }
                }
            }
        }
        calUtil.draw(signList);
        calUtil.bindEnvent(signList, isclick);
    },
    draw: function (signList) {
        //绑定日历
        //alert(signList.length);
        console.log(signList);
        if (signList.length > 21) {
            //alert(21);
            $("#sign_note").empty();
            $("#sign_note").html('<button class="sign_contener" type="button"><i class="fa fa-calendar-check-o" aria-hidden="true"></i>&nbsp;已达标，获取1次抽奖</button>');
        }
        var str = calUtil.drawCal(calUtil.showYear, calUtil.showMonth, signList);
        $(calUtil.drawstr).html(str);
        //绑定日历表头
        var calendarName = calUtil.showYear + "年" + calUtil.showMonth + "月";
        $(".calendar_month_span").html(calendarName);
    },
    //绑定事件
    bindEnvent: function (signList, isclick) {
        // //绑定上个月事件
        $(".calendar_month_prev").click(function () {
            //ajax获取日历json数据
            //var signList=[{"signDay":"10"},{"signDay":"11"},{"signDay":"12"},{"signDay":"13"}];
            calUtil.eventName = "prev";
            calUtil.init(signList, isclick);
        });
        // //绑定下个月事件
        $(".calendar_month_next").click(function () {
            //ajax获取日历json数据
            //var signList=[{"signDay":"10"},{"signDay":"11"},{"signDay":"12"},{"signDay":"13"}];
            calUtil.eventName = "next";
            calUtil.init(signList, isclick);
        });
        if (isclick) {
            $(".calendar_record").click(function () {
                var tmp = { "signYear": parseInt(calUtil.showYear), "signMonth": parseInt(calUtil.showMonth), "signDay": parseInt($(this).html()), "id": -1, "sState": 0 };
                calUtil.eventName = "now";
                calUtil.init(signList, isclick, tmp);
            });
            $(".on").click(function () {
                var tmp = { "signYear": calUtil.showYear, "signMonth": calUtil.showMonth, "signDay": $(this).html(), "id": -1, "sState": 0 };
                calUtil.eventName = "now";
                calUtil.del(signList, isclick, tmp);
            })
        } else {
            $(".sign_row div").click(function () {
               
                var day = $(this).text();
                var date = parseInt(calUtil.showYear) + "-" + parseInt(calUtil.showMonth) + "-" + parseInt(day);
                var today = getDay_num(0, 2, '-');
                var _class = $(this).attr("class");
                if (_class.indexOf('on') > -1) {
                    if (isequaltime(today, date)) {
                        $("div.red-bg").removeClass('red-bg');
                        $("div.blue-bg").removeClass('blue-bg')
                        $(this).addClass('blue-bg');
                        $("#shuoming").addClass("hidden")
                    } else {
                        $("div.red-bg").removeClass('red-bg');
                        $("div.blue-bg").removeClass('blue-bg')
                        $(this).addClass('red-bg')
                        $("#shuoming").removeClass("hidden")
                    }
                } else if (_class.indexOf('bold') > -1) {
                    $("#shuoming").addClass("hidden");
                } else {
                    $("div.red-bg").removeClass('red-bg');
                    $("div.blue-bg").removeClass('blue-bg')
                    $("#shuoming").removeClass("hidden")
                    $(this).addClass('red-bg')
                }
            })
        }
    },
    //获取当前选择的年月
    setMonthAndDay: function () {
        switch (calUtil.eventName) {
            case "load":
                var current = new Date();
                calUtil.showYear = current.getFullYear();
                calUtil.showMonth = current.getMonth() + 1;
                break;
            case "prev":
                var nowMonth = $(".calendar_month_span").html().split("年")[1].split("月")[0];
                calUtil.showMonth = parseInt(nowMonth) - 1;
                if (calUtil.showMonth == 0) {
                    calUtil.showMonth = 12;
                    calUtil.showYear -= 1;
                }
                break;
            case "next":
                var nowMonth = $(".calendar_month_span").html().split("年")[1].split("月")[0];
                calUtil.showMonth = parseInt(nowMonth) + 1;
                if (calUtil.showMonth == 13) {
                    calUtil.showMonth = 1;
                    calUtil.showYear += 1;
                }
                break;
            case "now":
                var nowMonth = $(".calendar_month_span").html().split("年")[1].split("月")[0];
                var nowYear = $(".calendar_month_span").html().split("年")[0];
                calUtil.showYear = nowYear;
                calUtil.showMonth = nowMonth;
        }
    },
    getDaysInmonth: function (iMonth, iYear) {
        var dPrevDate = new Date(iYear, iMonth, 0);
        return dPrevDate.getDate();
    },
    bulidCal: function (iYear, iMonth) {
        var aMonth = new Array();
        aMonth[0] = new Array(7);
        aMonth[1] = new Array(7);
        aMonth[2] = new Array(7);
        aMonth[3] = new Array(7);
        aMonth[4] = new Array(7);
        aMonth[5] = new Array(7);
        aMonth[6] = new Array(7);
        var dCalDate = new Date(iYear, iMonth - 1, 1);
        var iDayOfFirst = dCalDate.getDay();
        var iDaysInMonth = calUtil.getDaysInmonth(iMonth, iYear);
        var iVarDate = 1;
        var d, w;
        aMonth[0][0] = "日";
        aMonth[0][1] = "一";
        aMonth[0][2] = "二";
        aMonth[0][3] = "三";
        aMonth[0][4] = "四";
        aMonth[0][5] = "五";
        aMonth[0][6] = "六";
        for (d = iDayOfFirst; d < 7; d++) {
            aMonth[1][d] = iVarDate;
            iVarDate++;
        }
        for (w = 2; w < 7; w++) {
            for (d = 0; d < 7; d++) {
                if (iVarDate <= iDaysInMonth) {
                    aMonth[w][d] = iVarDate;
                    iVarDate++;
                }
            }
        }
        return aMonth;
    },
    ifHasSigned: function (signList, day, iYear, iMonth) {
        var signed = false;

        $.each(signList, function (index, item) {
            if (item.signDay == day && item.signMonth == iMonth && item.signYear == iYear&&item.sState==0) {
                signed = true;
                return false;
            }
        });
        return signed;
    }, ishave: function (reportlist, day, iYear, iMonth) {
        var signed = false;
        
        $.each(reportlist, function (index, item) {
            if (item.sDay == day && item.sMonth == iMonth && item.sYear == iYear) {
                signed = true;
                return false;
            }
        });
        return signed;
    },
    drawCal: function (iYear, iMonth, signList) {
        var myMonth = calUtil.bulidCal(iYear, iMonth);
        var htmls = new Array();
        htmls.push("<div class='sign_main' id='sign_layer'>");
        htmls.push("<div class='sign_succ_calendar_title'><div>");
        htmls.push("<span class='glyphicon glyphicon-chevron-left calendar_month_prev'></span>&nbsp;");
        htmls.push("<span class='calendar_month_span'></span>");
        htmls.push("&nbsp;<span class='calendar_month_next glyphicon glyphicon-chevron-right'></span>");
        htmls.push("</div></div>");
        htmls.push("<div class='sign_equal' id='sign_cal'>");
        htmls.push("<div class='sign_row'>");
        htmls.push("<div class='th_1 bold'>" + myMonth[0][0] + "</div>");
        htmls.push("<div class='th_2 bold'>" + myMonth[0][1] + "</div>");
        htmls.push("<div class='th_3 bold'>" + myMonth[0][2] + "</div>");
        htmls.push("<div class='th_4 bold'>" + myMonth[0][3] + "</div>");
        htmls.push("<div class='th_5 bold'>" + myMonth[0][4] + "</div>");
        htmls.push("<div class='th_6 bold'>" + myMonth[0][5] + "</div>");
        htmls.push("<div class='th_7 bold'>" + myMonth[0][6] + "</div>");
        htmls.push("</div>");
        var d, w;
        for (w = 1; w < 7; w++) {
            htmls.push("<div class='sign_row'>");
            for (d = 0; d < 7; d++) {
                var str = "";
                var ifHasSigned = calUtil.ifHasSigned(signList, myMonth[w][d], iYear, iMonth);
                if (calUtil.reportlist.length != 0) {
                    var ishave_ = calUtil.ishave(calUtil.reportlist, myMonth[w][d], iYear, iMonth);
                    if (ishave_) {
                       
                        str = '<span class="glyphicon glyphicon-ok red pull-right"></span>';
                    }
                    if (ifHasSigned == true && ishave_ == false) {
                        var day = iYear + "-" + (iMonth.toString().length == 1 ? "0" + iMonth : iMonth) + "-" + (myMonth[w][d].toString().length == 1 ? "0" + myMonth[w][d] : myMonth[w][d]);
                        var today = getDay_num(0, 2, '-');
                        if (!dateCompare(today, day)) {
                            str = '<span class="glyphicon glyphicon-remove red pull-right"></span>';
                        }
                    }
                }
                if (ifHasSigned && typeof (myMonth[w][d]) != 'undefined') {
                    htmls.push("<div class='td_" + d + " on '>" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + str + "</div>");
                } else {
                    htmls.push("<div class='td_" + d + " calendar_record' >" + (!isNaN(myMonth[w][d]) ? myMonth[w][d] : " ") + str + "</div>");
                }
            }
            htmls.push("</div>");
        }
        htmls.push("</div>");
        htmls.push("</div>");
        return htmls.join('');
    }
};