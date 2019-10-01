//------------公共变量-------------------
var WX_appId = "wxb187ca7c86333eca";
var WX_scurityUrl = "dt.next-wifi.com";
//---------------------------------------
// jquery.jsonp 2.4.0 (c)2012 Julian Aubourg | MIT License
(function (e) { function t() { } function n(e) { C = [e] } function r(e, t, n) { return e && e.apply && e.apply(t.context || t, n) } function i(e) { return /\?/.test(e) ? "&" : "?" } function O(c) { function Y(e) { z++ || (W(), j && (T[I] = { s: [e] }), D && (e = D.apply(c, [e])), r(O, c, [e, b, c]), r(_, c, [c, b])) } function Z(e) { z++ || (W(), j && e != w && (T[I] = e), r(M, c, [c, e]), r(_, c, [c, e])) } c = e.extend({}, k, c); var O = c.success, M = c.error, _ = c.complete, D = c.dataFilter, P = c.callbackParameter, H = c.callback, B = c.cache, j = c.pageCache, F = c.charset, I = c.url, q = c.data, R = c.timeout, U, z = 0, W = t, X, V, J, K, Q, G; return S && S(function (e) { e.done(O).fail(M), O = e.resolve, M = e.reject }).promise(c), c.abort = function () { !(z++) && W() }, r(c.beforeSend, c, [c]) === !1 || z ? c : (I = I || u, q = q ? typeof q == "string" ? q : e.param(q, c.traditional) : u, I += q ? i(I) + q : u, P && (I += i(I) + encodeURIComponent(P) + "=?"), !B && !j && (I += i(I) + "_" + (new Date).getTime() + "="), I = I.replace(/=\?(&|$)/, "=" + H + "$1"), j && (U = T[I]) ? U.s ? Y(U.s[0]) : Z(U) : (E[H] = n, K = e(y)[0], K.id = l + N++, F && (K[o] = F), L && L.version() < 11.6 ? (Q = e(y)[0]).text = "document.getElementById('" + K.id + "')." + p + "()" : K[s] = s, A && (K.htmlFor = K.id, K.event = h), K[d] = K[p] = K[v] = function (e) { if (!K[m] || !/i/.test(K[m])) { try { K[h] && K[h]() } catch (t) { } e = C, C = 0, e ? Y(e[0]) : Z(a) } }, K.src = I, W = function (e) { G && clearTimeout(G), K[v] = K[d] = K[p] = null, x[g](K), Q && x[g](Q) }, x[f](K, J = x.firstChild), Q && x[f](Q, J), G = R > 0 && setTimeout(function () { Z(w) }, R)), c) } var s = "async", o = "charset", u = "", a = "error", f = "insertBefore", l = "_jqjsp", c = "on", h = c + "click", p = c + a, d = c + "load", v = c + "readystatechange", m = "readyState", g = "removeChild", y = "<script>", b = "success", w = "timeout", E = window, S = e.Deferred, x = e("head")[0] || document.documentElement, T = {}, N = 0, C, k = { callback: l, url: location.href }, L = E.opera, A = !!e("<div>").html("<!--[if IE]><i><![endif]-->").find("i").length; O.setup = function (t) { e.extend(k, t) }, e.jsonp = O })(jQuery)

//防止误触
var _timer = {};
function delay_till_last(id, fn, wait, canshu1, canshu2) {
    if (_timer[id]) {
        window.clearTimeout(_timer[id]);
        delete _timer[id];
    }
    return _timer[id] = window.setTimeout(function () {
        if (typeof (canshu1) != "undefined") {
            if (typeof (canshu2) != "undefined") {
                fn(canshu1, canshu2);
            } else {
                fn(canshu1);
            }
        } else {
            fn();
        }
        delete _timer[id];
    }, wait);
}

function GetQueryString(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
    var r = decodeURIComponent(window.location.search).substr(1).match(reg);
    if (r != null) {
        return unescape(r[2]);
    } else {
        r = window.location.search.substr(1).match(reg);
        if (r != null) {
            return unescape(r[2]);
        } else {
            return null;
        }
    }
}

