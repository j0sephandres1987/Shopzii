$(document).ready(function() {
    //Validates submited form
    $("form[data-validation='true'] input:submit").click(function(event) {
        event.preventDefault();
        $(".login-error").html("");
        var errorMessageArrayTag = ["<small class='error small-error'>", "", "</small>"];
        var allValid = 0;
        $( "input[validation='true']" ).each(function (idx, elm) {
            judge.validate(document.getElementById(elm.id), {
                valid: function(element) {
                    if($("#"+elm.id).hasClass("input-error")) {
                        $("#"+elm.id).removeClass("input-error");
                        $("#"+elm.id).prev().removeClass("label-error");
                        $("#"+elm.id).next().remove();
                    }
                },
                invalid: function(element, messages) {
                    allValid++;
                    console.log("invalid");
                    if(!$("#"+elm.id).hasClass("input-error")) {
                        errorMessageArrayTag[1] = messages;
                        $("#"+elm.id).addClass("input-error");
                        $(".success").find(".alert-box").remove();
                        $(errorMessageArrayTag.join("")).insertAfter($("#"+elm.id));
                    }
                }
            });
        });
        if(allValid == 0) {
            $("form[data-validation='true']").unbind("submit");
            $("form[data-validation='true']").submit();
        }
    });

});