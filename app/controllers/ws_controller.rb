class WsController < ApplicationController
  before_action :authenticate_user!, except: [:confirmacion, :wsCreateData, :wsApiget, :tokenBioCredit, :epayco_webhook, :paymentez_webhook, :toke_notificacion_pago, :conversion_status_paymentez]
  protect_from_forgery with: :null_session
  extend WsHelper
  layout :determine_layout

  require 'uri'
  require 'net/https'
  require "net/http"
  require 'net/sftp'
  require 'net/ssh'
  require 'highline/import'
  require "json"
  respond_to :html, :json

  ########################################
  ########################################
  #   SAPIENCIA
  ########################################
  ########################################

  # Descripcion: Generacion del token principal para el metodo de Pago Paymentez - Controller: Ws:600
  # Fecha Creacion: 22-Marzo-2022
  # Autor: AFP
  # Credenciales para produccion
  # DV-INHACICEREZOS2-CO-CO-CLIENT
  # 3Scsnlm2UGHFP24KXw8OnShpZxRf8W
  # DV-INHACICEREZOS2-CO-CO-SERVER
  # VNEk4ldealssQR7B9MXCayD0S3axk6
  # Credenciales para prueba
  # 'DV-HACIECEREZOS-STG-CO-SERVER'
  # 'ntwQnOfXnTJjS7pg1Ge696YC2axjxe'
  #
  #
  #
  #     DV-SAPIENCIA-CO-CLIENT
  # ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd
  # DV-SAPIENCIA-CO-SERVER
  # aptx6ms1tWlPu6Pe2ElrE0NyO1By8d
  #
  #
  # WsController.token_paymentez
  def self.token_paymentez
    app_code = 'DV-SAPIENCIA-CO-SERVER'
    app_key = 'aptx6ms1tWlPu6Pe2ElrE0NyO1By8d'
    timestamp = DateTime.now + 200.seconds
    timestamp = DateTime.now.strftime('%Q')
    key_time = app_key + timestamp
    uniq_token = Digest::SHA256.hexdigest(key_time)
    str_union = Objeto.find_by_sql("select fch_minotauro_tokenpaymentez('#{app_code}','#{timestamp}','#{uniq_token}') token_uniq from dual")[0].token_uniq
    #str_union = "#{app_code.to_s};#{timestamp.to_s};#{uniq_token.to_s}"
    token = Base64.encode64("#{str_union}").delete("\n")
    puts "TOKEN --- #{token}"
    return token
  end

  # Descripcion: Metodo de pago Paymentez
  # Fecha Creacion: 22-Marzo-2022
  # Autor: AFP
  def pago_paymentez
    @personasoblrecibo = Personasoblrecibo.find(params[:personasoblrecibo_id]) # Se recibe el dato del recibo de teseo
    @valor = params[:valor]
    @personasobligacion = Personasobligacion.find(params[:id])
    @persona = @personasobligacion.persona
    token = WsController.token_paymentez
    #url = URI("https://noccapi-stg.paymentez.com/linktopay/init_order/")
    url = URI("https://noccapi.paymentez.com/linktopay/init_order/") # Produccion
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url)
    request["Content-Type"] = "application/json"
    request["Auth-Token"] = token.to_s
    puts "INCIA BODY ----------------------------------"
    request.body = JSON.dump({ "user": { "id": "#{@personasobligacion.persona_id}",
                                         "email": "#{current_user.email.to_s}",
                                         "name": "#{@persona.pernombres}",
                                         "last_name": "#{@persona.perapellidos}" },
                               "order": { "dev_reference": "#{@personasoblrecibo.id}",
                                          "description": "#{@personasobligacion.nro_obligacion.to_s}",
                                          "amount": @valor, "installments_type": 0, "currency": "COP", "vat": 0 },
                               "configuration": { "partial_payment": true,
                                                  "expiration_days": 1,
                                                  "allowed_payment_methods": ["All"],
                                                  "success_url": "https://pagoenlinea.sapiencia.gov.co/personasobligaciones/paymentez_success?obl=#{@personasobligacion.id}&vlr=#{@valor}&ref=#{@personasoblrecibo.id}",
                                                  "failure_url": "https://pagoenlinea.sapiencia.gov.co/personasobligaciones/paymentez_failure?obl=#{@personasobligacion.id}&vlr=#{@valor}&ref=#{@personasoblrecibo.id}",
                                                  "pending_url": "https://pagoenlinea.sapiencia.gov.co/personasobligaciones/paymentez_pending?obl=#{@personasobligacion.id}&vlr=#{@valor}&ref=#{@personasoblrecibo.id}",
                                                  "review_url": "https://pagoenlinea.sapiencia.gov.co/personasobligaciones/paymentez_review?obl=#{@personasobligacion.id}&vlr=#{@valor}&ref=#{@personasoblrecibo.id}" } })
    puts "TERMINA BODY --- #{request.body}"
    response = https.request(request)
    puts "RESPONSE --- #{response.to_s}"
    data = JSON.parse(response.read_body)
    redirect_to "#{data["data"]["payment"]["payment_url"]}"
  end

  # Descripcion: Metodo para solicitar el token si es credito o debido con paymentez y genera el token para la transaccion comparando con el webhook que llega por parte de paymentez
  # Fecha Creacion: 22-Marzo-2022
  # Autor: AFP
  def self.token_wehook_paymentez(data)
    transaction_id = data["transaction"]["id"]
    app_code = data["transaction"]["application_code"]
    user_id = data["user"]["id"]
    # Variable = Params ? Cuando es tarjeta de credito(Client) : Cuando es tarjeta de debito (Server)
    app_key = data["transaction"]["payment_method_type"] == '0' ? 'ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd' : 'aptx6ms1tWlPu6Pe2ElrE0NyO1By8d'
    for_md5 = "#{transaction_id}_#{app_code}_#{user_id}_#{app_key}"
    stoken = Digest::MD5.hexdigest(for_md5)
  end

  # Metodo WebHook, Envio de peticion por parte de Paymentez
  # Fecha Creacion: 22-Marzo-2022
  # Autor: AFP
  def paymentez_webhook
    token_webhook = WsController.token_wehook_paymentez(params)
    transaction_id = params["transaction"]["id"]
    app_code = params["transaction"]["application_code"]
    user_id = params["user"]["id"]
    # Variable = Params ? Cuando es tarjeta de credito(Client) : Cuando es tarjeta de debito (Server)
    if params["transaction"]["payment_method_type"] == '0'
      app_key = 'ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd' # Client
    elsif params["transaction"]["payment_method_type"] == '3'
      app_key = 'ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd' # Client
    elsif params["transaction"]["payment_method_type"] == '6'
      app_key = 'aptx6ms1tWlPu6Pe2ElrE0NyO1By8d' # Server
    elsif params["transaction"]["payment_method_type"] == '7'
      app_key = 'ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd' # Client
    elsif params["transaction"]["payment_method_type"] == '8'
      app_key = 'ZP4wmKUYPGSnL9TLFBXz2kfVlh37pd' # Client
    end
    #    app_key = params["transaction"]["payment_method_type"] == '0' ? '3Scsnlm2UGHFP24KXw8OnShpZxRf8W' : ''
    for_md5 = "#{transaction_id}_#{app_code}_#{user_id}_#{app_key}"
    token_webhook = Digest::MD5.hexdigest(for_md5)
    # Carga la respuesta de paymentez WebHook en la tabla de teseo Paymentez
    if params["transaction"]["payment_method_type"] == '0'
      nmPaymentezId = Paymentez.create!(transaction_status: params["transaction"]["status"],
                                        transaction_order_description: params["transaction"]["order_description"],
                                        transaction_authorization_code: params["transaction"]["authorization_code"],
                                        transaction_status_detail: params["transaction"]["status_detail"],
                                        transaction_date: params["transaction"]["date"],
                                        transaction_message: params["transaction"]["message"],
                                        transaction_id: params["transaction"]["id"],
                                        transaction_dev_reference: params["transaction"]["dev_reference"],
                                        transaction_carrier_code: params["transaction"]["carrier_code"],
                                        transaction_amount: params["transaction"]["amount"],
                                        transaction_paid_date: params["transaction"]["paid_date"],
                                        transaction_installments: params["transaction"]["installments"],
                                        transaction_ltp_id: params["transaction"]["ltp_id"],
                                        transaction_stoken: params["transaction"]["stoken"],
                                        transaction_application_code: params["transaction"]["application_code"],
                                        payment_method_type: params["transaction"]["payment_method_type"],
                                        user_id: params["user"]["id"],
                                        user_email: params["user"]["email"],
                                        card_bin: params["card"]["bin"],
                                        card_holder_name: params["card"]["holder_name"],
                                        card_type: params["card"]["type"],
                                        card_number: params["card"]["number"],
                                        card_origin: params["card"]["origin"],
                                        paymentez_json: params.to_s).id
    else
      nmPaymentezId = Paymentez.create!(transaction_status: params["transaction"]["status"],
                                        transaction_order_description: params["transaction"]["order_description"],
                                        transaction_authorization_code: params["transaction"]["authorization_code"],
                                        transaction_status_detail: params["transaction"]["status_detail"],
                                        transaction_date: params["transaction"]["date"],
                                        transaction_id: params["transaction"]["id"],
                                        transaction_dev_reference: params["transaction"]["dev_reference"],
                                        transaction_amount: params["transaction"]["amount"],
                                        transaction_paid_date: params["transaction"]["paid_date"],
                                        transaction_ltp_id: params["transaction"]["ltp_id"],
                                        transaction_stoken: params["transaction"]["stoken"],
                                        transaction_application_code: params["transaction"]["application_code"],
                                        payment_method_type: params["transaction"]["payment_method_type"],
                                        bank_code: params["transaction"]["bank_code"],
                                        pse_cycle: params["transaction"]["pse_cycle"],
                                        user_id: params["user"]["id"],
                                        user_email: params["user"]["email"],
                                        paymentez_json: params.to_s).id
    end
    # Paymentez debe de comprar el token que envian, con el que se genera desde Rails
    if params["transaction"]["stoken"] == token_webhook
      case params["transaction"]["status"].to_s
      when '0'
        message_status = "Estado de la solicitud #{conversion_status_paymentez(params["transaction"]["status"].to_s)}" # Estado Pendiente
      when '1'
        message_status = "Estado de la solicitud #{conversion_status_paymentez(params["transaction"]["status"].to_s)}" # Estado Aprobado
        if Personasoblrecibo.where("id = #{params["transaction"]["dev_reference"]} and estado = 'PENDIENTE'").exists?
          personasoblrecibo = Personasoblrecibo.where("id = #{params["transaction"]["dev_reference"]} and estado = 'PENDIENTE'").first
          p = Planesrecaudo.new
          p.fecha_recaudo = Time.now
          p.valor = personasoblrecibo.valor.to_i
          p.tipo_afecta = "AJUSTE CUOTA"
          p.tipo_pago = 'EFECTIVO'
          p.observaciones = "PAGO PAYMENTEZ, NRO RECIBO - #{personasoblrecibo.id} - PMZ - #{nmPaymentezId}"
          p.personasobligacion_id = personasoblrecibo.personasobligacion_id
          p.save
          if p.id.present?
            ProcesoJob.perform_now("prc_planesrecaudos(#{p.id.to_i})")
          end
          personasoblrecibo.update(estado: 'PAGADO', forma_pago: 'PAYMENTEZ')
        end
      when '2'
        message_status = "Estado de la solicitud #{conversion_status_paymentez(params["transaction"]["status"].to_s)}" # Estado Cancelado
      when '4'
        message_status = "Estado de la solicitud #{conversion_status_paymentez(params["transaction"]["status"].to_s)}" # Estado Rechazado
      when '5'
        message_status = "Estado de la solicitud #{conversion_status_paymentez(params["transaction"]["status"].to_s)}" # Estado Caducado
      end
      data_payment = { 'message' => message_status, 'payment_status' => params["transaction"]["status"].to_s }
      render json: { status: true, data: data_payment }
    else
      render json: { status: 203, msg: "Error con el token" }
    end
  end

  def pago_epayco
    @personasoblrecibo = Personasoblrecibo.find(params[:personasoblrecibo_id])
    @valor = params[:valor]
    @personasobligacion = Personasobligacion.find(params[:id])
    @persona = @personasobligacion.persona

    token = WsController.generar_token_epayco

    unless token
      render json: { success: false, message: "Token no generado" }, status: :unprocessable_entity
      return
    end

    session_data = WsController.crear_session_epayco(@personasoblrecibo.id)

    if session_data[:success]
      render json: { success: true, session_id: session_data[:session_id] }
    else
      render json: session_data, status: :unprocessable_entity
    end
  end

  # ***************************************************
  # 1. GENERACION DE TOKEN PARA EPAYCO PARA CREAR LA SESSION
  # ***************************************************
  LOGIN_URL = "https://apify.epayco.co/login".freeze
  # CLIENT_ID     = "11490b34583e7f856b1b745826bafc9e".freeze # PRUEBA
  # CLIENT_SECRET = "1c20dc3842a5a2c2ea89a3f6d32684cc".freeze # PRUEBA

  CLIENT_ID = "3ff07bff9a736bc87526a2a029703fb9".freeze # PRODUCCION
  CLIENT_SECRET = "5c5a5bb1501eca1ba3107ea4c36285f0".freeze # PRODUCCION

  def self.generar_token_epayco
    begin
      url = URI(LOGIN_URL)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      auth = Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")

      request = Net::HTTP::Post.new(url)
      request["Content-Type"] = "application/json"
      request["Authorization"] = "Basic #{auth}"
      request.body = "" # obligatorio

      response = http.request(request)
      data = JSON.parse(response.body)

      data["token"]
    rescue => e
      nil
    end
  end

  def self.crear_session_epayco(personasoblrecibo_id)
    begin
      personasoblrecibo = Personasoblrecibo.find(personasoblrecibo_id)
      token = generar_token_epayco
      return { success: false, error: "No fue posible generar token" } if token.nil?

      # ---- Capturar IP real (Rails) ----
      ip_cliente = (RequestStore.store[:remote_ip] rescue nil) || "192.168.4.39"

      url = URI("https://apify.epayco.co/payment/session/create")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{token}"
      request["Content-Type"] = "application/json"

      email = personasoblrecibo.persona.email rescue nil

      body = {
        checkout_version: "2",
        name: "Sapiencia",
        description: "Pago de obligación #{personasoblrecibo.personasobligacion.nro_obligacion}",
        currency: "COP",
        amount: personasoblrecibo.valor,
        country: "CO",
        lang: "ES",
        confirmation: "https://pagoenlinea.sapiencia.gov.co/ws/epayco_webhook",
        ip: ip_cliente,
        test: true,
        extras: {
          extra1: personasoblrecibo.id.to_s
        },
        billing: {
          email: email.to_s,
          #email:  'andres.computo@gmail.com',
          name: personasoblrecibo.persona.nombre_completo,
          typeDoc: "CC",
          numberDoc: personasoblrecibo.persona.identificacion.to_s
        }
      }

      puts body.to_s

      request.body = body.to_json

      response = http.request(request)
      json = JSON.parse(response.body) rescue {}

      # ---- Extraer sessionId cuando success = true ----
      if json["success"] == true
        return {
          success: true,
          session_id: json.dig("data", "sessionId")
        }
      else
        return {
          success: false,
          error: json["textResponse"] || "Error creando sesión"
        }
      end

    rescue => e
      { success: false, error: e.message }
    end
  end

  def epayco_webhook
    # ================================================
    # 1. VALIDAR FIRMA (OBLIGATORIO - ePayco 2025)
    # ================================================
    unless firma_valida_epayco?
      Rails.logger.warn "ePayco Webhook RECHAZADO - Firma inválida desde IP: #{request.ip}"
      head :unauthorized
      return
    end

    # ================================================
    # 2. EXTRAER DATOS CLAVE
    # ================================================
    recibo_id =
      if params[:x_extra1].present?
        params[:x_extra1]
      elsif params[:x_id_factura].present?
        params[:x_id_factura].split('-').first
      end

    # Ref Payco real cuando es LINK
    if params[:x_extra9_epayco].present?
      params[:x_extra9] = params[:x_extra9_epayco].to_s.split(':')[1]
    end

    # recibo_id = params[:x_extra1].presence || params[:x_id_factura]&.split('_')&.last
    ref_payco = params[:x_ref_payco].to_s
    transaction_id = params[:x_transaction_id].to_s
    monto = params[:x_amount].to_s
    estado_codigo = params[:x_cod_response].to_s
    motivo = params[:x_response_reason_text].to_s

    # ================================================
    # 3. BUSCAR EL RECIBO
    # ================================================
    recibo = Personasoblrecibo.find_by(id: recibo_id)

    if recibo.nil?
      Rails.logger.error "ePayco Webhook - Recibo NO encontrado: #{recibo_id} | Ref: #{ref_payco}"
      head :not_found
      return
    end

    # ================================================
    # 4. REGISTRAR TODO EL WEBHOOK EN LA TABLA EPAYCOS (siempre)
    # ================================================
    epaycoId = Epayco.create!(
      personasoblrecibo_id: recibo.id,
      x_cust_id_cliente: params[:x_cust_id_cliente],
      x_ref_payco: ref_payco,
      x_id_factura: params[:x_id_factura],
      x_id_invoice: params[:x_id_invoice],
      x_description: params[:x_description],
      x_amount: params[:x_amount],
      x_amount_country: params[:x_amount_country],
      x_amount_ok: params[:x_amount_ok],
      x_tax: params[:x_tax],
      x_amount_base: params[:x_amount_base],
      x_currency_code: params[:x_currency_code],
      x_bank_name: params[:x_bank_name],
      x_cardnumber: params[:x_cardnumber],
      x_quotas: params[:x_quotas],
      x_respuesta: params[:x_respuesta],
      x_response: params[:x_response],
      x_approval_code: params[:x_approval_code],
      x_transaction_id: transaction_id,
      x_fecha_transaccion: params[:x_fecha_transaccion],
      x_transaction_date: params[:x_transaction_date],
      x_cod_respuesta: params[:x_cod_respuesta],
      x_cod_response: params[:x_cod_response],
      x_response_reason_text: motivo,
      x_errorcode: params[:x_errorcode],
      x_cod_transaction_state: params[:x_cod_transaction_state],
      x_transaction_state: params[:x_transaction_state],
      x_franchise: params[:x_franchise],
      x_business: params[:x_business],
      x_customer_doctype: params[:x_customer_doctype],
      x_customer_document: params[:x_customer_document],
      x_customer_name: params[:x_customer_name],
      x_customer_lastname: params[:x_customer_lastname],
      x_customer_email: params[:x_customer_email],
      x_customer_phone: params[:x_customer_phone],
      x_customer_movil: params[:x_customer_movil],
      x_customer_ind_pais: params[:x_customer_ind_pais],
      x_customer_country: params[:x_customer_country],
      x_customer_city: params[:x_customer_city],
      x_customer_address: params[:x_customer_address],
      x_customer_ip: params[:x_customer_ip],
      x_test_request: params[:x_test_request],
      x_extra1: params[:x_extra1],
      x_extra2: params[:x_extra2],
      x_extra3: params[:x_extra3],
      x_extra4: params[:x_extra4],
      x_extra5: params[:x_extra5],
      x_extra6: params[:x_extra6],
      x_extra7: params[:x_extra7],
      x_extra8: params[:x_extra8],
      x_extra9: params[:x_extra9],
      x_extra10: params[:x_extra10],
      x_tax_ico: params[:x_tax_ico],
      x_payment_date: params[:x_payment_date],
      x_signature: params[:x_signature],
      x_transaction_cycle: params[:x_transaction_cycle],
      is_processable: params[:is_processable],
      raw_payload: request.request_parameters.merge(
        ip_origen: request.ip,
        user_agent: request.user_agent
      ).to_json,
      ip_origen: request.ip,
      processed_at: Time.current
    ).id

    # ================================================
    # 5. EVITAR PAGOS DUPLICADOS
    # ================================================
    if recibo.estado == 'PAGADO'
      Rails.logger.info "ePayco - Pago duplicado ignorado (ya está PAGADO): Recibo #{recibo.id}"
      render plain: "OK - Ya procesado", status: :ok
      return
    end

    # ================================================
    # 6. PROCESAR SOLO SI ESTÁ APROBADO
    # ================================================
    if estado_codigo == '1' && recibo.estado == 'PENDIENTE'

      p = Planesrecaudo.new
      p.fecha_recaudo = Time.now
      p.valor = recibo.valor.to_i
      p.tipo_afecta = "AJUSTE CUOTA"
      p.tipo_pago = 'EFECTIVO'
      p.user_id = recibo.user_id
      p.observaciones = "PAGO EPAYCO, NRO RECIBO - #{recibo.id} - ID EPAYCO - #{epaycoId}"
      p.personasobligacion_id = recibo.personasobligacion_id
      p.save
      if p.id.present?
        ProcesoJob.perform_now("prc_planesrecaudos(#{p.id.to_i})")
      end

      recibo.update!(
        estado: 'PAGADO',
        forma_pago: 'EPAYCO',
        transaction_id: transaction_id,
        ref_payco: ref_payco,
        valor_pagado: monto.to_f,
        observacion: "#{recibo.observacion} - PAGO EPAYCO APROBADO (Ref: #{ref_payco})"
      )

      Rails.logger.info "PAGO EPAYCO APROBADO - Recibo: #{recibo.id} | Valor: #{monto} | Ref: #{ref_payco}"

    end

    # ================================================
    # 7. RECHAZADO / FALLIDO
    # ================================================
    if ['2', '3', '4'].include?(estado_codigo)
      recibo.update!(
        estado: 'RECHAZADO',
        forma_pago: 'EPAYCO',
        observacion: "ePayco: #{motivo} (Cód: #{estado_codigo})"
      )
    end

    # ================================================
    # 8. SIEMPRE RESPONDER 200 OK
    # ================================================
    render plain: "OK", status: :ok
  end

  # Descripción: Metodo que convierte a descripcion los estados de paymentez
  # Fecha Creacion: 22-Marzo-2022
  # Autor: AFP
  def conversion_status_paymentez(status)
    case status
    when '0'
      'Pending'
    when '1'
      'Approved'
    when '2'
      'Cancelled'
    when '4'
      'Rejected'
    when '5'
      'Expired'
    end
  end

  def self.prueba_generacion
    @personasoblrecibo = Personasoblrecibo.create!(persona_id: 68915,
                                                   fecha_recaudo: Date.today,
                                                   valor: 10000,
                                                   user_id: 126226,
                                                   forma_pago: 'COBRA',
                                                   estado: 'PENDIENTE',
                                                   observacion: "LINK PAGO COBRA",
                                                   email: 'andres.computo@gmail.com',
                                                   personasobligacion_id: 52821)
    WsController.generar_link_pago_epayco(@personasoblrecibo.id)
  end

  # PROCESO DE COBRA PARA LA GENERACION DE LINK DE PAGO
  def self.generar_link_pago_epayco(personasoblrecibo_id)
    begin
      recibo = Personasoblrecibo.find(personasoblrecibo_id)

      token = generar_token_epayco
      return { success: false, error: "No fue posible generar token" } if token.nil?

      url = URI("https://apify.epayco.co/collection/link/create")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Post.new(url)
      request["Authorization"] = "Bearer #{token}"
      request["Content-Type"] = "application/json"

      # ------------------------------
      # Construcción del body
      # ------------------------------
      typeSell = 1 # email
      if recibo.tipo_envio == 'SMS'
        typeSell = 3
      elsif recibo.tipo_envio == 'LINK DE COBRO'
        typeSell = 2
      end

      body = {
        clientId: CLIENT_ID.to_i,
        quantity: 1,
        onePayment: true,
        amount: recibo.valor.to_f,
        currency: "COP",
        id: 0,
        base: 0,
        tax: 0,
        description: recibo.descripcion.to_s,
        title: "Link de pago Sapiencia",
        typeSell: typeSell,
        reference: recibo.id
      }

      if typeSell == 1
        body[:email] = "#{recibo.email}"
      elsif typeSell == 3
        body[:mobilePhone] = "#{recibo.celular}"
        body[:indicative]  = "57"
      end


      request.body = body.to_json


      response = http.request(request)
      json = JSON.parse(response.body) rescue {}

      # Guardar respuesta completa
      recibo.update!(response_epayco: json.to_json)

      if json["success"] == true
        recibo.update!(
          ref_payco: json.dig("data", "id"),
          link_pago: json.dig("data", "routeLink")
        )

        {
          success: true,
          link: json.dig("data", "routeLink"),
          ref: json.dig("data", "id")
        }
      else
        recibo.update!(estado: "ERROR")
        {
          success: false,
          error: json["textResponse"] || "Error creando link de pago"
        }
      end

    rescue => e
      {
        success: false,
        error: e.message
      }
    end
  end

  private

  def firma_valida_epayco?
    return false if params[:x_signature].blank?

    # p_cust_id_cliente =  "1567934" # PRUEBAS
    p_cust_id_cliente = "1565015" # PRODUCCION
    # p_key             =  "a55ffa5c7b144f0e4cc74802402dc69f223d38ea" # PRUEBAS
    p_key = "9b22c7a8134ff177c75aec9ae92901c7d53563a3" # PRODUCCION

    cadena = [
      p_cust_id_cliente,
      p_key,
      params[:x_ref_payco].to_s,
      params[:x_transaction_id].to_s,
      params[:x_amount].to_s,
      params[:x_currency_code].to_s
    ].join('^')

    firma_calculada = Digest::SHA256.hexdigest(cadena).downcase
    firma_recibida = params[:x_signature].to_s.downcase

    # Logs útiles (quítalos en producción si no quieres tanto ruido)
    Rails.logger.info "ePayco Firma → Cadena: #{cadena}"
    Rails.logger.info "ePayco Firma → Calculada: #{firma_calculada} | Recibida: #{firma_recibida}"

    firma_calculada == firma_recibida
  end

  def determine_layout
    ['respuesta', 'confirmacion'].include?(action_name) ? 'login' : 'application_admin'
  end
end