function getUsedTraffic(_traffic) {
    if (_traffic == null || _traffic == "") {
        return "0K";
    }
    else if (_traffic < 1024) {
        return eval(_traffic / 1024).toFixed(2) + "K";
    } else if (_traffic < 1048576) {
        return eval(_traffic / 1024).toFixed(0) + "K";
    } else if (_traffic < 1064332261) {
        return eval(_traffic / 1024 / 1024).toFixed(0) + "M";
    } else {
        return eval(_traffic / 1024 / 1024 / 1024).toFixed(1) + "G";
    }
}
function FormatDate(strTime) {
    var date = new Date(strTime);
    return date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate();
}

function GetTimeCompany(_time) {
    if (_time == null) {
        return "0秒";
    }
    else if (_time < 60) {
        return _time + "秒";
    }
    else if (_time < 3600) {
        return parseInt(_time / 60) + "分" + (_time % 60 == 0 ? "" : (_time % 60) + "秒");
    }
    else if (_time < 86400) {
        var mm = _time % 3600;
        return parseInt(_time / 3600) + "小时" + (mm == 0 ? "" : parseInt(mm / 60) + "分") + (mm % 60 == 0 ? "" : (mm % 60) + "秒");
    }
    else {
        var hh = _time % 86400;
        var mm = hh % 3600;
        return parseInt(_time / 86400) + "天" + (hh == 0 ? "" : parseInt(hh / 3600) + "小时") + (mm == 0 ? "" : parseInt(mm / 60) + "分") + (mm % 60 == 0 ? "" : (mm % 60) + "秒");
    }
}
//js获取日期：前天、昨天、今天、明天、后天type:1:2016年1月2日2：2016-1-2
function getDay_num(day, type, text) {
    var today = new Date();
    var targetday_milliseconds = today.getTime() + 1000 * 60 * 60 * 24 * day;
    today.setTime(targetday_milliseconds); //注意，这行是关键代码
    var tYear = today.getFullYear();
    var tMonth = today.getMonth();
    var tDate = today.getDate();
    tMonth = doHandleMonth(tMonth + 1);
    tDate = doHandleMonth(tDate);
    //    return tYear + "-" + tMonth + "月" + tDate+"日";
    if (type == 1) {
        return tYear + "年" + tMonth + "月" + tDate + "日";
    } else {

        return tYear + text + tMonth + text + tDate;
    }

}
function doHandleMonth(month) {
    var m = month;
    if (month.toString().length == 1) {
        m = "0" + month;
    }
    return m;
}
function dateFormat(_date, _format) {
    return new Date(+/\d+/.exec(_date)).format(_format);
}

function jsonToDate(_str) {
    return new Date(+/\d+/.exec(_str));
}

Date.prototype.format = function (format) {
    var o = {
        "M+": this.getMonth() + 1, //month
        "d+": this.getDate(), //day
        "h+": this.getHours(), //hour
        "m+": this.getMinutes(), //minute
        "s+": this.getSeconds(), //second
        "q+": Math.floor((this.getMonth() + 3) / 3), //quarter
        "S": this.getMilliseconds() //millisecond
    }
    if (/(y+)/.test(format))
        format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o) if (new RegExp("(" + k + ")").test(format))
        format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
    return format;
}

function getJSONDate(obj) {
    var result = "";
    var offsetStr = "";
    var offset = 0;
    var now = null;
    if (obj.constructor == Date) {
        now = obj;
        offset = now.getTimezoneOffset() / 60 * -1;
        offsetStr = (offset > 0 ? "+" : "-") + (Math.abs(offset) > 9 ? "" : "0") + Math.abs(offset).toString() + "00";
        result = "\/Date(" + now.getTime() + offsetStr + ")\/";
    }
    else if (typeof obj == "string") {
        now = new Date(obj);
        offset = now.getTimezoneOffset() / 60 * -1;
        offsetStr = (offset > 0 ? "+" : "-") + (Math.abs(offset) > 9 ? "" : "0") + Math.abs(offset).toString() + "00";
        result = "\/Date(" + now.getTime() + offsetStr + ")\/";
    }
    else {

    }
    return result;
}

