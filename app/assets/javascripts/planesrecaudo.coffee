jQuery ->
	$(document).on 'click', '.edit_planesrecaudo_button, #new_planesrecaudo_button', (e) ->
		e.preventDefault()
		id = $('.active_planesrecaudo').data('target')
		$.get $(this).attr('href'), active_id: id
