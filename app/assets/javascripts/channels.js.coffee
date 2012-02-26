# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  uid = $('input[name=uid]').val()

  jug = new Juggernaut
  jug.subscribe "channel-#{uid}", (msg) ->
    if msg.type == 'rec_msg'
      if($("chat-box-#{msg.sid}").size() == 0)
        $('chat-boxes').prepend("<div id='chat-box-#{msg.sid}'></div>")
      $("chat-box-#{msg.sid}").prepend(msg.content)