/*对象序列化为字符串*/
String.toSerialize = function (obj) {
    var ransferCharForJavascript = function (s) {
        var newStr = s.replace(
/[\x26\x27\x3C\x3E\x0D\x0A\x22\x2C\x5C\x00]/g,
function (c) {
    ascii = c.charCodeAt(0)
    return '\\u00' + (ascii < 16 ? '0' + ascii.toString(16) : ascii.toString(16))
}
);
        return newStr;
    }
    if (obj == null) {
        return null
    }
    else if (obj.constructor == Array) {
        var builder = [];
        builder.push("[");
        for (var index in obj) {
            if (typeof obj[index] == "function") continue;
            if (index > 0) builder.push(",");
            builder.push(String.toSerialize(obj[index]));
        }
        builder.push("]");
        return builder.join("");
    }
    else if (obj.constructor == Object) {
        var builder = [];
        builder.push("{");
        var index = 0;
        for (var key in obj) {
            if (typeof obj[key] == "function") continue;
            if (index > 0) builder.push(",");
            builder.push(String.format("\"{0}\":{1}", key, String.toSerialize(obj[key])));
            index++;
        }
        builder.push("}");
        return builder.join("");
    }
    else if (obj.constructor == Boolean) {
        return obj.toString();
    }
    else if (obj.constructor == Number) {
        return obj.toString();
    }
    else if (obj.constructor == String) {
        return String.format('"{0}"', ransferCharForJavascript(obj));
    }
    else if (obj.constructor == Date) {
        return String.format('"/Date({0})/"', obj.getTime() + 28800000);
    }
    else if (this.toString != undefined) {
        return String.toSerialize(obj);
    }
}
//计算字符串长度
String.gblen = function (e) {
    var len = 0;
    for (var i = 0; i < e.length; i++) {
        if (e.charCodeAt(i) > 127 || e.charCodeAt(i) == 94) {
            len += 2;
        } else {
            len++;
        }
    }
    return len;
}
String.Substring = function (e, num) {
    var str = e;
    var len = 0;
    for (var i = 0; i < e.length; i++) {
        if (e.charCodeAt(i) > 127 || e.charCodeAt(i) == 94) {
            len += 2;
            if (len > num) {
                str = str.substring(0, i)
                break;
            }
        } else {
            len++;
            if (len > num) {
                str = str.substring(0, i)
                break;
            }
        }
    }
    return str;
}

/*对象序列化为字符串*/
String.toSerialize_New = function (obj) {
    var ransferCharForJavascript = function (s) {
        var newStr = s.replace(
/[\x26\x27\x3C\x3E\x0D\x0A\x22\x2C\x5C\x00]/g,
function (c) {
    ascii = c.charCodeAt(0)
    return '\\u00' + (ascii < 16 ? '0' + ascii.toString(16) : ascii.toString(16))
}
);
        return newStr;
    }
    if (obj == null) {
        return null
    }
    else if (obj.constructor == Array) {
        var builder = [];
        builder.push("[");
        for (var index in obj) {
            if (typeof obj[index] == "function") continue;
            if (index > 0) builder.push(",");
            builder.push(String.toSerialize_New(obj[index]));
        }
        builder.push("]");
        return builder.join("");
    }
    else if (obj.constructor == Object) {
        var builder = [];
        builder.push("{");
        var index = 0;
        for (var key in obj) {
            if (typeof obj[key] == "function") continue;
            if (index > 0) builder.push(",");
            builder.push(String.format("{0}:{1}", key, String.toSerialize_New(obj[key])));
            index++;
        }
        builder.push("}");
        return builder.join("");
    }
    else if (obj.constructor == Boolean) {
        return obj.toString();
    }
    else if (obj.constructor == Number) {
        return obj.toString();
    }
    else if (obj.constructor == String) {
        return String.format('"{0}"', obj);
    }
    else if (obj.constructor == Date) {
        return String.format('"/Date({0})/"', obj.getTime() + 28800000);
    }
    else if (this.toString != undefined) {
        return String.toSerialize_New(obj);
    }
}

/*格式化字符串*/
String.format = function (src) {
    if (arguments.length == 0) return null;
    var args = Array.prototype.slice.call(arguments, 1);
    return src.replace(/\{(\d+)\}/g, function (m, i) {
        return args[i];
    });
};
String.prototype.format = function (args) {
    var result = this;
    if (arguments.length > 0) {
        if (arguments.length == 1 && typeof (args) == "object") {
            for (var key in args) {
                if (args[key] != undefined) {
                    var reg = new RegExp("({)" + key + "(})", "g");
                    result = result.replace(reg, args[key]);
                }
            }
        }
        else {
            for (var i = 0; i < arguments.length; i++) {
                if (arguments[i] != undefined) {
                    var reg = new RegExp("({)" + i + "(})", "g");
                    result = result.replace(reg, arguments[i]);
                }
            }
        }
    }
    return result;
}

