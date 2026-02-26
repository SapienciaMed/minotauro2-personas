jQuery ->
	$(document).on 'click', '.edit_permiso_button, #new_permiso_button', (e) ->
		e.preventDefault()
		id = $('.active_permiso').data('target')
		$.get $(this).attr('href'), active_id: id
