jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $(".modal").modal
    show: false
  $("a[rel=tooltip]").tooltip()