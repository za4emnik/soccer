jQuery ->
  $('#sortable').sortable
    asix: 'y'
    containment: 'parent'
    cursor: 'move'
    tolerance: 'pointer'
    update: (event,ui)->
      $.post($(this).data('update-url'), $(this).sortable('serialize'))