/*替换全部*/
String.prototype.replaceAll = function (reallyDo, replaceWith, ignoreCase) {
    if (!RegExp.prototype.isPrototypeOf(reallyDo)) {
        return this.replace(new RegExp(reallyDo, (ignoreCase ? "gi" : "g")), replaceWith);
    } else {
        return this.replace(reallyDo, replaceWith);
    }
}

function GetDateDiff(startTime, endTime, diffType) {
    var temptype = diffType;
    if (diffType == "hour")
        diffType = "minute";

    //startTime = startTime.replace(/\-/g, "/");
    //endTime = endTime.replace(/\-/g, "/");
    diffType = diffType.toLowerCase();
    var sTime = typeof (startTime) == "object" ? startTime : jsonToDate(startTime); //开始时间
    var eTime = typeof (endTime) == "object" ? endTime : jsonToDate(endTime); //结束时间

    //作为除数的数字
    var divNum = 1;
    switch (diffType) {
        case "second":
            divNum = 1000;
            break;
        case "minute":
            divNum = 1000 * 60;
            break;
        case "hour":
            divNum = 1000 * 3600;
            break;
        case "day":
            divNum = 1000 * 3600 * 24;
            break;
        default:
            break;
    }
    var temp = 0;
    var result = parseInt((eTime.getTime() - sTime.getTime()) / parseInt(divNum));
    if (isNaN(result))
        result = "";
    else if (temptype == "hour") {
        //精确到半小时
        temp = parseInt(result / 60);
        if (result % 60 >= 30)
            temp = temp + 0.5;
        result = temp;
    }

    return result;
}

if ($.modal != undefined)
    $.modal.setCloseTime = function (params) {
        var defaults = { time: 3, text: "确认" };
        params = $.extend({}, defaults, params);

        $("div>.weui_dialog_ft>.weui_btn_dialog").each(function () {
            if ($(this).html().indexOf(params.text) == 0) {
                $(this).html(params.text + "(" + params.time + ")");
                if (params.time > 0) {
                    params.time = params.time - 1;
                    setTimeout("$.modal.setCloseTime({ time: " + params.time + ", text: '" + params.text + "' })", 1000);
                } else {
                    $(this).click();
                }
            }
        });
    }
var ajaxurl = "";
//Ajax方法封装
function FuncAjax(ajaxUrl, ajaxData, ajaxSuccess, ajaxError,isShowLoading) {
    if (ajaxurl == ajaxUrl) {
        return;
    }
    ajaxData=ajaxData.replaceAll("\n", "<br />")
    if (isShowLoading == false) { }
    else { $.showLoading("请稍候..."); }
    return $.ajax({
        type: 'get',
        contentType: 'application/json',
        url: ajaxUrl,
        data: ajaxData,
        dataType: 'json',
        cache: false,
        error: function (msg) {
            if (ajaxError)
                ajaxError(msg);
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
        },
        success: function (obj) {
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
            ajaxSuccess(obj);
        }
    });
}
var ajaxurl2= "";
//Ajax方法封装
function FuncAjaxs(ajaxUrl, ajaxData, ajaxSuccess, ajaxError,isShowLoading) {
    if (ajaxurl2 == ajaxUrl) {
        return;
    }
    //ajaxData=ajaxData.replaceAll("\n", "<br />")
    if (isShowLoading == false) { }
    else { $.showLoading("请稍候..."); }
    return $.ajax({
        type: 'post',
        contentType: 'application/json;charset=UTF-8',
        url: ajaxUrl,
        data: ajaxData,
        cache: false,
        error: function (msg) {
            if (ajaxError)
                ajaxError(msg);
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
        },
        success: function (obj) {
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
            ajaxSuccess(obj);
        }
    });
}

function FuncAjax_Jsonp(ajaxUrl, ajaxSuccess, ajaxError, isShowLoading) {
    if (isShowLoading == false) { }
    else { $.showLoading("请稍候..."); }
    $.jsonp({
        url: ajaxUrl,
        timeout: 3000,
        callbackParameter: "callback",
        success: function (obj, textStatus, xOptions) {
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
            ajaxSuccess(obj);
        },
        error: function (xOptions, textStatus) {
            if (ajaxError)
                ajaxError(textStatus);
            if (isShowLoading == false) { }
            else { $.hideLoading(); }
        }
    });
}

