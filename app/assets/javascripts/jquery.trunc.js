(function($){
 $.fn.extend({
 
 	widthTruncate: function(options) {
		var defaults = {
			width: 'auto',
			after: '...'
		};
		
	  var options = $.extend(defaults, options);
	  
	  return this.each(function() {
	  if(options.width=='auto'){ truncateWidth=$(this).parent().width()-8; }else{ truncateWidth = options.width}
			 if($(this).width()>truncateWidth){		 
			 var smaller_text = $(this).text();
			 $(this).html('<span id="truncateWrapper" style="display:inline;">'+options.after+'</div>');
			 		i=1;
			         while ($('#truncateWrapper').width() < truncateWidth) {
						$('#truncateWrapper').html(smaller_text.substr(0, i) + options.after);
						i++;
					}
					$(this).html($('#truncateWrapper').html());
			}
		
	  });
	  
	}

 });
})(jQuery);
