# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.name a').widthTruncate({width:64})
  $('.category-body a').widthTruncate({width:140})
  $('.avatar a').fancybox();
  $('.pop_fancy_box').fancybox();