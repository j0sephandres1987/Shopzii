$(document).ready(function() {
    var modalMessage = $("#view-info").attr("modal-message");
    if($("#view-info").attr("not-confirm") == "true") {
        $(document).confirmWithReveal({
            ok: 'Aceptar',
            cancel: 'Aceptar',
            modal_class: 'small text-center not-confirm',
            title: '',
            body: modalMessage
        })
    } else {
        $(document).confirmWithReveal({
            ok: 'Eliminar',
            cancel: 'Cancelar',
            modal_class: 'small text-justify',
            title: 'Seguro que desea eliminar?',
            body: modalMessage
        })
    }
});