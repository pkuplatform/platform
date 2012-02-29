# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  uid = $('input[name=uid]').val()

  # Juggernaut client
  jug = new Juggernaut
  jug.subscribe "channel-#{uid}", (msg) ->
    if msg.type == 'rec_msg'
      if($("chat-box-#{msg.sid}").size() == 0)
        $('chat-boxes').prepend("<div id='chat-box-#{msg.sid}'></div>")
      $("chat-box-#{msg.sid}").prepend(msg.content)

  # site index pictures cycle
  $('.pics').cycle({
    fx: "fade",
    pager: '.pager',
    pagerAnchorBuilder: (idx, slide) ->
      "<li><a href='#'><img src='" + slide.src + "' width='150' /></a></li>"
  })

  # search form validation
  $('.search form').submit ->
    $('.search input[type=text]').val().length > 0
  
  # newsfeeds picture zoom
  $('.newsfeeds').on('click', '.center img', ->
    $(this).parents('.center').toggleClass("small"))

  # backend ajax form submit
  $('.admin.app-form form select').change ->
    $(this).parent('form').submit()

  # fancy box - used in albums
  $('a.gallery_pics').fancybox
    helpers:
      title:
        type: "over"

  # used in tags
  $('.tags_input').tagsInput
    'defaultText': '添加标签'
    'height': '50px'
    'width': '400px'

  # jquery purr
  $('.registration .flashes').each ->
    $(this).purr
      'isSticky': true

  $('.flashes:not(.registration .flashes)').each ->
    $(this).purr()

  $(".carousel-items").carouFredSel
    auto : false
    prev : ".prev,left"
    next : ".next,right"
    width: "98%"

  $(".groups form li label").click ->
    id = $(this).attr('for')
    $(".groups form li").hide()
    $(".groups form .first").show()
    $("#"+id).parent('li').show();

  $('.show-category .category').children('a').css('color','rgb(226,136,26)');

  $('.submit-btn').click ->
    $('form').submit()

