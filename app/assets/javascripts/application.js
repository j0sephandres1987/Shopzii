// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require underscore
//= require json2
//= require judge
//= require froala_editor.min.js
//= require plugins/fullscreen.min.js
//= require plugins/font_family.min.js
//= require plugins/font_size.min.js
//= require plugins/colors.min.js
//= require plugins/tables.min.js
//= require plugins/lists.min.js
//= require langs/es.js
//= require confirm_with_reveal
//= require jquery.zoom.js
//= require_tree .

$(function(){ $(document).foundation(); });

$(document).ready(function() {
    $(".description-wysiwyg").editable({ inlineMode: false, placeholder: "Escriba una descripcion", buttons: ['bold', 'italic', 'underline', 'strikeThrough', 'sep', 'formatBlock', 'fontFamily', 'fontSize', 'color', 'sep', , 'indent', 'outdent', 'align', 'sep', 'insertOrderedList', 'insertUnorderedList', 'table', 'createLink', 'insertHorizontalRule', 'sep', 'html', 'fullscreen'], language: 'es' });
    $('.main-image').zoom(); // add zoom
    $(".thumb-container img").mouseover(function() {
        $(this).addClass("glow-over");
    });
    $(".thumb-container img").mouseout(function() {
        $(this).removeClass("glow-over");
    });

    $(".thumb-container img").click(function() {
        var imgUrl = $(this).attr("src");
        $(".main-image img").attr("src", imgUrl);
    });
});







