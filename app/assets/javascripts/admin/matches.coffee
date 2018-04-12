jQuery ->
  $('#sortable-votes').sortable
    asix: 'y'
    containment: 'parent'
    cursor: 'move'
    refreshPositions: true
    tolerance: 'pointer'
jQuery ->
  $('#save-match-order').click ->
    $.post($('#sortable-votes').data('update-url'), $('#sortable-votes').sortable('serialize'))
    window.location.href = $(this).data('redirect-url')
