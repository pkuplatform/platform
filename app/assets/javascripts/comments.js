$(function() {
  function findq(s) {
    if (s.lastIndexOf('@')>=0)
      return s.split('@').pop();
    else return null;
  }
  var listening = false;
  $(".autocompletable")
    .bind("keyup", function(event) {
      if ((event.keyCode == $.ui.keyCode.TAB) && $(this).data( "autocomplete" ).menu.active) {
        listening = false;
        event.preventDefault();
      }
      if (event.shiftKey) {
        listening = true;
      }
      if (event.ctrlKey&&event.which==13) {
        $("form#new_comment").submit();
      }
      if (findq(this.value)==null) {
        listening = false;
      }
    })
    .autocomplete({
      source: function(req, res) {
        if (listening) {
          $.getJSON("/profiles",{q: findq(req.term)}, res);
        } else { res([]) }
      },
      focus: function() { return false; },
      select: function(event, ui) {
        var terms = this.value.split('@');
        terms.pop();
        terms.push(ui.item.value);
        this.value = terms.join("@");
        listening = false;
        return false;
      },
      html: true
    });
    $(".mention-tag").click(function(event) {
      $("#comment_body").each(function(){
        $(this).focus();
        this.value += '@';
        listening = true;
        $(this).autocomplete("search");
      })
      event.preventDefault();
      return false;
    });
    $("#new_comment").submit(function(e){
      $('input[type=submit]', this).attr('disabled','disabled');
      $('textarea', this).attr('readonly','readonly');

    });
});
$.fn.commentReopen = function(options) {
  var defaults={clear: true, failed: false};
  var options = $.extend(defaults, options);
  return this.each(function() {
      $('input[type=submit]', this).removeAttr('disabled');
      $('textarea', this).removeAttr('readonly');
      if (options.clear) {
        $('textarea',this).attr("value","");
      }
      if (options.failed) {
        alert("评论失败！内容不能为空")
      }
  });
};

$.fn.commentReply = function(options) {
  return this.each(function() {
    var $comm = $(this).parent('ul');
    $comm.find('.avatar img').attr("src",$('.avatar img',this).attr("src"));
  });
}
