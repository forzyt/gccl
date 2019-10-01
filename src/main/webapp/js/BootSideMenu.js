/**
 * BootSideMenu v 1.0
 * Author: Andrea Lombardo
 * http://www.lombardoandrea.com
 * https://github.com/AndreaLombardo/BootSideMenu
 * */
(function ($) {

    $.fn.BootSideMenu = function (userOptions) {

        var initialCode;
        var newCode;
        var menu;
        var prevStatus;
        var body = {};

        var defaults = {
            side: "left",
            duration: 500,
            remember: true,
            autoClose: false,
            pushBody: true,
            closeOnClick: true,
            width: "15%",
            onTogglerClick: function () {
                //code to be executed when the toggler arrow was clicked
            },
            onBeforeOpen: function () {
                //code to be executed before menu open
            },
            onBeforeClose: function () {
                //code to be executed before menu close
            },
            onOpen: function () {
                //code to be executed after menu open
            },
            onClose: function () {
                //code to be executed after menu close
            },
            onStartup: function () {
                //code to be executed when the plugin is called
            }
        };

        var options = $.extend({}, defaults, userOptions);


        body.originalMarginLeft = $("body").css("margin-left");
        body.originalMarginRight = $("body").css("margin-right");
        body.width = $("body").width();

        initialCode = this.html();

        newCode = "<div class=\"row\" >";
        newCode += "	<div class=\"col-xs-12  col-sm-12 col-md-12 col-lg-12\" style=\"overflow-x: hidden;\">\n" + initialCode + " </div>";
        newCode += "</div>";
        newCode += "<div class=\"toggler\" data-whois=\"toggler\">";
        newCode += "	<span class=\"glyphicon\">&nbsp;</span>";
        newCode += "</div>";

        this.empty();
        this.append(newCode);
        //newCode = "<div class=\"toggler\" data-whois=\"toggler\">";
        //newCode += "	<span class=\"glyphicon\">&nbsp;</span>";
        //newCode += "</div>";
        //this.appendTo(newCode)

        menu = $(this);

        menu.addClass("container");
        menu.addClass("sidebar");
        //menu.css("width", options.width);

        if (options.side == "left") {
            menu.addClass("sidebar-left");
        } else if (options.side == "right") {
            menu.addClass("sidebar-right");
        }

        menu.id = menu.attr("id");
        menu.cookieName = "bsm2-" + menu.id;
        menu.toggler = $(menu.children()[1]);
        menu.originalWidth = menu.width();
        menu.originalPushBody = options.pushBody;
        menu.row = $(menu.children()[0]);


        if (options.remember) {
            prevStatus = readCookie(menu.cookieName);
        } else {
            prevStatus = null;
        }

        forSmallBody();

        switch (prevStatus) {
            case "opened":
                startOpened();
                break;
            case "closed":
                startClosed();
                break;
            default:
                startDefault();
                break;
        }

        if (options.onStartup !== undefined) {
            options.onStartup(menu);
        }

        //aggiungi icone a tutti i collapse
        //$("[data-toggle=\"collapse\"]", menu).each(function () {
        //    var icona = $("<span class=\"glyphicon glyphicon-chevron-right\"></span>");
        //    $(this).prepend(icona);
        //});

        menu.off("click", "[data-whois=toggler]");
        menu.on("click", "[data-whois=toggler]", function () {
            toggle();
            if (options.onTogglerClick !== undefined) {
                options.onTogglerClick(menu);
            }
        });

        menu.off("click", ".list-group-item");
        menu.on("click", ".list-group-item", function () {
            menu.find(".list-group-item").each(function () {
                $(this).removeClass("active");
            });
            $(this).addClass("active");
            $(".glyphicon", this).toggleClass("glyphicon-chevron-right").toggleClass("glyphicon-chevron-down");
        });


        menu.off("click", "a.list-group-item");
        menu.on("click", "a.list-group-item", function () {
            if (options.closeOnClick) {
                if ($(this).attr("data-toggle") != "collapse") {
                    closeMenu(true);
                }
            }
        });


        function toggle() {
            if (menu.status == "opened") {
                closeMenu(true);
            } else {
                openMenu(true);
            }
        }

        function switchArrow(side) {
            var span = menu.toggler.find("span.glyphicon");
            if (side == "left") {
                span.removeClass("glyphicon-chevron-left");
                span.addClass("glyphicon-chevron-right");
            } else if (side == "right") {
                span.removeClass("glyphicon-chevron-right");
                span.addClass("glyphicon-chevron-left");
            }
        }

        function startDefault() {
            if (options.side == "left") {
                if (options.autoClose) {
                    menu.status = "closed";
                    menu.hide().animate({
                        //left: -(menu.width() + 2)
                    }, 1, function () {
                        menu.show();
                        switchArrow("left");
                    });
                } else if (!options.autoClose) {
                    switchArrow("right");
                    menu.status = "opened";
                    if (options.pushBody) {
                        //$("#div_Operating").css("margin-left", menu.width() + 20);
                    }
                }
            } else if (options.side == "right") {
                if (options.autoClose) {
                    menu.status = "closed";
                    menu.hide().animate({
                        //right: -(menu.width() + 2)
                    }, 1, function () {
                        menu.show();
                        switchArrow("right");
                    });
                } else {
                    switchArrow("left");
                    menu.status = "opened";
                    if (options.pushBody) {
                        //$("#div_Operating").css("margin-right", menu.width() + 20);
                    }
                }
            }
        }

        function startClosed() {
            if (options.side == "left") {
                menu.status = "closed";
                menu.hide().animate({
                    left: -(menu.width())
                }, 1, function () {
                    menu.show();
                    switchArrow("left");
                });
                $("#div_Operating").css("margin-left", 20);
            } else if (options.side == "right") {
                menu.status = "closed";
                menu.hide().animate({
                    right: -(menu.width())
                }, 1, function () {
                    menu.show();
                    switchArrow("right");
                })
                $("#div_Operating").css("margin-right", 20);
            }
        }

        function startOpened() {
            if (options.side == "left") {
                switchArrow("right");
                menu.status = "opened";
                if (options.pushBody) {
                    $("#div_Operating").css("margin-left", menu.width() + 20);
                }

            } else if (options.side == "right") {
                switchArrow("left");
                menu.status = "opened";
                if (options.pushBody) {
                    $("#div_Operating").css("margin-right", menu.width() + 20);
                }
            }
        }

        function closeMenu(execFunctions) {
            if (execFunctions) {
                if (options.onBeforeClose !== undefined) {
                    options.onBeforeClose(menu);
                }
            }
            if (options.side == "left") {

                if (options.pushBody) {
                    $("#div_Operating").animate({marginLeft:(20) }, { duration: options.duration });
                    $("#div_Operating").attr("class", "col-md-11 col-xs-11  col-md-offset-1 ");
                  
                }
               
                menu.animate({
                    left: -(menu.width() + 2)
                }, {
                    duration: options.duration,
                    done: function () {
                        switchArrow("left");
                        menu.status = "closed";

                        if (execFunctions) {
                            if (options.onClose !== undefined) {
                                options.onClose(menu);
                            }
                        }
                    }
                });
                
            } else if (options.side == "right") {

                if (options.pushBody) {
                    $("#div_Operating").animate({ marginRight: body.originalMarginRight }, { duration: options.duration });
                    $("#div_Operating").attr("class", "col-md-11 col-md-offset-2 margin-left_20");
                }

                menu.animate({
                    right: -(menu.width() + 2)
                }, {
                    duration: options.duration,
                    done: function () {
                        switchArrow("right");
                        menu.status = "closed";

                        if (execFunctions) {
                            if (options.onClose !== undefined) {
                                options.onClose(menu);
                            }
                        }
                    }
                });
            }

            if (options.remember) {
                storeCookie(menu.cookieName, "closed");
            }

        }

        function openMenu(execFunctions) {

            if (execFunctions) {
                if (options.onBeforeOpen !== undefined) {
                    options.onBeforeOpen(menu);
                }
            }
            menu.row.show()
            if (options.side == "left") {

                if (options.pushBody) {
                    $("#div_Operating").animate({marginLeft: menu.width() + 20},{ duration: options.duration });
                    $("#div_Operating").attr("class", "col-md-9 col-md-offset-2");

                }

                menu.animate({
                    left: 0
                }, {
                    duration: options.duration,
                    done: function () {
                        switchArrow("right");
                        menu.status = "opened";

                        if (execFunctions) {
                            if (options.onOpen !== undefined) {
                                options.onOpen(menu);
                            }
                        }
                    }
                });
            } else if (options.side == "right") {

                if (options.pushBody) {
                    $("#div_Operating").animate({ marginRight: menu.width() + 20 }, { duration: options.duration });
                    $("#div_Operating").attr("class", "col-md-9 col-md-offset-1"); $("#div_Operating").attr("class", "col-md-10");
                }

                menu.animate({
                    right: 0
                }, {
                    duration: options.duration,
                    done: function () {
                        switchArrow("left");
                        menu.status = "opened";

                        if (execFunctions) {
                            if (options.onOpen !== undefined) {
                                options.onOpen(menu);
                            }
                        }
                    }
                });
            }

            if (options.remember) {
                storeCookie(menu.cookieName, "opened");
            }
        }


        function forSmallBody() {
            var bodyWidth = $("body").width();
            if (bodyWidth <= 480) {
                //options.pushBody = false;
                options.closeOnClick = true;
                //menu.css("width", "90%");
            }
        }

        function storeCookie(nome, valore) {
            var d = new Date();
            d.setTime(d.getTime() + (24 * 60 * 60 * 1000));
            var expires = "expires=" + d.toUTCString();
            document.cookie = nome + "=" + valore + "; " + expires + "; path=/";
        }

        function readCookie(nome) {
            var name = nome + "=";
            var ca = document.cookie.split(";");
            for (var i = 0; i < ca.length; i++) {
                var c = ca[i];
                while (c.charAt(0) == " ")
                    c = c.substring(1);
                if (c.indexOf(name) == 0) return c.substring(name.length, c.length);
            }
            return null;
        }


        function onResize() {
            //menu.width(options.width);

            forSmallBody();
            if (menu.status == "closed") {
                startClosed();
            }
            if (menu.status == "opened") {
                startOpened();
            }
        }

        var resizeStart;
        var resizeEnd;
        var wait = 250;
        window.addEventListener("resize", function () {
            resizeStart = new Date().getMilliseconds();
            resizeEnd = resizeStart + wait;
            setTimeout(function () {
                var now = new Date().getMilliseconds();
                if (now > resizeEnd) {
                    onResize();
                }
            }, wait);
        }, false);

        return this;
    }
}(jQuery));