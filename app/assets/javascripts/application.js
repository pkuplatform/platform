// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require jquery-ui
//= require_tree .
//= require ckeditor/ckeditor
//= require fancybox

$.fn.scrollToAndActivate = function(options) {
  return this.each(function() {
    $.scrollTo(this, 300, {over:-2 ,onAfter:function(obj) {
      $(obj).addClass("active");
    }});
  });
};

function update_newsfeeds() {
  if ($('.site.index').size() == 0) return;
  val = $('.hidden input[type=hidden]').val();
  $.get('site/newsfeeds', { q: val });
  setTimeout('update_newsfeeds()', 10000);
}

$(document).ready(function(){

  update_newsfeeds();

  $('.feedbacks').tabSlideOut({
    tabHandle: '.handle',                              //class of the element that will be your tab
    pathToTabImage: '/assets/contact.gif',          //path to the image for the tab *required*
    imageHeight: '122px',                               //height of tab image *required*
    imageWidth: '40px',                               //width of tab image *required*    
    tabLocation: 'left',                               //side of screen where tab lives, top, right, bottom, or left
    speed: 300,                                        //speed of animation
    action: 'click',                                   //options: 'click' or 'hover', action to trigger animation
    topPos: '80px',                                   //position from the top
    fixedPosition: true                               //options: true makes it stick(fixed position) on scroll
  });
  $('input').focus(function() {
    $(this).parent().addClass("active");
  });
  $('input').blur(function() {
    $(this).parent().removeClass("active");
  });
  $('input').hover(function() {
    $(this).parent().addClass("hovering");
  });
  $('input').mouseout(function() {
    $(this).parent().removeClass("hovering");
  });


  CKEDITOR.config.toolbar_Basic =
  [
   ['Bold', 'Italic', '-', 'NumberedList', 'BulletedList', '-', 'Link', 'Unlink','Attachment','-','About']
  ];

  $("a[_cke_saved_href]").each(function() {
      var lCkeSavedHref = $(this).attr("_cke_saved_href");
      lCkeSavedHref = lCkeSavedHref.replace(/http:\/\/http:\/\//g, "http://");
      lCkeSavedHref = lCkeSavedHref.replace(/javascript:/g, "");
      this.href = lCkeSavedHref;
  })
  $(".best_in_place").best_in_place();

  $(location.hash).scrollToAndActivate();

  $(window).bind( 'hashchange', function(event){
    event.preventDefault();
    $(".active").removeClass("active");
    $(location.hash).scrollToAndActivate();
  });
    
});

