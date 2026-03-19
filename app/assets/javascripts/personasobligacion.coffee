jQuery ->
  $(document).on 'change', '#personasobligacion_cliente', ->
    personasobligacion_cliente = @value
    $.get('/personasobligaciones/get_personasobligacion_cliente', { personasobligacion_cliente: personasobligacion_cliente}, ->
      console.log 'success'
    ).fail ->
      console.log 'error'

  $(document).on 'click', '.edit_personasobligacion_button, #new_personasobligacion_button', (e) ->
    e.preventDefault()
    id = $('.active_personasobligacion').data('target')
    $.get $(this).attr('href'), active_id: id
