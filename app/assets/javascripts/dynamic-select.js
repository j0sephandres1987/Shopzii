$(document).ready(function() {
    $(".child-dynamic-select").parent().hide();
    var childData = $(".child-dynamic-select").html();
    var parentSelectedOption = $(".parent-dynamic-select :selected").text();
    var options = $(childData).filter("optgroup[label='"+parentSelectedOption+"']").html();
    if(options){
        $(".child-dynamic-select").html(options);
        $(".child-dynamic-select").parent().show();
    }else {
        $(".child-dynamic-select").parent().hide();
    }
    $(".parent-dynamic-select").change(function(){
        var parentSelectedOption = $(".parent-dynamic-select :selected").text();
        var options = $(childData).filter("optgroup[label='"+parentSelectedOption+"']").html();
        if(options){
            $(".child-dynamic-select").html(options);
            $(".child-dynamic-select").parent().show();
        }else {
            $(".child-dynamic-select").parent().hide();
        }
    });
});