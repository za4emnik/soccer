$ ->
  $('.teams').sortable(connectWith: '.connectedSortable').disableSelection()
  return

getPlayerId = (elem, str) ->
  $(elem).find(str).attr('id').match(/\d+/g)[0]

$ ->
  $('#save-teams-order').click ->
    condition = true
    $('.teams').each (item) ->
     if $(this).find('.team-name').length != 2
       alert('Teams should be contain only 2 members')
       condition = false
    if condition
      data = { teams: {} }
      $('.teams').each (item, v) ->
        data.teams[$(this).attr('id').match(/\d+/g)[0]] = [getPlayerId(v, '.team-name:eq(0)'), getPlayerId(v, '.team-name:eq(1)')]
      $.post($('#sortable-teams').data('update-url'), data)
    # window.location.href = $(this).data('redirect-url')