//身份证验证
function IdentityCodeValid(code) {
    var city = { 11: "北京", 12: "天津", 13: "河北", 14: "山西", 15: "内蒙古", 21: "辽宁", 22: "吉林", 23: "黑龙江 ", 31: "上海", 32: "江苏", 33: "浙江", 34: "安徽", 35: "福建", 36: "江西", 37: "山东", 41: "河南", 42: "湖北 ", 43: "湖南", 44: "广东", 45: "广西", 46: "海南", 50: "重庆", 51: "四川", 52: "贵州", 53: "云南", 54: "西藏 ", 61: "陕西", 62: "甘肃", 63: "青海", 64: "宁夏", 65: "新疆", 71: "台湾", 81: "香港", 82: "澳门", 91: "国外 " };
    var tip = "";
    var pass = true;
    if (!code || !/^[1-9][0-9]{5}(19[0-9]{2}|200[0-9]|2010)(0[1-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])[0-9]{3}[0-9xX]$/i.test(code)) {
        tip = "身份证号格式错误";
        pass = false;
    }
    else if (!city[code.substr(0, 2)]) {
        tip = "地址编码错误";
        pass = false;
    }
    else {
        //18位身份证需要验证最后一位校验位
        if (code.length == 18) {
            code = code.split('');
            //∑(ai×Wi)(mod 11)
            //加权因子
            var factor = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];
            //校验位
            var parity = [1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++) {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            var last = parity[sum % 11];
            if (parity[sum % 11] != code[17].toUpperCase()) {
                tip = "校验位错误";
                pass = false;
            }
        }
    }
    return pass;
}

//上方弹出消息框
function Top_PromptBox(nr, times, name) {
    var str = '<li name="' + name + '" style="height:0px;position:relative;">' + nr + '<i style="padding:14px;top: 0px; right: 10px;position:absolute;color:#FF8000" class="fa fa-remove" ';
    str += 'onclick="RemoveTop(this)"></i></li>';
    if (times == 1) {
        $("#ImportantMessage").append(str);
    }
    else {
        $("#CommonlyMessage").append(str);
    }
}
function RemoveTop(e) {
    $(e).parent("li").remove();
}

//对话框
var date_input = new Date();
function input_model(input_type, input_title, input_text, input_id, callback) {//input_type:1数字，2：文本 3: 下拉框 input_title：对话框标题 4.textarea  input_text：对话框显示内容5:纯文本  input_id：确定后赋值到那个id
    input_id = "#" + input_id;
    if (input_type == 3) {
        //        $(".weui_dialog_bd").text()
        //        $(input_id).text()
    } else if (input_type == 4) {
        input_text = input_text.replace('<textarea', '<textarea')
        input_text = input_text.replace('</textarea>', $(input_id).text() + '</textarea>')
    }
    else if (input_type == 5) {

    }
    else {
        var str = $(input_id).text();
        if (input_text.indexOf("date") > -1) {
            if ($(input_id).val() == "") {
                if (input_text.indexOf("value=") == -1) {
                    //str = date_input.getFullYear() + "-" + ((date_input.getMonth() + 1) >= 10 ? (date_input.getMonth() + 1) : "0" + (date_input.getMonth() + 1)) + "-" + (date_input.getDate() >= 10 ? date_input.getDate() : "0" + date_input.getDate());
                    input_text = input_text.replace("input", "input  value='" + str + "'");
                }
            }
        } else {
            input_text = input_text.replace("input", "input  value='" + str + "'");
        }

    }

    $.modal({
        title: "",
        text: input_text,
        buttons: [
            { text: "取消", className: "default", onClick: function () { } },
            {
                text: "确定", onClick: function () {
                    if (callback)
                        callback();
                    if (input_type == 3) {
                        $(input_id).text($(".weui_dialog_bd select option:selected").text())
                    } else if (input_type == 4) {
                        $(input_id).text($(".weui_dialog_bd textarea").val())
                    }
                    else if (input_type == 5) {
                    }
                    else {

                        if ($(".weui_dialog_bd input").val() != "") {
                            $(input_id).text($(".weui_dialog_bd input").val())
                        }
                    }
                }
            }
        ]
    });

    //            if (input_type == 4) {
    //                setTimeout('$(".weui_dialog_bd textarea").focus()', 600)
    //            } else if (input_type == 3) {
    //            } else if (input_type == 4) {
    //
    //            } else {
    //                setTimeout('$(".weui_dialog_bd input").focus()', 600)
    //            }



}

