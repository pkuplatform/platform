// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .
//= require ckeditor/ckeditor

$(document).ready(function(){
  $notice = $("#notice");
  if ($notice.html()) {
    $.fancybox(
      $notice.html(),
        {
          'transitionIn'  : 'none',
          'transitionOut' : 'none',
    });
  }
  $alert = $("#alert");
  if ($alert.html()) {
    $.fancybox(
      $alert.html(),
        {
          'transitionIn'  : 'none',
          'transitionOut' : 'none'
    });
  }
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
});


