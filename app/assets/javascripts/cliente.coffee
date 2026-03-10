jQuery ->
	$(document).on 'click', '.edit_cliente_button, #new_cliente_button', (e) ->
		e.preventDefault()
		id = $('.active_cliente').data('target')
		$.get $(this).attr('href'), active_id: id
