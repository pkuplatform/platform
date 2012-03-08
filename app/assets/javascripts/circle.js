$(document).ready(function() {
  $('.members-table table').dataTable({
    "bJQueryUI":true,
    "aoColumns":[
      { "bSortable": false},
      null,
      null,
      null,
      { "bSortable": false},
      { "bSortable": false},
    ]
  });
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
      $(this).parent("form").submit();
    },
    close:function(){
      $(this).multiselect("refresh");
    },
    noneSelectedText: $('#noneSelectText').html()
  });
  $('.multi-select-box').multiselect_box({close:function(){
  }});


});