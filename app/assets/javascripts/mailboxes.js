
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
	/*
	$("#user_nameid").blur(function() {
		var reg=/[^\(]*\((\d+)\)/g;
		chk = this.value.match(reg);
		if (chk==null&&this.value!='')
		{
			$(this).css("background-color","#c00");
		} else {
			if (chk!=null) $("#user_tokens").attr("value",this.value.replace(reg, "$1,"));
			$(this).css("background-color","#eee");
			return true;
		}
	});*/

	$(".token-input").tokenInput("/profiles/token.json",{
        propertyToSearch: 'search_name',
		resultsFormatter: function(item){
			return '<li><div class="avatar">' + item["avatar"] + '</div><div class="name">' + item["name"]+ '</div><div class="clear"></div></li>';
		},
		tokenFormatter: function(item){
			return "<li><p>" + item["name"] + "</p></li>"
		},
		theme: "facebook",
		hintText: "请输入收件人",
    prePopulate : JSON.parse($("#recipients-json").html())

	});
});
