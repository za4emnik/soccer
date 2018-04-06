jQuery ->
  $('#sortable-votes').sortable
    asix: 'y'
    containment: 'parent'
    cursor: 'move'
    tolerance: 'pointer'
jQuery ->
  $('#save-vote').click ->
    $.post($('#sortable-votes').data('update-url'), $('#sortable-votes').sortable('serialize'))
    window.location.href = $(this).data('redirect-url')
