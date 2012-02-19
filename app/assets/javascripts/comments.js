$(function() {
  function findq(s) {
    if (s.lastIndexOf('@')>=0)
      return s.split('@').pop();
    else return null;
  }
  var listening = false;
  $("#comment-content")
    .bind("keyup", function(event) {
      if ((event.keyCode == $.ui.keyCode.TAB) && $(this).data( "autocomplete" ).menu.active) {
        listening = false;
        event.preventDefault();
      }
      if (event.shiftKey) {
        listening = true;
      }
      if (event.ctrlKey&&event.which==13) {
        $(this).parent("form").submit();
        event.preventDefault();
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
      $("#comment-content").each(function(){
        $(this).focus();
        this.value += '@';
        listening = true;
        $(this).autocomplete("search");
      })
      event.preventDefault();
      return false;
    });
});
