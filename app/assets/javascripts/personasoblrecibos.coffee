jQuery ->

# 1️⃣ Cuando cambia la persona → carga obligaciones (TU CÓDIGO, intacto)
  $(document).on 'change', '#personasoblrecibo_persona_id', ->
    persona_id = $(this).val()

    $.ajax
      url: '/personasoblrecibos/get_personasoblrecibo_personasobligacion_id'
      type: 'GET'
      dataType: 'script'
      data:
        persona_id: persona_id


  # 2️⃣ Validación antes de enviar el formulario
  $(document).on 'submit', '.js-personasoblrecibo-form', (e) ->
    persona    = $('#personasoblrecibo_persona_id').val()
    obligacion = $('#personasoblrecibo_personasobligacion_id').val()
    valor      = $('#personasoblrecibo_valor').val()

    if !persona? or persona == ''
      e.preventDefault()
      return false

    if !obligacion? or obligacion == ''
      e.preventDefault()
      return false

    if !valor? or parseFloat(valor) <= 0
      e.preventDefault()
      return false

    true
