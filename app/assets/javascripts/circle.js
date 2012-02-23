$(document).ready(function() {
  $('.users-table table').dataTable({
    "bJQueryUI": true,
    "aoColumns":[
      { "bSortable": false},
      null,
      null,
      null,
    ]
  });
  $('.multi-select').multiselect({
    beforeclose:function(){
      $(this).parent("form").submit();
    },
  });
  $('.multi-select-box').multiselect_box({close:function(){
  }});
});