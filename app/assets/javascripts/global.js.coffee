$ ->
  $('.admin.app-form form select').change ->
    $(this).parent('form').submit()
