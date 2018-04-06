# jQuery ->
  # $('#sortable').sortable();

# $ ->
  # $('#sortable').sortable revert: true
  # $('#draggable').draggable
    # connectToSortable: '#sortable'
    # helper: 'clone'
    # revert: 'invalid'
  # $('ul, li').disableSelection()
  # return

# jQuery ->
  # $('#sortable-teams').sortable
    # asix: 'y'
    # containment: 'parent'
    # cursor: 'move'
    # tolerance: 'pointer'

$ ->
  $('#draggable').draggable()
  $('#droppable').droppable drop: (event, ui) ->
    $(this).addClass('ui-state-highlight').find('p').html 'Dropped!'
    return
  return
