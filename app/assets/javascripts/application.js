// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require twitter/bootstrap
//= require ckeditor/init
//= require fancybox
//= require_tree .

$.fn.scrollToAndActivate = function(options) {
  return this.each(function() {
    $.scrollTo(this, 200, {over:-3 ,onAfter:function(obj) {
      $(".active").removeClass("active");
      $(obj).addClass("active");
    }});
  });
};

/* Default class modification */
$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline"
} );

/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
}

/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).addClass('pagination').append(
				'<ul>'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			var iListLength = 5;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, iLen=an.length ; i<iLen ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );

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
    
  $('.devise_error').hide();

  $('.need_hide').hide();

  $('#dialog-change-boss').dialog({
    autoOpen:false,
    buttons: {
      "确定(Sure)": function() {
        $("#dialog-change-boss form").submit();
      }
    }
  });
});