//匹配设备MAC的正则
function IsMac(_mac) {
    var reg_name = /[A-F\d]{2}-[A-F\d]{2}-[A-F\d]{2}-[A-F\d]{2}-[A-F\d]{2}-[A-F\d]{2}/;
    return reg_name.test(_mac);
}

//自动给设备MAC中间加“-”
function MacFormat(_str) {
    _result = _str.toUpperCase().replaceAll(':', '-');
    if (_result.indexOf('-') < 0 && _result.length == 12) {
        return _result.substr(0, 2) + '-' + _result.substr(2, 2) + '-' + _result.substr(4, 2) + '-'
                    + _result.substr(6, 2) + '-' + _result.substr(8, 2) + '-' + _result.substr(10, 2);
    }

    if (_result.length < 15 && _result.replaceAll('-', '').length % 2 == 0 && _result.charAt(_result.length - 1) != '-')
        _result += "-";
    return _result;
}

/*对象深度克隆*/
function deepClone(obj) {
    var result = {}, oClass = isClass(obj);
    for (key in obj) {
        var copy = obj[key];
        if (isClass(copy) == "Object") {
            result[key] = arguments.callee(copy);
        } else if (isClass(copy) == "Array") {
            result[key] = arguments.callee(copy);
        } else {
            result[key] = obj[key];
        }
    }
    return result;
}
function isClass(o) {
    if (o === null) return "Null";
    if (o === undefined) return "Undefined";
    return Object.prototype.toString.call(o).slice(8, -1);
}
//手机号验证
function phone_yz(tel) {
    var reg = /^0?1[3|4|5|8|7][0-9]\d{8}$/;
    if (reg.test(tel)) {
        return true;
    } else {
        return false;
    };
}
/*实现数组includes方法*/
function includes(array, searchElement/*, fromIndex*/) {
    'use strict';
    var O = array;
    var len = parseInt(O.length) || 0;
    if (len === 0) {
        return false;
    }
    var n = parseInt(arguments[2]) || 0;
    var k;
    if (n >= 0) {
        k = n;
    } else {
        k = len + n;
        if (k < 0) { k = 0; }
    }
    var currentElement;
    while (k < len) {
        currentElement = O[k];
        if (searchElement === currentElement ||
           (searchElement !== searchElement && currentElement !== currentElement)) {
            return true;
        }
        k++;
    }
    return false;
}
function RefreshToken() {
    $.ajax({
        type: "get",
        url: "/Weixin/RefreshToken/hanguominhaoer",
        dataType: 'json',
        success: function (obj) {
            if (obj.ResultCode == 0) {

            } else {

            }
        }
    });
}

// 写cookie
function setCookie(name, value, days) {
    var Days = typeof (days) == "undefined" ? 720 : days;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
    document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString();
    if (localStorage) {
        localStorage.setItem(name, value);
    }
}

// 读取cookies
function getCookie(name) {
    var arr, reg = new RegExp("(^| )" + name + "=([^;]*)(;|$)");
    if (arr = document.cookie.match(reg))
        return unescape(arr[2]) == "" ? null : unescape(arr[2]);
    else if (localStorage) {
        return localStorage.getItem(name);
    }
    return null;
}

// 删除cookies
function delCookie(name) {
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval = getCookie(name);
    localStorage.removeItem(name)
    if (cval != null)
        document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
}

//动态加载
function loadExtentFile(filePath, fileType, successCallback, errorCallback) {
    if (fileType == "js") {
        var oJs = document.createElement('script');
        oJs.setAttribute("type", "text/javascript");
        oJs.setAttribute("src", filePath);
        oJs.setAttribute("charset", "utf-8");
        document.getElementsByTagName("head")[0].appendChild(oJs);
        oJs.onload = oJs.onreadystatechange = function () {
            if (!this.readyState || this.readyState == 'loaded' || this.readyState == 'complete') {
                if (successCallback)
                    successCallback();
            } else {
                if (errorCallback)
                    ;//      errorCallback();
            }
            oJs.onload = oJs.onreadystatechange = null;
        }
        oJs.onerror = function () {
            if (errorCallback)
                errorCallback();
        }
    } else if (fileType == "css") {
        var oCss = document.createElement("link");
        oCss.setAttribute("rel", "stylesheet");
        oCss.setAttribute("type", "text/css");
        oCss.setAttribute("href", filePath);
        document.getElementsByTagName("head")[0].appendChild(oCss); //绑定
    }
}

