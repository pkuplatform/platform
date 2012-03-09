$(document).ready(function() {
  $('.applicasnts-table table').dataTable({
    "bJQueryUI":true,
    "aoColumns":[
      { "bSortable": false},
      null,
      null,
      null,
      null,
      { "bSortable": false},
    ]
  });
 $('.multi-select').multiselect({
    open:function(event, ui){
      $('.ui-multiselect-menu input[type=checkbox]').each(function(){
    });
    },
    beforeclose:function(){
    },
    close:function(){
      $(this).parent("form").submit();
      //$(this).multiselect("refresh");
    },
  });
  $('.multi-select-box').multiselect_box({close:function(){
  }});


});
