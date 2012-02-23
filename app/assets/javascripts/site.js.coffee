# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.pics').cycle({
    fx: "fade",
    pager: '.pager',
    pagerAnchorBuilder: (idx, slide) ->
      "<li><a href='#'><img src='" + slide.src + "' width='150' /></a></li>"
  })

  $('.search form').submit ->
    $('.search input[type=text]').val().length > 0
  
  $('.newsfeeds').on('click', '.center img', ->
    $(this).parents('.center').toggleClass("small"))
