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
  $('.pics').cycle
    fx: "fade",
    pager: '.pagers',
    pagerAnchorBuilder: (idx, slide) ->
      "<li><a href='#'><img src='" + slide.src + "' width='150' /></a></li>"

  $('.hot-cycle').cycle
    fx: "scrollVert"
    speed: 1000
    timeout: 10000

  # search form validation
  $('.search form').submit ->
    $('.search input[type=text]').val().length > 0
  
  # newsfeeds picture zoom
  $('.newsfeed').on('click', '.center img', ->
    $(this).parents('.center').toggleClass("small"))

  # backend ajax form submit
  $('table form select').change ->
    $(this).parent('form').submit()

  # fancy box - used in albums
  $('a.gallery_pics').fancybox
    helpers:
      title:
        type: "over"

  # used in tags
  $('.tags_input').tagsInput
    'defaultText': '添加标签'
    'width' : '396px'
    'height' : '40px'


  # jquery purr
  $('.registration .flashes').each ->
    $(this).purr
      'isSticky': true

  $('.carousel').carousel()

  $('.flashes:not(.registration .flashes)').each ->
    $(this).purr()

  $(".groups form li label").click ->
    id = $(this).attr('for')
    $(".groups form li").hide()
    $(".groups form .first").show()
    $("#"+id).parent('li').show();

  $('.submit-btn').click ->
    $('form').submit()

  $('ul.nav.nav-tabs a:first').tab 'show'

  $('.tags-filter').tokenInput "tags.json"
    "tokenValue" : "name"
    "prePopulate" : JSON.parse($("#tags-json").html())
    "theme" : "facebook"
    "hintText" : "输入要搜索的标签"

  # bootstrap modal
  $('.modal').modal
    show: false
  # bootstrap
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()


  # Data Table
  $('#circles-table').dataTable
    sDom : "<'row'<'span4'l><'span3'f>r>t<'row'<'span3'i><'span4'p>>"
    sPaginationType : "bootstrap"
    aoColumns: [ null, null, null, {bSortable:false}, {bSortable:false} ]

  CKEDITOR.config.skin = 'BootstrapCK-Skin'

  $('.carousel-items').carouFredSel
    auto : false
    prev : 
      button : ".prev"
    next :
      button : ".next"
    pagination : false