////振动
//function shock() {
//    if (vibrate_set) {
//        if (navigator.vibrate) {
//            navigator.vibrate(100); //震动100毫秒
//        } else if (navigator.webkitVibrate) {
//            navigator.webkitVibrate(100);
//        }
//    }
//}
//在指定的字符串位置添加字符串 flg要插入的字符串，sn位置
function insert_flg(str, flg, sn) {
    var newstr = "";
    for (var i = 0; i < str.length; i++) {
        if (i == sn) {
            newstr += flg;
        }
        newstr += str[i]
    }
    return newstr;
}

Array.prototype.skip = function (index) {
    var tmpArr = new Array();

    if (this.length > index)
        for (var i = index; i < this.length; i++)
            tmpArr.push(this[i]);

    return tmpArr;
}

Array.prototype.take = function (index) {
    var tmpArr = new Array();

    for (var i = 0; i < index; i++)
        if (this.length > i)
            tmpArr.push(this[i]);

    return tmpArr;
}

function SetUrlRefresh(url) {
    if (url.indexOf("?") > 0) {
        return url + "&t=" + (new Date().getTime());
    } else {
        return url + "?t=" + (new Date().getTime());
    }
}

//去除数组中重复的数字
function unique(arr) {
    var result = [], isRepeated;
    for (var i = 0, len = arr.length; i < len; i++) {
        isRepeated = false;
        for (var j = 0, len = result.length; j < len; j++) {
            if (arr[i] == result[j]) {
                isRepeated = true;
                break;
            }
        }
        if (!isRepeated) {
            result.push(arr[i]);
        }
    }
    return result;
}

function call_hb() {
    FuncAjax_Jsonp("http://192.168.78.66:8181/usb/portal/cgi-bin/call_hb_jsonp.cgi", "", "", false);
}
//比较两个时间的大小
function dateCompare(startStr, endStr) {
    startStr = startStr.replaceAll('/', '-');
    endStr = endStr.replaceAll('/', '-');
    endStr = updateDate(endStr);
    startStr = updateDate(startStr);
    var arr = startStr.split("-");
    var starttime = new Date(startStr);
    var starttimes = starttime.getTime();

    var arrs = endStr.split("-");
    var lktime = new Date(endStr);
    var lktimes = lktime.getTime();

    if (starttimes > lktimes) {

        return false;
    }
    else
        return true;
}
//时间是否相同
function isequaltime(startStr, endStr) {
    startStr = startStr.replaceAll('/', '-');
    endStr = endStr.replaceAll('/', '-');
    endStr = updateDate(endStr);
    startStr = updateDate(startStr);
    var arr = startStr.split("-");
    var starttime = new Date(startStr);
    var starttimes = starttime.getTime();
    var arrs = endStr.split("-");
    var lktime = new Date(endStr);
    var lktimes = lktime.getTime();
    if (starttimes == lktimes) {

        return true;
    }
    else
        return false;
}
function updateDate(date) {
    date = date.replaceAll('/', '-');
    var arr = date.split("-");
    if (arr[1].length == 1) {
        arr[1] = "0" + arr[1];
    }
    if (arr[2].length == 1) {
        arr[2] = "0" + arr[2];
    }
    return arr[0] + "-" + arr[1] + "-" + arr[2];
}

function errorImg() {
    var img = event.srcElement;
    img.src = "/View/img/logo.jpg";
    img.onerror = null;
}
//微信jssdk需要
function randomString(len) {
    len = len || 32;
    var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890';
    var maxPos = $chars.length;
    var pwd = '';
    for (i = 0; i < len; i++) {
        pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
    }
    return pwd;
}

