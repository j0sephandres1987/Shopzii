$(document).change(function() {
    $("#select-all").change(function() {
       var checkboxes = $("input[name='selected[]']");
        if ($("#select-all:checked").length){
            $(checkboxes).attr('checked', true);
            $(".optional-action").css("display", "inline");
        } else {
            $(checkboxes).removeAttr('checked');
            $(".optional-action").css("display", "none")
        }
    });

    $("input[name='selected[]']").click(function() {
        var checkedCheckboxes = $("input:checkbox:checked");
        if (checkedCheckboxes.length > 0){
            $(".optional-action").css("visibility", "visible");
        } else {
            $(".optional-action").css("visibility", "hidden");
        }
    });
});
