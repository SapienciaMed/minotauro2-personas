class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  require 'digest'

  helper :all

  protect_from_forgery with: :exception

  before_action :authenticate_user!, except: [:validatesession]
  #before_action :validatesession
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :allow_iframe_requests

  def default_url_options
    super.merge(only_path: true)  # fuerza paths relativos en url_for/redirect_to
  end
  
  def validatesession
    if current_user == nil
      cookies.delete(:_session_id)
      cookies.delete(:user_id)
      cookies.delete(:username)
    end
  end

  def allow_iframe_requests
    response.headers.delete('X-Frame-Options')
  end

  def agendasmenus
  end

  helper_method :is_admin

  def is_admin
    if user_signed_in?
      return current_user.id
    end
  end

  helper_method :is_cohorte

  def is_cohorte
    return User.find(is_admin).cohorte_id
  end

  helper_method :is_portafolioname

  def is_portafolioname
    return User.find(is_admin).portafolio.nombrecorto rescue nil
  end

  helper_method :is_usuario

  def is_usuario
    return User.find(is_admin).nombre
  end

  helper_method :is_nextmandamiento

  def is_nextmandamiento
    begin
      lastconsecutivo = Personascoactivo.maximum('nro_radicado')
    rescue
      lastconsecutivo = 0
    end
    if lastconsecutivo.to_i == 0
      nextconsecutivo = 10001
    else
      nextconsecutivo = 10001 + 1
    end
    return nextconsecutivo
  end

  helper_method :quita_acento1

  def quita_acento1(dato)
    valor = dato.gsub('Á', 'A')
    valor = valor.gsub('É', 'E')
    valor = valor.gsub('Í', 'I')
    valor = valor.gsub('Ó', 'O')
    valor = valor.gsub('Ú', 'U')
    valor = valor.gsub('Ñ', 'N')
    return valor.to_s
  end

  helper_method :permiso

  def permiso(objeto, evento)
    #Evento debe ser A:Actualiza, E:Elimina, C:Crea
    objetoid = Objeto.find_by_descripcion(objeto)
    if objetoid.to_s != ""
      userspermisos = Userspermiso.where('user_id = ? and objeto_id = ?', is_admin, objetoid)
      userspermisos.each do |data|
        if evento == "A"
          return data.actualiza
        elsif evento == "E"
          return data.elimina
        elsif evento == "C"
          return data.crea
        end
      end
    end
  end

  # helper_method :permisoespecial
  # def permisoespecial(id) #Evento debe ser N:No, S:Si
  #     if Resolucionespersona.exists?(["persona_id = ?", id]) == false
  #       return 'S' #No esta
  #     else
  #       if permiso("subsidioespecial","A").to_s == "S"
  #         return 'S' #Permiso especial de modificaciones
  #       else
  #         return 'N' #NO esta y no tiene permiso especial
  #       end
  #     end
  # end

  # helper_method :permisomejoramiento
  # def permisomejoramiento(id) #Evento debe ser N:No, S:Si - id = mejoramientoId
  #   @mejoramiento = Mejoramiento.find(id)
  #   logger.error("error desde mejoramiento....." + @mejoramiento.mejoramientosestado_id.to_s)
  #   if @mejoramiento.mejoramientosestado_id.to_i >= 6
  #     if permiso("mejoramientosespecial","A").to_s == "S"
  #       return 'S' #Permiso especial de modificaciones
  #     else
  #       return 'N' #NO esta y no tiene permiso especial
  #     end
  #   else
  #     if @mejoramiento.user_coordinador.to_i == is_admin or @mejoramiento.user_profesional.to_i == is_admin or @mejoramiento.user_tecnologo.to_i == is_admin
  #       return 'S'
  #     else
  #       if permiso("mejoramientosespecial","A").to_s == "S"
  #         return 'S' #Permiso especial de modificaciones
  #       else
  #         return 'N' #NO esta y no tiene permiso especial
  #       end
  #     end
  #   end
  # end

  # helper_method :permisobloqueomejoramiento
  # def permisobloqueomejoramiento(mejorid) #Evento debe ser N:No, S:Si - id = mejoramientoId
  #   @mejoramiento = Mejoramiento.find(mejorid.to_i)
  #   if @mejoramiento.mejoramientosestado_id.to_i >= 6
  #     if permiso("mejoramientosespecial","A").to_s == "S"
  #       return 'S' #Permiso especial de modificaciones
  #     else
  #       return 'N' #NO esta y no tiene permiso especial
  #     end
  #   else
  #     return 'S'
  #   end
  # end

  helper_method :descmes

  def descmes(mes)
    if mes.to_s == '1'
      return 'ENERO'
    elsif mes.to_s == '2'
      return 'FEBRERO'
    elsif mes.to_s == '3'
      return 'MARZO'
    elsif mes.to_s == '4'
      return 'ABRIL'
    elsif mes.to_s == '5'
      return 'MAYO'
    elsif mes.to_s == '6'
      return 'JUNIO'
    elsif mes.to_s == '7'
      return 'JULIO'
    elsif mes.to_s == '8'
      return 'AGOSTO'
    elsif mes.to_s == '9'
      return 'SEPTIEMBRE'
    elsif mes.to_s == '10'
      return 'OCTUBRE'
    elsif mes.to_s == '11'
      return 'NOVIEMBRE'
    elsif mes.to_s == '12'
      return 'DICIEMBRE'
    else
      return '------'
    end
  end

  helper_method :descmesmin

  def descmesmin(mes)
    if mes.to_i == 1
      return 'Enero'
    elsif mes.to_i == 2
      return 'Febrero'
    elsif mes.to_i == 3
      return 'Marzo'
    elsif mes.to_i == 4
      return 'Abril'
    elsif mes.to_i == 5
      return 'Mayo'
    elsif mes.to_i == 6
      return 'Junio'
    elsif mes.to_i == 7
      return 'Julio'
    elsif mes.to_i == 8
      return 'Agosto'
    elsif mes.to_i == 9
      return 'Septiembre'
    elsif mes.to_i == 10
      return 'Octubre'
    elsif mes.to_i == 11
      return 'Noviembre'
    elsif mes.to_i == 12
      return 'Diciembre'
    else
      return '------'
    end
  end

  helper_method :fechaprog

  def fechaprog(fechainicial, dias)
    if fechainicial.to_s != "" and dias.to_s != ""
      fechawork = fechainicial.to_time
      minutosmas = dias.to_i * 86400
      fechaprog = (fechawork + minutosmas.to_i)
      cantidad = Festivo.where('fecha between ? and ?', fechawork, fechaprog).count
      if cantidad > 0
        minutosadd = cantidad.to_i * 86400
        fechaprogramacion = fechawork + minutosmas.to_i + minutosadd.to_i
        fecha = fechaprogramacion.strftime("%d-%m-%Y")
        cantidad1 = Festivo.where('fecha = ?', fecha).count
        while cantidad1.to_i > 0
          fechaprogramacion = fechaprogramacion + 86400
          fecha = fechaprogramacion.strftime("%d-%m-%Y")
          cantidad1 = Festivo.where('fecha = ?', fecha).count
        end
      else
        fechaprogramacion = fechaprog
        fecha = fechaprog.strftime("%d-%m-%Y")
        cantidad1 = Festivo.where('fecha = ?', fecha).count
        while cantidad1.to_i > 0
          fechaprogramacion = fechaprogramacion + 86400
          fecha = fechaprogramacion.strftime("%d-%m-%Y")
          cantidad1 = Festivo.where('fecha = ?', fecha).count
        end
      end
    end
    return fecha
  end

  helper_method :fechaprogx

  def fechaprogx(fechainicial, dias)
    if fechainicial.to_s != "" and dias.to_s != ""
      @objetos = Objeto.find_by_sql(["select fnc_fecha('#{fechainicial.to_date}',#{dias.to_i}) fch from dual"])
      @objetos.each do |objeto|
        return objeto.fch
      end
    end
  end

  helper_method :diferenciadias

  def diferenciadias(fechasolicitud)
    if fechasolicitud.to_s != ""
      fechawork = fechasolicitud.to_time
      festivos = Festivo.find_by_sql("select trunc(sysdate) - to_date('#{fechasolicitud}','dd/mm/yyyy') resta from dual")
      dias = 0
      festivos.each do |festivo|
        dias = festivo.resta
      end
      cantidad = Festivo.where('fecha between ? and trunc(sysdate)', fechawork).count
      if cantidad > 0
        dias = dias - cantidad
      end
    end
    if dias > 0
      return dias
    else
      return (dias * -1)
    end
  end

  helper_method :is_fechamas

  def is_fechamas(fch1)
    return Objeto.find_by_sql("select fnc_fechamasmes('#{fch1.to_date}',1) fch from dual")[0].fch
  end

  helper_method :namedate

  def namedate(fecha)
    day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sábado"]
    month_names = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    dia = fecha.strftime("%w").to_i
    ndia = day_names[dia]
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = ndia + ' ' + fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
    return fchcompleta
  end

  helper_method :namedate2

  def namedate2(fecha)
    day_names = ["domingo", "lunes", "martes", "miércoles", "jueves", "viernes", "sábado"]
    month_names = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
    dia = fecha.strftime("%w").to_i
    ndia = day_names[dia]
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = ndia + ' ' + fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
    return fchcompleta
  end

  helper_method :namedate3

  def namedate3(fecha)
    month_names = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
    dia = fecha.strftime("%w").to_i
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = nmes + ' ' + fecha.strftime("%d") + ' de ' + fecha.strftime("%Y")
    return fchcompleta
  end

  helper_method :namedate4

  def namedate4(fecha)
    month_names = ["", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
    dia = fecha.strftime("%w").to_i
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = nmes + ' de ' + fecha.strftime("%Y")
    return fchcompleta
  end

  helper_method :namedate5

  def namedate5(fecha)
    day_names = ["Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sábado"]
    month_names = ["", "Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"]
    dia = fecha.strftime("%w").to_i
    ndia = day_names[dia]
    mes = fecha.strftime("%m").to_i
    nmes = month_names[mes]
    fchcompleta = fecha.strftime("%d") + ' de ' + nmes + ' del ' + fecha.strftime("%Y")
    return fchcompleta
  end

  def helpers
    ActionController::Base.helpers
  end

  helper_method :camponumericoinforme

  def camponumericoinforme(campo)
    campo1 = campo.to_f
    if campo1 == 0
      campo1 = campo
    else
      campo1 = helpers.number_to_currency(campo, precision: 0, unit: "", delimiter: ".")
      #campo1 = number_to_currency( campo.to_i, :precision => 0, :unit=>"", :delimiter =>".")
    end
    return campo1
  end

  helper_method :replaceenter

  def replaceenter(campo)
    b = campo.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    b = b.sub("\n", "<br/>")
    return b
  end

  #
  #   rescue_from CanCan::AccessDenied do |exception|
  #    flash[:warning] = "Usted no tiene acceso a este Modulo"
  #    redirect_to menus_url
  #  end

  helper_method :is_host

  def is_host
    return Parametro.find(16).valor.to_s
=begin
    ip = request.env['REMOTE_ADDR'].to_s
    #logger.error("1sifiiiii conexion - #{ip2}")
    if ip == '127.0.0.1'
      @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE LOCAL'
                                    ORDER BY dbms_random.value) WHERE rownum = 1")
      @objeto.each do |objeto|
        return objeto.valor
      end
    else
      if ip[0,10] == '192.168.1.'
        @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE LOCAL'
                                      ORDER BY dbms_random.value) WHERE rownum = 1")
        @objeto.each do |objeto|
          return objeto.valor
        end
      else
        @objeto = Objeto.find_by_sql("SELECT valor FROM (SELECT valor FROM sifis where descripcion = 'HOST BALANCE'
                                      ORDER BY dbms_random.value) WHERE rownum = 1")
        @objeto.each do |objeto|
          return objeto.valor
        end
      end
    end
