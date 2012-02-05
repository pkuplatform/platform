# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".activities .new a").fancybox({'hideOnContentClick':false})
  $(".groups form li label").click ->
    id = $(this).attr('for')
    $(".groups form li").hide()
    $(".groups form .first").show()
    $("#"+id).parent('li').show();
