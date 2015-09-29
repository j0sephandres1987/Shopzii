$.fn.loadImage = function(input) {
    $(this).each(function() {
        var li = $(this).parent();
        var photo = $(li).attr("photo");
        if(photo == "false") {
            $(li).find("img").attr("id", $(this).attr('id') + "-preview");
            $(li).find("i").css("display", "none");
            $(li).find("p").css("display", "none");
            $(li).css("border", "none");
            $(li).find("img").css("position", "absolute");
            $(li).find("img").css("z-index", -1);
            $(li).append('<i class="fi-x close">Eliminar</i>').click(function() {
                $(li).clearImage(this);
            });
            $(".close").css({"cursor":"pointer", "color": "#7a7a7a", "font-size":"0.7em","margin-top": "105px", "position": "absolute", "z-index": "1"});
        }
    });
}

$.fn.previewImage = function(input) {
    var li = $(input).parent();
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
            $(li).append('<img class="preview-image" id="'+$(input).attr('id') + "-preview" +'" src="#" width="100" height="100">');
            var img = $(li).find("img");
            $(li).find("i").css("display", "none");
            $(li).find("p").css("display", "none");
            $(li).css("border", "none");
            $("#" + img.attr('id')).attr('src', e.target.result);
            $(li).find("img").css("position", "absolute");
            $(li).find("img").css("z-index", -1);
            $(li).append('<i class="fi-x close">Eliminar</i>').click(function() {
                $(li).clearImage(this);
            });
            $(".close").css({"cursor":"pointer", "color": "#7a7a7a", "font-size":"0.7em","margin-top": "105px", "position": "absolute", "z-index": "1"});
        }
        reader.readAsDataURL(input.files[0]);
    }
}

$.fn.clearImage = function(li) {
    $(li).find("img").remove();
    $(li).find("i[class='close']").remove();
    $(li).find("i").css("display", "block");
    $(li).find("p").css("display", "block");
    $(li).css("border", "1px dashed #7a7a7a");
}

$(document).ready(function() {
    $(".upload_photo").loadImage(this);
    $(".upload_photo").change(function(){
        $(".upload_photo").previewImage(this);
    });

    /*$(".close").click(function(){
        console.log("sdfgfdgdfsg");
        //$(".close").clearImage(this);
    });*/
});