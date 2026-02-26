jQuery ->
  $(document).on 'change', '#archivo_proceso', ->
    $.get '/archivos/get_tipoproceso', { archivo_proceso: @value }