=end
  end

  helper_method :numero_a_palabras

  def numero_a_palabras(numero)
    de_tres_en_tres = numero.to_i.to_s.reverse.scan(/\d{1,3}/).map { |n| n.reverse.to_i }

    millones = [
      { true => nil, false => nil },
      { true => 'MILLÓN', false => 'MILLONES' },
      { true => "BILLÓN", false => "BILLONES" },
      { true => "TRILLÓN", false => "TRILLONES" }
    ]

    centena_anterior = 0
    contador = -1
    palabras = de_tres_en_tres.map do |numeros|
      contador += 1
      if contador % 2 == 0
        centena_anterior = numeros
        [centena_a_palabras(numeros), millones[contador / 2][numeros == 1]].compact if numeros > 0
      elsif centena_anterior == 0
        [centena_a_palabras(numeros), "MIL", millones[contador / 2][false]].compact if numeros > 0
      else
        [centena_a_palabras(numeros), "MIL"] if numeros > 0
      end
    end

    palabras.compact.reverse.join(' ')
  end

  helper_method :centena_a_palabras

  def centena_a_palabras(numero)
    especiales = {
      11 => 'ONCE', 12 => 'DOCE', 13 => 'TRECE', 14 => 'CATORCE', 15 => 'QUINCE',
      10 => 'DIEZ', 20 => 'VEINTE', 100 => 'CIEN'
    }
    if especiales.has_key?(numero)
      return especiales[numero]
    end

    centenas = [nil, 'CIENTO', 'DOSCIENTOS', 'TRESCIENTOS', 'CUATROCIENTOS', 'QUINIENTOS', 'SEISCIENTOS', 'SETECIENTOS', 'OCHOCIENTOS', 'NOVECIENTOS']
    decenas = [nil, 'DIECI', 'VEINTI', 'TREINTA', 'CUARENTA', 'CINCUENTA', 'SESENTA', 'SETENTA', 'OCHENTA', 'NOVENTA']
    unidades = [nil, 'UN', 'DOS', 'TRES', 'CUATRO', 'CINCO', 'SEIS', 'SIETE', 'OCHO', 'NUEVE']

    centena, decena, unidad = numero.to_s.rjust(3, '0').scan(/\d/).map { |i| i.to_i }

    palabras = []
    palabras << centenas[centena]

    if especiales.has_key?(decena * 10 + unidad)
      palabras << especiales[decena * 10 + unidad]
    else
      tmp = "#{decenas[decena]}#{' Y ' if decena > 2 && unidad > 0}#{unidades[unidad]}"
      palabras << (tmp.blank? ? nil : tmp)
    end
    palabras.compact.join(' ')
  end

  helper_method :is_trigger_mej

  def is_trigger_mej(id, userid, blo, tipo)
    mej = Mejoramientosactualizacion.new
    mej.mejoramiento_id = id
    mej.bloque = blo
    mej.tipo_transaccion = tipo
    mej.user_id = userid
    mej.save
  end

  helper_method :is_trigger_tit

  def is_trigger_tit(id, userid, blo, tipo)
    mej = Titulacionesactualizacion.new
    mej.titulacion_id = id
    mej.bloque = blo
    mej.tipo_transaccion = tipo
    mej.user_id = userid
    mej.save
  end

  helper_method :is_quita_acento

  def is_quita_acento(dato)
    valor = dato.gsub('Á', 'A') rescue nil
    valor = valor.gsub('É', 'E') rescue nil
    valor = valor.gsub('Í', 'I') rescue nil
    valor = valor.gsub('Ó', 'O') rescue nil
    valor = valor.gsub('Ú', 'U') rescue nil
    valor = valor.gsub('Ñ', 'N') rescue nil
    return valor.to_s
  end

  helper_method :is_fechahoy
  def is_fechahoy
    return Plan.find_by_sql(["select trunc(sysdate) fecha from dual"])[0].fecha.to_date rescue nil
  end

  helper_method :is_select_tiposestado

  def is_select_tiposestado
    @tiposestados = Tiposestado.where("estado = ?", 'ACTIVO').order(:descripcion)
    return @tiposestados
  end

  helper_method :is_select_estado

  def is_select_estado
    @estados = Estado.where(["id in (select estado_id from estadosportafolios where portafolio_id = #{is_portafolio})"]).order(:descripcion)
    return @estados
  end

  helper_method :is_help_lastcopermisonse

  def is_help_lastconse
    #logger.error("Ingresoooo....")
    begin
      lastconsecutivo = Personasobligacion.where("fondo = 'ENLAZAMUNDOS'").maximum('nro_obligacion')
      #logger.error("Valor lastId...."+lastid.to_s)
      #lastconsecutivo = Personasobligacion.find(lastid).nro_obligacion
    rescue
      lastconsecutivo = 0
    end
    if lastconsecutivo.to_i == 0
      nextconsecutivo = 20150001
    else
      nextconsecutivo = lastconsecutivo + 1
    end
    return nextconsecutivo
  end

  helper_method :is_select_oficinaregistro

  def is_select_oficinaregistro
    @oficinas = Oficina.all.order("descripcion")
    return @oficinas
  end

  helper_method :is_select_municipio

  def is_select_municipio
    @municipios = Municipio.order('descripcion')
    return @municipios
  end

  helper_method :is_select_notaria

  def is_select_notaria
    @notarias = Notaria.all.order("descripcion")
    return @notarias
  end

  helper_method :is_convocatoria

  def is_convocatoria
    return 'N'
    #    @horacierre = "2014-07-26 17:00:00"
    #    @hora = Time.now.strftime("%Y-%m-%d %X")
    #    if @hora >= @horacierre
    #      return 'S'
    #    else
    #      return 'N'
    #    end
  end

  helper_method :is_select_user

  def is_select_user
    @users = User.all.order("nombre")
    return @users
  end

  helper_method :is_select_useractivo

  def is_select_useractivo
    @users = User.where(["activo = 'S' and portafolio_id = #{is_portafolio}"]).all.order("nombre")
    return @users
  end

  helper_method :is_select_useredupol

  def is_select_useredupol
    @users = User.where(["activo = 'S' and portafolio_id = #{is_portafolio}
                          and id in (select distinct user_id from personasobligaciones where portafolio_id = #{is_portafolio})"]).all.order("nombre")
    return @users
  end

  helper_method :is_select_parorigenespago

  def is_select_parorigenespago
    datos = Parorigenespago.where(["id in (select parorigenespago_id from parorigenportafolios where portafolio_id = #{is_portafolio})"]).order("descripcion")
    return datos
  end

  helper_method :is_select_tipodocumento

  def is_select_tipodocumento
    @datos = Tiposdocumento.all.order("id")
    return @datos
  end

  helper_method :is_select_parorigenespagos

  def is_select_parorigenespagos
    @datos = Parorigenespago.where("(portafolio_id = #{is_portafolio} or id in (8))").order("id")
    return @datos
  end

  helper_method :is_select_parorigenespagos_ajuste

  def is_select_parorigenespagos_ajuste
    @datos = Parorigenespago.where("nota is not null").order("id")
    return @datos
  end

  helper_method :is_select_cliente

  def is_select_cliente
    @datos = Cliente.where("portafolio_id = #{is_portafolio}").order("nombre")
    return @datos
  end

  helper_method :is_select_partiposcartera

  def is_select_partiposcartera
    @datos = Partiposcartera.where(estado: 'ACTIVO').order('cod_cifin')
    return @datos
  end

  helper_method :is_select_lineacredito

  def is_select_lineacredito
    @datos = Lineacredito.where("portafolio_id = #{is_portafolio}").order("descripcion")
    return @datos
  end

  helper_method :is_select_partiposproducto

  def is_select_partiposproducto
    @datos = Partiposproducto.where(estado: 'ACTIVO').order('cod_cifin')
    return @datos
  end

  helper_method :is_addmonths

  def is_addmonths(dtfecha)
    d1 = Parametro.find(1).valor.to_s
    d2 = Parametro.find(2).valor.to_s
    d3 = Parametro.find(3).valor.to_s
    plsql.connection = OCI8.new(d1, d2, d3)
    valor = plsql.fnc_fechamasmes(dtfecha, 1)
    plsql.logoff
  end

  helper_method :is_uvrdia

  def is_uvrdia
    #last_id = Recordacion.maximum('id')
    #dtfecha = Recordacion.find(last_id).fecha
    partasasuvr = Partasasuvr.where("fecha = trunc(sysdate)").first
    return partasasuvr.pesos_uvr.to_f
  end

  helper_method :is_uvrdia_dia

  def is_uvrdia_dia(dtfecha)
    partasasuvr = Partasasuvr.where("fecha = '#{dtfecha.strftime("%Y-%m-%d")}'").first
    return partasasuvr.pesos_uvr.to_f
  end

  helper_method :is_select_cuenta

  def is_select_cuenta
    @objetos = Cuenta.order('descripcion')
    return @objetos
  end

  helper_method :is_factura

  def is_factura
    nrofactura = 0
    @facturas = Efactura.find_by_sql("select max(nro_factura) nro from efacturas")
    @facturas.each do |factura|
      nrofactura = factura.nro
    end
    if nrofactura < 1000
      nrofactura = 1000
    end
    return nrofactura.to_i + 1
  end

  helper_method :facturacero

  def facturacero(campo)
    @facturas = Objeto.find_by_sql("select lpad(#{campo},10,'0') fact from dual")
    @facturas.each do |factura|
      return factura.fact
    end
  end


  helper_method :facturacero6

  def facturacero6(campo)
    @facturas = Objeto.find_by_sql("select lpad(#{campo},6,'0') fact from dual")
    @facturas.each do |factura|
      return factura.fact
    end
  end

  helper_method :replacespace

  def replacespace(campo)
    b = campo.sub(" ", "%%")
    b = b.sub(" ", "%%")
    b = b.sub(" ", "%%")
    b = b.sub(" ", "%%")
    b = b.sub(" ", "%%")
    return b
  end

  helper_method :is_select_pagaduria

  def is_select_pagaduria
    @objetos = Pagaduria.order('nombre')
    return @objetos
  end

  helper_method :is_select_cooperativa

  def is_select_cooperativa
    @objetos = Cooperativa.order('nombre')
    return @objetos
  end

  helper_method :is_select_inversionista

  def is_select_inversionista
    @objetos = Inversionista.order('nombre')
    return @objetos
  end

  helper_method :is_select_razonespago

  def is_select_razonespago
    @objetos = Razonespago.includes(:razonesportafolios).where(razonesportafolios: { portafolio_id: is_portafolio }).order(:descripcion)
    return @objetos
  end

  helper_method :is_portafolio

  def is_portafolio
    if user_signed_in?
      return User.find(is_admin).portafolio_id
    end
  end

  helper_method :is_authport

  def is_authport(port)
    return User.exists?(["id = #{is_admin} and portafolio_id in (#{port})"]) rescue nil
  end

  helper_method :is_garantia

  def is_garantia
    return User.find(is_admin).portafolio.garantia.to_s rescue nil
  end

  helper_method :cohorte_metodopago

  def cohorte_metodopago(programa)
    if programa.cohorte.forma_pago == 'SI'
      return true
    else
      return false
    end
  rescue
  end

  helper_method :is_obligaciones

  def is_obligaciones
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.obligaciones.to_s rescue nil
    end
  end

  helper_method :is_consolidado

  def is_consolidado
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.consolidado.to_s rescue nil
    end
  end

  helper_method :is_credito

  def is_credito
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.credito.to_s rescue nil
    end
  end

  helper_method :is_normalizacion

  def is_normalizacion
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.normalizacion.to_s rescue nil
    end
  end

  helper_method :is_gestionpagaduria

  def is_gestionpagaduria
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestionpagaduria.to_s rescue nil
    end
  end

  helper_method :is_gestioncobro

  def is_gestioncobro
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestioncobro.to_s rescue nil
    end
  end

  helper_method :is_cobranzajuridica

  def is_cobranzajuridica
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.cobranzajuridica.to_s rescue nil
    end
  end

  helper_method :is_coactivo

  def is_coactivo
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.coactivo.to_s rescue nil
    end
  end

  helper_method :is_digital

  def is_digital
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.digital.to_s rescue nil
    end
  end

  helper_method :is_campanas

  def is_campanas
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.campanas.to_s rescue nil
    end
  end

  helper_method :is_academico

  def is_academico
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.academico.to_s rescue nil
    end
  end

  helper_method :is_giros

  def is_giros
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.giros.to_s rescue nil
    end
  end

  helper_method :is_liquidacionpac

  def is_liquidacionpac
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.liquidacionpac.to_s rescue nil
    end
  end

  helper_method :is_gestionmundial

  def is_gestionmundial
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestionmundial.to_s rescue nil
    end
  end

  helper_method :is_gestioncovinoc

  def is_gestioncovinoc
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestioncovinoc.to_s rescue nil
    end
  end

  helper_method :is_gestionkfg

  def is_gestionkfg
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestionkfg.to_s rescue nil
    end
  end

  helper_method :is_gestiongps

  def is_gestiongps
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestiongps.to_s rescue nil
    end
  end

  helper_method :is_gestiongintac

  def is_gestiongintac
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.gestiongintac.to_s rescue nil
    end
  end

  helper_method :is_helenas

  def is_helenas
    if User.find(is_admin).geintac.to_s == 'SI'
      return 'SI'
    else
      return User.find(is_admin).portafolio.helenas.to_s rescue nil
    end
  end

  helper_method :is_nextpagare

  def is_nextpagare
    maxpagar = Personasacuerdo.where("portafolio_id = #{User.find(is_admin).portafolio_id} and numero_pagare is not null ").maximum('numero_pagare') rescue 0
    if maxpagar.to_i == 0
      nextdato = 1
    else
      nextdato = maxpagar + 1
    end
    return nextdato.to_s
  end

  helper_method :is_dash

  def is_dash
    isportafolio = is_portafolio
    if isportafolio != 10100 and isportafolio != 10101
      if User.find(is_admin).dashboard.to_s == 'NO'
        return false
      else
        return true
      end
    else
      return true
    end
  end

  helper_method :is_tipoconsulta

  def is_tipoconsulta
    if user_signed_in?
      return User.find(is_admin).tipoconsulta.to_s
    end
  end

  helper_method :is_portafoliossucursal

  def is_portafoliossucursal
    if user_signed_in?
      return User.find(is_admin).portafoliossucursal_id rescue nil
    end
  end

  helper_method :is_portafoliosvehiculo

  def is_portafoliosvehiculo
    if user_signed_in?
      return User.find(is_admin).portafoliosvehiculo_id rescue nil
    end
  end

  helper_method :is_portafoliosdemandante

  def is_portafoliosdemandante
    if user_signed_in?
      return User.find(is_admin).portafoliosdemandante_id rescue nil
    end
  end

  helper_method :is_originador

  def is_originador
    if user_signed_in?
      return User.find(is_admin).cliente_id
    end
  end


  helper_method :is_consecutivo

  def is_consecutivo
    @facturas = Objeto.find_by_sql("select fnc_consecutivorecaudo(#{is_portafolio}) vlr from dual")
    @facturas.each do |factura|
      return factura.vlr
    end
  end

  helper_method :is_adminext

  def is_adminext
    if user_signed_in?
      return User.find(is_admin).extension.to_s rescue nil
    end
  end


  helper_method :is_consecutivootrosrecaudo

  def is_consecutivootrosrecaudo
    @facturas = Objeto.find_by_sql("select fnc_consecutivorecaudootros(#{is_portafolio}) vlr from dual")
    @facturas.each do |factura|
      return factura.vlr
    end
  end

  helper_method :is_bloqueo

  def is_bloqueo
    if User.find(is_admin).portafolio.bloqueo.to_s == 'SI'
      return true
    else
      return false
    end
  end

  helper_method :is_agenda

  def is_agenda
    if Agenda.exists?(["user_id = #{is_admin} and estado = 'PENDIENTE' and TO_DATE(fecha, 'YYYY-MM-DD HH24:MI:SS') <= TO_DATE(sysdate, 'YYYY-MM-DD HH24:MI:SS') + (15 / 1440)"]) == true
      return true
    else
      return false
    end
  end

  helper_method :is_sygma

  def is_sygma
    if User.find(is_admin).geintac.to_s == 'S'
      return true
    else
      return false
    end
  end

  helper_method :is_soporteadmin

  def is_soporteadmin
    if User.find(is_admin).soportes_admin.to_s == 'SI'
      return true
    else
      return false
    end
  end

  helper_method :is_pqrs

  def is_pqrs
    if User.find(is_admin).lider_pqrs.to_s == 'SI'
      return true
    else
      return false
    end
  end


  helper_method :is_supersygma

  def is_supersygma
    if User.find(is_admin).supersygma.to_s == 'YES'
      return true
    else
      return false
    end
  end

  helper_method :is_edupol

  def is_edupol
    if is_portafolio == 10100 or is_portafolio == 10101 or is_portafolio == 10041 or is_portafolio == 10040
      return true
    else
      return false
    end
  end

  helper_method :is_etapa

  def is_etapa
    if user_signed_in?
      return User.find(is_admin).etapa.to_s
    end
  end


  helper_method :is_auth_c

  def is_auth_c(objeto)
    objetoid = Objeto.find_by_descripcion(objeto.to_s).id rescue 0
    if objetoid.to_s != ""
      return Userspermiso.exists?(["user_id = ? and objeto_id = ? and crea = 'S'", is_admin, objetoid])
    else
      return false
    end
  end

  helper_method :is_auth_e

  def is_auth_e(objeto)
    objetoid = Objeto.find_by_descripcion(objeto.to_s).id rescue 0
    if objetoid.to_s != ""
      return Userspermiso.exists?(["user_id = ? and objeto_id = ? and elimina = 'S'", is_admin, objetoid])
    else
      return false
    end
  end

  helper_method :is_auth_a

  def is_auth_a(objeto)
    objetoid = Objeto.find_by_descripcion(objeto.to_s).id rescue 0
    if objetoid.to_s != ""
      return Userspermiso.exists?(["user_id = ? and objeto_id = ? and actualiza = 'S'", is_admin, objetoid])
    else
      return false
    end
  end




  helper_method :camposvacios

  def camposvacios(dato)
    if dato.to_s == "[]"
      return dato = ""
    else
      return dato
    end
  end

  helper_method :is_select_estadosdeudor

  def is_select_estadosdeudor
    @objetos = Estado.includes(:estadosportafolios).where(estadosportafolios: { portafolio_id: is_portafolio }).order(:descripcion)
    return @objetos
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:otp_attempt])

    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit!
    end
    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit!
    end
  end

  helper_method :is_autoreporte

  def is_autoreporte(reporte_id)
    datoid = is_portafolio.to_i
    if Portafoliosreporte.exists?(["portafolio_id = #{datoid} and reporte_id = #{reporte_id}"])
      return true
    end
  end

  helper_method :is_select_sucursal

  def is_select_sucursal(portafolioid)
    @objetos = Portafoliossucursal.where(portafolio_id: portafolioid).order(:descripcion)
    return @objetos
  end

  helper_method :is_select_vehiculo

  def is_select_vehiculo(portafolioid)
    @objetos = Portafoliosvehiculo.where(portafolio_id: portafolioid).order(:descripcion)
    return @objetos
  end


  helper_method :is_estudiante

  def is_estudiante
    isportafolio = is_portafolio
    if is_tipoconsulta.to_s == 'ESTUDIANTE' and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or isportafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_funcionario

  def is_funcionario
    isportafolio = is_portafolio
    istipoconsulta = is_tipoconsulta
    if (istipoconsulta.to_s == 'FUNCIONARIO' or istipoconsulta.to_s == 'TODO') and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_edupolespecial

  def is_edupolespecial
    isportafolio = is_portafolio
    if (is_tipoconsulta.to_s == 'EDUPOLESPECIAL' or is_tipoconsulta.to_s == 'EXPERIENCIAESPECIAL') and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_konfiguracvu

  def is_konfiguracvu
    if [10122, 10121, 10240, 10241, 10242, 10243].include?(@personasobligacion.cliente) and is_portafolio == 10013
      return true
    else
      return false
    end
  end

  helper_method :is_konfiguracolpatria

  def is_konfiguracolpatria
    if [10244, 10245, 10246, 10247, 10248, 10249, 10250, 10251, 10252, 10253, 10254, 10255, 10256, 10257, 10258, 10259, 10260, 10261, 10262, 10263, 10264, 10265, 10266, 10267, 10268, 10269, 10270, 11780].include?(@personasobligacion.cliente) and is_portafolio == 10013
      return true
    else
      return false
    end
  end

  helper_method :is_konfigurarai

  def is_konfigurarai
    if [11003, 11004, 11005, 11006, 11007, 11008, 11009, 11010, 11011, 11012, 11014, 11013].include?(@personasobligacion.cliente) and is_portafolio == 10013
      return true
    else
      return false
    end
  end

  helper_method :is_centro

  def is_centro
    if (is_tipoconsulta.to_s == 'CENTROAPOYO' or is_tipoconsulta.to_s == 'COMERCIAL') and (is_portafolio == 10100 or is_portafolio == 10101 or is_portafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_centroapoyo

  def is_centroapoyo
    isportafolio = is_portafolio
    if is_tipoconsulta.to_s == 'CENTROAPOYO' and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_universidad

  def is_universidad
    isportafolio = is_portafolio
    if is_tipoconsulta.to_s == 'UNIVERSIDAD' and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_tecnico

  def is_tecnico
    isportafolio = is_portafolio
    if is_tipoconsulta.to_s == 'TECNICO' and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_estudiantepersonaid

  def is_estudiantepersonaid
    isportafolio = is_portafolio
    if is_tipoconsulta.to_s == 'ESTUDIANTE' and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return User.find(is_admin).persona_id
    end
  end

  helper_method :is_disabled

  def is_disabled
    if is_auth_c('actualizadatos') == true
      return false
    else
      return true
    end
  end

  helper_method :is_edupolauto

  def is_edupolauto
    isportafolio = is_portafolio
    if (is_edupolespecial or is_centroapoyo or is_estudiante) and (isportafolio == 10100 or isportafolio == 10101 or isportafolio == 10041 or is_portafolio == 10040)
      return true
    else
      return false
    end
  end

  helper_method :is_datosedupol

  def is_datosedupol(dato, referencia)
    if referencia.to_s == 'CENTRO'
      dato = Centro.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'TIPODOCUMENTO'
      dato = Tiposdocumento.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'ESTADOCIVIL'
      dato = Estadoscivil.where(descripcion_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'CIUDAD'
      dato = Municipio.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'UNIVERSIDAD'
      dato = Universidad.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'PROGRAMA'
      dato = Universidadesprograma.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'COHORTE'
      dato = Cohorte.where(id_edupol: dato).first.id rescue nil
    elsif referencia.to_s == 'TIPOSOLICITUD'
      if dato == 'NUEVO (POR PRIMERA VEZ)'
        dato = 'NUEVO'
      elsif dato == 'RENOVACION'
        dato = 'RENOVACION'
      elsif dato == nil
        dato = 'NN'
      end
    elsif referencia.to_s == 'GENERO'
      if dato == 'M'
        dato = 'MASCULINO'
      elsif dato == 'F'
        dato = 'FEMENINO'
      end
    end
    return dato
  end

  helper_method :is_activo_cohorte

  def is_activo_cohorte(cohorteId, universidadesprogramaId)
    if Cohortesprograma.exists?(["cohorte_id = #{cohorteId} and universidadesprograma_id = #{universidadesprogramaId} and estado_doc = 'ACTIVO'"])
      return true
      #elsif Cohortesprograma.exists?(["cohorte_id <> #{cohorteId} and universidadesprograma_id <> #{universidadesprogramaId}"])
      #  return true
    else
      return false
    end
  end

  helper_method :is_edupolconseobl

  def is_edupolconseobl
    return is_edupolconseobligacion
  end

  helper_method :is_barcode

  def is_barcode(tipo, dato, size, nombre)
    name = "#{::Rails.root}/public/codes/#{nombre.to_s}.png"
    if File.exist?(name) == false
      #@blob = Barby::GS1128.new('1','B',p.consecutivo.to_s).to_png(height: 20, margin: 5)
      #@blob2 = Barby::QrCode.new(p.consecutivo.to_s).to_png(:xdim => 2)
      if tipo.to_s == 'GS1128' and dato.to_s != "" and size.to_i > 0 and nombre.to_s != ""
        blob = Barby::GS1128.new(nil, 'C', dato.to_s).to_png(:margin => 2, :height => 55)
        #blob = Barby::GS1128.new(nil,'B',dato.to_s).to_png(height: 40, width: size.to_i)
        File.open(name.to_s, 'wb') { |f| f.write blob }
      elsif tipo.to_s == 'QRCODE' and dato.to_s != "" and size.to_i > 0
        name = "#{::Rails.root}/public/qr/#{nombre.to_s}.png"
        blob = Barby::QrCode.new(dato.to_s).to_png(:xdim => size.to_i)
        File.open(name.to_s, 'wb') { |f| f.write blob }
      end
    end
  end

  helper_method :is_pazysalvo

  def is_pazysalvo
    isportafolio = is_portafolio
    if isportafolio == 10025 or isportafolio == 10032
      nextconsecutivo = Objeto.find_by_sql(["select sistem_pazysalvos.nextval valor from dual"])[0].valor.to_i rescue 0
    elsif isportafolio == 10026
      nextconsecutivo = Objeto.find_by_sql(["select sistemhon_pazysalvos.nextval valor from dual"])[0].valor.to_i rescue 0
    elsif isportafolio == 10027
      nextconsecutivo = Objeto.find_by_sql(["select sistem_pazysalvosperu.nextval valor from dual"])[0].valor.to_i rescue 0
    elsif isportafolio == 10028
      nextconsecutivo = Objeto.find_by_sql(["select sistem_pazysalvosdentix.nextval valor from dual"])[0].valor.to_i rescue 0
    else
      begin
        lastconsecutivo = Personasobligacion.where(["portafolio_id = 10014 and nro_pazysalvo is not null"]).maximum('nro_pazysalvo')
      rescue
        lastconsecutivo = 0
      end
      if lastconsecutivo.to_i == 0
        nextconsecutivo = 201800001
      else
        nextconsecutivo = lastconsecutivo + 1
      end
    end
    return nextconsecutivo
  end

  helper_method :is_keymd5

  def is_keymd5(message)
    return Digest::MD5.hexdigest(message)
  end

  helper_method :is_keysha256

  def is_keysha256(message)
    return Digest::SHA256.hexdigest(message)
  end

  helper_method :is_edad

  def is_edad(fecha_nacimiento)
    @objetos = Objeto.find_by_sql(["select trunc(months_between(sysdate, to_date('#{fecha_nacimiento.to_date}','yyyy/mm/dd'))/12) fecha_nacimiento from dual"])
    @objetos.each do |objeto|
      return objeto.fecha_nacimiento
    end
  end

  helper_method :diferenciadias

  def diferenciadias(fecha)
    dias = (Date.today - fecha).to_i
    return dias
  end

  helper_method :diferenciadiasfechas

  def diferenciadiasfechas(fecha1, fecha2)
    if fecha1.present? and fecha2.present?
      fech1 = Date.parse fecha1.to_s
      fech2 = Date.parse fecha2.to_s
      dias = (fech1 - fech2).to_i
      return dias
    end
  end

  helper_method :is_simbolo

  def is_simbolo(dato)
    dato = dato.strip.to_s rescue nil
    if dato.to_s == 'COP'
      var = "<label class='label label-success'>#{dato}</label>".html_safe
    elsif dato.to_s == 'UVR'
      var = "<label class='label label-primary'>#{dato}</label>".html_safe
    elsif dato.to_s == 'USD'
      var = "<label class='label label-info'>#{dato}</label>".html_safe
    elsif dato.to_s == 'PEN' or dato.to_s == 'SOLES'
      var = "<label class='label label-warning'>#{dato}</label>".html_safe
    elsif dato.to_s == 'EUR'
      var = "<label class='label label-danger'>#{dato}</label>".html_safe
    elsif dato.to_s == 'HNL'
      var = "<label class='label label-primary'>#{dato}</label>".html_safe
    else
      var = "<label class='label label-danger'>#{dato}</label>".html_safe
    end
    return var rescue nil
  end

  helper_method :is_moneda

  def is_moneda(dato)
    dato = dato.strip.to_s rescue nil
    if dato.to_s == 'COP'
      var = "PESOS"
    elsif dato.to_s == 'UVR'
      var = "UVRS"
    elsif dato.to_s == 'USD'
      var = "DOLARES"
    elsif dato.to_s == 'PEN' or dato.to_s == 'SOLES'
      var = "SOLES"
    elsif dato.to_s == 'EUR'
      var = "EUROS"
    elsif dato.to_s == 'HNL'
      var = "LEMPIRAS"
    else
      var = dato
    end
    return var rescue nil
  end

  helper_method :is_estadosbancos

  def is_estadosbancos(dato)
    dato = dato.strip.to_s rescue nil
    if dato.to_s == 'POR ENVIAR'
      var = "<label class='label label-warning'>#{dato}</label>".html_safe
    elsif dato.to_s == 'ENVIADO'
      var = "<label class='label label-primary'>#{dato}</label>".html_safe
    elsif dato.to_s == 'PROCESADO'
      var = "<label class='label label-danger'>#{dato}</label>".html_safe
    elsif dato.to_s == 'FINALIZADO'
      var = "<label class='label label-success'>#{dato}</label>".html_safe
    end
    return var rescue nil
  end

  helper_method :color_estado

  def color_estado(dato)
    dato = dato.strip.to_s rescue nil
    if dato.to_s == 'ACTIVO'
      var = "<label class='label label-success'>#{dato}</label>".html_safe
    elsif dato.to_s == 'INACTIVO'
      var = "<label class='label label-danger'>#{dato}</label>".html_safe
    end
    return var rescue nil
  end

  helper_method :is_select_tipoinmueblebuscador

  def is_select_tipoinmueblebuscador(portafolioid)
    @objetos = Tiposinmueble.where(["id in (select distinct tiposinmueble_id from inmuebles where portafolio_id =  #{portafolioid})"]).order("descripcion")
    return @objetos
  end

  helper_method :is_select_perumunicipio

  def is_select_perumunicipio
    @municipios = Perumunicipio.order("ciudad").all
    return @municipios
  end

  helper_method :select_naturalezapersona

  def select_naturalezapersona
    @naturalezapersonas = Parnaturalezadeudor.all.order('cod_cifin')
    return @naturalezapersonas
  end

  helper_method :select_situaciondeudor

  def select_situaciondeudor
    @situaciondeudores = Parsituaciondeudor.all.order('cod_cifin')
    return @situaciondeudores
  end

  helper_method :is_valida_cierre

  def is_valida_cierre
    if is_sygma
      return true
    else
      isportafolio = is_portafolio
      por = Portafolio.find(isportafolio)
      if por.bloqueo_recaudo.to_s == 'SI'
        return false
      else
        if por.valida_cierre.to_s == 'SI'
          valida = Portafolioscierre.where(["portafolio_id = #{isportafolio} and anno||'_'||mes = to_char(ADD_MONTHS(sysdate,-1),'YYYY_MM')"]).select(:tipo).distinct rescue nil
          if valida.count.to_i > 0
            if valida[0].tipo.to_s == 'CONSOLIDADO'
              return true
            else
              return false
            end
          else
            return false
          end
        else
          return true
        end
      end
    end

  end

  helper_method :is_estudiocredito

  def is_estudiocredito
    por = Portafolio.find(is_portafolio)
    if por.estudio_credito == 'SI'
      return true
    else
      return false
    end
  end

  helper_method :is_dashboard

  def is_dashboard
    if is_sygma
      return true
    else
      isportafolio = is_portafolio
      por = Portafolio.find(isportafolio)
      if por.act_dash.to_s == 'SI'
        return true
      else
        return false
      end
    end
  end

  helper_method :is_consmig

  def is_consmig
    lastConsecutivo = Objeto.find_by_sql(["select CONSMIG_SEQ.nextval cons from dual"]).first rescue 0
    return lastConsecutivo.cons
  end

  helper_method :seleccionar_tiposdocumentos

  def seleccionar_tiposdocumentos
    if self.parametrizacioncolombia == true
      if [10023, 10025, 10026, 10027, 10028, 10029, 10030, 10031, 10040, 10041, 10042, 10032, 10033, 10034, 10035, 10301].include?(is_portafolio)
        @documentos = Tiposdocumento.where("id in (select tiposdocumento_id from tiposdocumentosportafolios where portafolio_id = #{is_portafolio})").order("cod_cifin")
      else
        @documentos = Tiposdocumento.where(co: 'SI').order("cod_cifin")
      end
      return @documentos
    else
      @documentos = Tiposdocumento.where(pe: 'SI').order("descripcion")
      return @documentos
    end
  end

  helper_method :select_origenespago

  def select_origenespago
    @origenes = Parorigenespago.where(activo_manual: 'SI').order("descripcion")
    return @origenes
  end

  helper_method :select_lotespendientes

  def select_lotespendientes
    @lotes = Inmueblesgastosbanco.select(:num_archivo).distinct.where(estado: 'ENVIADO')
    return @lotes
  end

  helper_method :select_lotespendientesbcp

  def select_lotespendientesbcp
    @lotes = Personasprogastosbanco.select(:num_archivo).distinct.where("estado = 'ENVIADO' and personasprogasto_id in (select id from personasprogastos where (bbva ='NO' or bbva is null))")
    return @lotes
  end

  helper_method :select_lotespendientesbbva

  def select_lotespendientesbbva
    @lotes = Personasprogastosbanco.select(:num_archivo).distinct.where("estado = 'ENVIADO' and personasprogasto_id in (select id from personasprogastos where bbva ='SI')")
    #@lotes = Personasprogastosbanco.select(:num_archivo).distinct.where(estado: 'ENVIADO')
    return @lotes
  end

  helper_method :select_consecutivospendientes

  def select_consecutivospendientes
    @lotes = Personasprogasto.select(:consecutivo_migracion).distinct.where(estado: 'PENDIENTE').where.not(consecutivo_migracion: nil)
    return @lotes
  end

  helper_method :is_select_broker

  def is_select_broker(portafolioid)
    @objetos = Broker.where(["id in (select broker_id from inmueblesbrokers where inmueble_id in (select id from inmuebles where portafolio_id =  #{portafolioid}))"]).order("nombre")
    return @objetos
  end

  helper_method :is_controlmigracion

  def is_controlmigracion
    c = Objeto.find_by_sql(["select CONTROLMIGRACIONES_SEQ.nextval cons from dual"]).first rescue 0
    return c.cons.to_s
  end

  helper_method :is_sumardias

  def is_sumardias(dias)
    return Objeto.find_by_sql("select (trunc(sysdate) + #{dias}) fch from dual")[0].fch
  end

  helper_method :is_select_estado_bloqueo

  def is_select_estado_bloqueo
    return Objeto.find_by_sql("select distinct bloqueo, decode(bloqueo,null,'SIN Codigo',bloqueo) descripcion from personasobldatacreditos")
  end

  helper_method :is_pais

  def is_pais
    isportafolio = is_portafolio
    if isportafolio == 10026
      return 'HONDURAS'
    elsif isportafolio == 10029
      return 'CHILE'
    elsif isportafolio == 10030
      return 'PANAMA'
    elsif isportafolio == 10033
      return 'MEXICO'
    else
      return 'COLOMBIA'
    end
  end

  helper_method :is_cargohabilitado

  def is_cargohabilitado(isadmin)
    if User.exists?(["id = #{isadmin} and portafolioscargo_id in (11243,11242)"])
      return true
    else
      return false
    end
  end

  helper_method :is_cargousuarios

  def is_cargousuarios(isadmin)
    if User.exists?(["id = #{isadmin} and portafolioscargo_id = 12862"])
      return true
    else
      return false
    end
  end

  helper_method :is_cargoconsulta

  def is_cargoconsulta
    if User.exists?(["id = #{is_admin} and portafolioscargo_id = 11342"])
      return false
    else
      return true
    end
  end

  helper_method :is_cargojefefit

  def is_cargojefefit
    # JEFE DE IT  - JEFE IT - ALTERNO
    if User.exists?(["id = #{is_admin} and portafolioscargo_id in (10642,11642)"])
      return true
    else
      return false
    end
  end

  helper_method :is_cargoconsulta2

  def is_cargoconsulta2
    if User.exists?(["id = #{is_admin} and portafolioscargo_id = 11422"])
      return false
    else
      return true
    end
  end

  helper_method :is_ambito

  def is_ambito
    return User.find(is_admin).ambito rescue nil
  end

  helper_method :is_fit

  def is_fit(dato)
    dato = dato.strip.to_s rescue nil
    if dato.to_s == 'NO' or dato.to_s == 'NO MATCH' or dato.to_s == 'REJECTED'
      var = "<label class='label label-danger'>#{dato}</label>".html_safe
    elsif dato.to_s == 'APPROVED'
      var = "<label class='label label-success'>#{dato}</label>".html_safe
    elsif dato.to_s == 'PENDING'
      var = "<label class='label label-info'>#{dato}</label>".html_safe
    else
      var = dato.to_s
    end
    return var rescue nil
  end

  helper_method :is_nromeses

  def is_nromeses(date1, date2)
    cant = (date2.to_date.year * 12 + date2.to_date.month) - (date1.to_date.year * 12 + date1.to_date.month)
    return cant
  end

  helper_method :is_tipocartera

  def is_tipocartera(dato)
    if dato.to_i == 10082
      if is_portafolio == 10100
        return Partiposcartera.find(dato).descripcion rescue nil
      elsif is_portafolio == 10101
        return Partiposcartera.find(dato).descripcion2 rescue nil
      end
    else
      return Partiposcartera.find(dato).descripcion rescue nil
    end
  end

  helper_method :is_select_messystem

  def is_select_messystem
    @datos = Fechascontable.select(["to_char(fecha,'MM') mes"]).distinct.where(["to_char(fecha,'YYYY') = to_char(trunc(sysdate),'YYYY') and to_char(fecha,'YYYYMM') = to_char(trunc(sysdate)-10,'YYYYMM')"])
    return @datos
  end

  helper_method :is_select_annosystem

  def is_select_annosystem
    @datos = Fechascontable.select(["to_char(fecha,'YYYY') anno"]).distinct.where(["to_char(fecha,'YYYY') = to_char(trunc(sysdate),'YYYY') and to_char(fecha,'YYYYMM') = to_char(trunc(sysdate)-10,'YYYYMM')"])
    return @datos
  end

  helper_method :is_calculofechalimite

  def is_calculofechalimite(fch1, dias, portafolio)
    return Objeto.find_by_sql("select fnc_calculofechalimite('#{fch1.to_date}',#{dias},#{portafolio}) fch from dual")[0].fch
  end

  helper_method :is_calculofechalimitepqrs

  def is_calculofechalimitepqrs(fch1, dias)
    return Objeto.find_by_sql("select fnc_calculofechalimitepqrs('#{fch1.to_date}',#{dias}) fch from dual")[0].fch
  end

  helper_method :is_liderpqrs

  def is_liderpqrs
    if User.find(is_admin).lider_pqrs == 'SI'
      return true
    else
      return false
    end
  end

  helper_method :validateAction

  def validateAction(params)
    params == 'edit' ? true : false
  end

  helper_method :is_educacion?

  def is_educacion?
    [10100, 10101, 10040].include?(is_portafolio) ? true : false
  end

  helper_method :is_validarcuentapago

  def is_validarcuentapago(tipocartera, universidadId)
    if Portafolioscuentaspago.where(portafolio_id: is_portafolio, partiposcartera_id: tipocartera, universidad_id: universidadId).any?
      return Portafolioscuentaspago.where(portafolio_id: is_portafolio, partiposcartera_id: tipocartera, universidad_id: universidadId).last
    else
      return Portafolioscuentaspago.where(portafolio_id: is_portafolio, partiposcartera_id: tipocartera, universidad_id: nil).last
    end
  end

  # Metodo para el response de los excel - AFP 16/Marzo/2022
  def response_body_xlsx(name)
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=#{name}_#{Time.now.strftime("%Y%m%d_%H%M%S")}.xlsx"
      }
    end
  end

  # Descripcion: Creacion de funcion para generar token Paymentez
  # Fecha Creacion: 23-Junio-2022
  # Autor: AFP
  helper_method :is_toke_paymentez

  def is_toke_paymentez(appCode, timeStamp, uniqToken)
    Objeto.find_by_sql("select fch_teseo_tokenpaymentez('#{appCode}','#{timeStamp}','#{uniqToken}') token_uniq from dual")[0].token_uniq
  end

  # Descripcion: Retorna id del cargo
  # Fecha Creacion: 3-Julio-2022
  # Autor: AFP
  helper_method :is_portafolioscargo

  def is_portafolioscargo
    current_user.portafolioscargo_id rescue nil
  end

  # Descripcion: Valida el cargo
  # Fecha Creacion: 3-Julio-2022
  # Autor: AFP
  helper_method :is_portafolioscargovalida

  def is_portafolioscargovalida
    current_user.portafolioscargo_id.present? ? true : false
  end

  # Metodo para el response de los PDF - AFP 12/Agosto/2022
  def response_body_pdf(name, top, bottom, left, rigth, header, footer, template)
    respond_to do |format|
      format.pdf do
        render :pdf => name,
               :template => template,
               margin: { top: top, bottom: bottom, left: left, right: rigth },
               encoding: "UTF-8",
               footer: { :html => { :template => footer } },
               :header => { spacing: 10, :html => { :template => header } }
      end
    end
  end
end