//获取字符长度
function getByteLen(val) {
    var len = 0;
    for (var i = 0; i < val.length; i++) {
        var a = val.charAt(i);
        if (a.match(/[^\x00-\xff]/ig) != null) {
            len += 3;
        }
        else {
            len += 1;
        }
    }
    return len;
}
function stripscript(s) {//去除字符串中的标点符号
    var pattern = new RegExp("^[\u4E00-\u9FA5A-Za-z0-9]")
    var rs = "";
    for (var i = 0; i < s.length; i++) {
        if (s.substr(i, 1).replace(pattern, '') == '') {
            rs = rs + s.substr(i, 1);
        }
    }
    return rs;
}
/** 数字金额大写转换(可以处理整数,小数,负数) */
var digitUppercase = function (n) {
    var fraction = ['角', '分'];
    var digit = [
        '零', '壹', '贰', '叁', '肆',
        '伍', '陆', '柒', '捌', '玖'
    ];
    var unit = [
        ['元', '万', '亿'],
        ['', '拾', '佰', '仟']
    ];
    var head = n < 0 ? '欠' : '';
    n = Math.abs(n);
    var s = '';
    for (var i = 0; i < fraction.length; i++) {
        s += (digit[Math.floor(n * 10 * Math.pow(10, i)) % 10] + fraction[i]).replace(/零./, '');
    }
    s = s || '整';
    n = Math.floor(n);
    for (var i = 0; i < unit[0].length && n > 0; i++) {
        var p = '';
        for (var j = 0; j < unit[1].length && n > 0; j++) {
            p = digit[n % 10] + unit[1][j] + p;
            n = Math.floor(n / 10);
        }
        s = p.replace(/(零.)*零$/, '').replace(/^$/, '零') + unit[0][i] + s;
    }
    return head + s.replace(/(零.)*零元/, '元')
        .replace(/(零.)+/g, '零')
        .replace(/^整$/, '零元整');
};
var usertype = [{ id: 1, name: "管理员" }, { id: 2, name: "监测人员" }, { id: 4, name: "检查人员" }]
function judgeUserType(num) {
    var str = "";
    var count = 0;
    for (var i = 0; i < usertype.length; i++) {
        if ((num & usertype[i].id) == usertype[i].id) {
            if (count != 0) {
                str += "和"
            }
            count++;
            str += usertype[i].name;
        }
    }
    return str;

}
function deleteData(list, data) {
    var persons = list
    for (var i = 0; i < persons.length; i++) {
        var cur_person = persons[i];
        if (JSON.parse(cur_person) == JSON.parse(data)) {
            list.splice(i, 1);
        }
    }
    return list;
}
//将字符串自动换行str:字符串，type:1:<br>换行2:\r\n换行
function Wrapstr(str, type, index) {
    if (str == null) {
        return null;
    }
    var restr = ""
    var charcount = 0;
    for (var i = 0; i < str.length; i++) {
        if (charcount >= index * 2 && i != 0) {
            if (type == 1) {
                restr += "<br>"
            }
            if (type == 2) {
                restr += "\r\n"
            }
            charcount = 0;

        }
        charcount += String.gblen(str[i])
        restr += str[i]
    }
    return restr;
}
//根据文件后缀选择图标type:1返回图标代码，2返回数值（1是图片，2是其他）
function chooseicon(filename, type) {
    filename = filename.toLowerCase();
    var icon = "";
    var icontype = 2;
    if (filename.indexOf('.png') > -1 || filename.indexOf('.bmp') > -1 || filename.indexOf('.jpg') > -1 || filename.indexOf('.svg') > -1) {
        icon = "glyphicon glyphicon-picture"
        icontype = 1;
        //文件：
    } else if (filename.indexOf('.xlsx') > -1 || filename.indexOf('.xlsm') > -1 || filename.indexOf('.xltx') > -1 || filename.indexOf('.xls') > -1) {
        icon = "fa fa-file-excel-o fa-1x"
    } else if (filename.indexOf('.docx') > -1 || filename.indexOf('.docm') > -1 || filename.indexOf('.doc') > -1 || filename.indexOf('.dotm') > -1) {
        icon = "fa fa-file-word-o fa-1x"
    } else if (filename.indexOf('.pptx') > -1 || filename.indexOf('.pptm') > -1 || filename.indexOf('.ppsx') > -1 || filename.indexOf('.ppsx') > -1) {
        icon = "fa fa-file-powerpoint-o fa-1x"
    } else if (filename.indexOf('.pdf') > -1) {
        icon = "fa fa-file-pdf-o"
    } else if (filename.indexOf('.zip') > -1 || filename.indexOf('.rar') > -1) {
        icon = "fa fa-file-zip-o fa-1x"
    } else if (filename.indexOf('.txt') > -1) {
        icon = "fa fa-file-text-o fa-1x"
    } else {
        icon = "glyphicon glyphicon-file";
    }
    if (type == 1) {
        return icon;
    } else if (type == 2) {
        return icontype;
    }
}