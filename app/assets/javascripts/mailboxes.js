$(function() {
	// Check all the checkboxes when the head one is selected
	$(".checkall").live("click", function() {
    $("input[type='checkbox']").attr('checked', $(this).is(':checked'));   
	});

	// handle pagination through ajax
	$("#tabs-messages .pagination a").live("click", function(e) {
		$.getScript(this.href);
		history.pushState(null, document.title, this.href);
		e.preventDefault();
	});

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
