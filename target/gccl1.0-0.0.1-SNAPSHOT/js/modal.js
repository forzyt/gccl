var modalinfo={
    title:"Modal title",
    id:"myModal",
    header: "",
    body: "",
    footer: "",
    place: "#modal",
    height:"310px",
    initial: function () {
        var str = '<div class="modal fade" tabindex="-1" role="dialog" id="' + modalinfo.id + '"><div class="modal-dialog" role="document"><div class="modal-content">';
        str += '<div class="modal-header">';
        str += '<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>';
        str += '<h4 class="modal-title">' + modalinfo.title + '</h4>';
        str += '</div>';
        str += '<div class="modal-body" style="overflow:auto;">';
        str +=modalinfo.body;
    
        str += '</div>';
        str += '<div class="modal-footer">';
        if (modalinfo.footer == "") {
            str += ' <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>';
        } else {
            str += modalinfo.footer;
        }
        str += '</div>';
        str += '</div>';
        str += '</div>';
        str += '</div>';
        $(modalinfo.place).html(str);
    },
    show: function () {
        $('#' + modalinfo.id + '').modal('show');
    }, hide: function () {
        $('#' + modalinfo.id + '').modal('hide');
    }

}
