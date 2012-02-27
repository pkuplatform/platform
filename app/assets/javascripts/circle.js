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
    open:function(event, ui){
      var writableCircles=JSON.parse($("#writable-circles").html())||[];
      $('input[type=checkbox]').each(function(){
        if (!writableCircles[this.value])
          $(this).attr("disabled","disabled");
    });
    },
    beforeclose:function(){
      $(this).parent("form").submit();
    },
  });
  $('.multi-select-box').multiselect_box({close:function(){
  }});
});