
$(function() {
	// Check all the checkboxes when the head one is selected
	$(".checkall").live("click", function() {
	    $("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
	});
	
	// change current active tabs styles
	$('.ui-state-default a').click(function(){
		$('.ui-state-default').removeClass("ui-tabs-selected");
		$('.ui-state-default').removeClass("ui-state-active");
		$(this).parent().addClass("ui-tabs-selected");
		$(this).parent().addClass("ui-state-active");
		history.pushState(null, document.title, this.href);
	});
	
	// handle pagination through ajax
	$("#tabs-messages .pagination a").live("click", function(e) {
		$.getScript(this.href);
		history.pushState(null, document.title, this.href);
		e.preventDefault();
	});
	
	//bind window for postate
	$(window).bind("popstate", function() {
		$.getScript(location.href);
	});

  $("#user_nameid").autocomplete({
    source:function(req,res){
      $.getJSON("/profiles",{q: req.term}, res);
    },
    delay: 100,
    html: true
  });

	$("#user_nameid").blur(function() {
		var reg=/\((\d+)\)/;
		chk = this.value.match(reg);
		if (chk==null&&this.value!='')
		{
			$(this).css("background-color","#c00");
		} else {
			if (chk!=null) $("#user_tokens").attr("value",chk[1]);
			$(this).css("background-color","#fff");
			return true;
		}
	});
	$("#user_nameid").focus(function() {
			$(this).css("background-color","#ffd");
	});
});
