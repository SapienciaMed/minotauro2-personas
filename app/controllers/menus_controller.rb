class MenusController < ApplicationController
  layout :set_layout

  before_action :verificardatos, if: :user_signed_in?

  before_action :validatesession
  before_action :authenticate_user!, except: [:desbloqueoreset]

  def documentacionGit
  end

  def prueba
    fname = "Prueba"
    respond_to do |format|
      format.pdf {render pdf: "#{fname}", template: "menus/prueba.html.erb", encoding: "UTF-8", page_size: 'Letter',:margin => {top: 15, :bottom => 20, :left => 15,:right => 15}}
    end
  end

  def desbloqueoreset
    @user = User.find_by_username(params[:username])
    if @user.present?
      @user.failed_attempts = 0
      @user.unlock_token = nil
      @user.locked_at = nil
      @user.password = params[:username].to_s
      @user.save(validate: false)
      flash['success'] = "Usuario desbloqueado con exito!!!"
    else
      flash['warning'] = "El usuario no existe, Favor comunicate con Sapiencia!!!"
    end
    redirect_to root_path
  end

  def mostrar_documento
    @ruta = params[:ruta]
  end

  def download
    documento = File.join(Rails.root, "app", "assets", "postman")
    send_file(File.join(documento, params[:file].to_s))
  end

  def verificardatos
    if User.find(is_admin).sign_in_count == 1
      redirect_to edit_user_registration_path
      flash[:warning] = 'Por favor actualiza tus datos'
    end
  end

  def abrir_tratamientodatos
    if params[:personasprograma_id].present?
      @personasprograma = Personasprograma.find(params[:personasprograma_id]) rescue nil
    elsif params[:personasrenovacion_id].present?
      @personasrenovacion = Personasrenovacion.find(params[:personasrenovacion_id]) rescue nil
    end
  end

  def semaforoalertas
    @semaforodata = Personasproetapa.where(["personasproceso_id in (select id from personasprocesos where portafolio_id = #{is_portafolio})"]).paginate(page: params[:page], per_page: 10).order('created_at DESC')
  end

  def filtrocredito2
    @var4 = params[:vehiculo]
    @var5 = params[:propietario]
    @obj1 = ""
    if params[:vehiculo].to_s == "" and params[:propietario].to_s == ""
      flash[:warning] = 'No ha seleccionado ningun filtro'
    elsif params[:vehiculo].to_s == ""
      flash[:warning] = 'Debe seleccionar un Vehiculo'
    else
      if @var4 == ""
        @var4 = -1
      end
      if @var5 == ""
        @var5 = -1
      end
    end
    redirect_to menus_path(var4: @var4, var5: @var5, filtro: 'SI')
  end

  def filtroedu
    isadmin = is_admin
    @var1 = params[:periodoacademico]
    @var2 = params[:cau]
    @var3 = params[:ies]
    @obj1 = ""
    if params[:periodoacademico].to_s == "" and params[:cau].to_s == "" and params[:ies].to_s == ""
      flash[:warning] = ''
    elsif params[:periodoacademico].to_s == ""
      flash[:warning] = 'Debe seleccionar un Periodo Académico'
    else
      if @var1.to_s == ""
        @var1 = '-1'
      end
      if @var2.to_s == ""
        if is_tipoconsulta == 'CENTROAPOYO'
          @var2 = Objeto.find_by_sql(["select distinct centro_id from centrosusers where user_id = #{isadmin}"])[0].centro_id
        else
          @var2 = '-1'
        end
      end
      if @var3.to_s == ""
        if is_tipoconsulta == 'UNIVERSIDAD'
          @var3 = Objeto.find_by_sql(["select distinct universidad_id from universidadesusers where user_id = #{isadmin}"])[0].universidad_id
        else
          @var3 = '-1'
        end
      end
    end
    redirect_to menus_path(var1: @var1, var2: @var2, var3: @var3, filtroedu: 'SI', filtro: 'SI'), method: :post
  end

  def filtrosistem
    isadmin = is_admin
    @mes = params[:ubicacion][:mes]
    puts @mes
    redirect_to menus_path(mes: @mes), method: :post
  end

  def abrirmapa
    respond_to { |format| format.js }
  end

  def modogestion
    datoid = is_portafolio
    isadmin = is_admin
    @agendasgestion = Agenda.where("user_id = #{isadmin} and portafolio_id = #{datoid} and estado ='PENDIENTE' and clase = 'COMPROMISO DE GESTION'").order("fecha asc") rescue nil
    @agendasmenu = Agenda.where("user_id = #{isadmin} and portafolio_id = #{datoid} and estado ='PENDIENTE' and trunc(fecha) <= (trunc(sysdate) + 30)").order("fecha asc")
    @pagosacuerdos = Agenda.where("user_id = #{isadmin} and portafolio_id = #{datoid} and estado ='PENDIENTE PAGO' and trunc(fecha) = trunc(sysdate)").order("fecha asc")
    if is_auth_c('seguimientopqrs')
      @pqrstodos = Queja.find_by_sql("select quejas.*, trunc(sysdate) - trunc(created_at) dias from quejas where portafolio_id = #{datoid} and estado in ('PENDIENTE','ASIGNADA')")
    else
      @pqrstodos = Queja.includes(:quejasasignaciones).where(quejasasignaciones: { user_id: isadmin })
    end
    if is_auth_c('alertaspago')
      istipoconsulta = is_tipoconsulta
      if istipoconsulta.to_s == 'PORTAFOLIO'
        @pagosacuerdostodos = Agenda.where("user_id = #{isadmin} and portafolio_id = #{datoid} and estado ='PENDIENTE PAGO' and trunc(fecha) between trunc(sysdate) and trunc(sysdate) + 7").order("fecha asc")
      elsif istipoconsulta.to_s == 'SUCURSAL'
        @pagosacuerdostodos = Agenda.includes(:user).where(:users => { :portafolio_id => datoid, :portafoliossucursal_id => is_portafoliossucursal }, :agendas => { :estado => "PENDIENTE PAGO", :fecha => Time.now.strftime("%Y-%m-%d"), :portafolio_id => datoid }).order("agendas.user_id")
      elsif istipoconsulta.to_s == 'TODO'
        @pagosacuerdostodos = Agenda.where("portafolio_id = #{datoid} and estado ='PENDIENTE PAGO' and trunc(fecha) between trunc(sysdate) and trunc(sysdate) + 7").order("user_id, fecha asc")
      end
    end
  end

  def index5
    @configuraciones = Portafolio.find(is_portafolio).objetosdash.split(",")
  end

  def dash_estadocolocacioncredito
    @isportafolio = params[:p]
    @etiqueta = 'db_GraficaColocacionCreditos_1'
    @meses = "'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'"
    @fechasshow = Dashboardcalculado.select(["to_char(fechakpi,'MM') mes, to_char(fechakpi,'YYYY') anno"]).where(["portafolio_id = #{@isportafolio} and etiqueta = '#{@etiqueta}'"]).distinct(["to_char(fechakpi,'MM') dia, to_char(fechakpi,'YYYY') anno"]).order("to_char(fechakpi,'YYYY') desc,to_char(fechakpi,'MM') desc")
  end

  def dash_estadocolocacioncreditoacum
    @isportafolio = params[:p]
    @etiqueta = 'db_GraficaColocacionCreditosAcumMesDia_1'
    @meses = "'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'"
    @fechasshow = Dashboardcalculado.select(["to_char(fechakpi,'MM') mes, to_char(fechakpi,'YYYY') anno"]).where(["portafolio_id = #{@isportafolio} and etiqueta = '#{@etiqueta}'"]).distinct(["to_char(fechakpi,'MM') dia, to_char(fechakpi,'YYYY') anno"]).order("to_char(fechakpi,'YYYY') desc,to_char(fechakpi,'MM') desc")
  end

  def dash_recaudodia
    @isportafolio = params[:p]
    @etiqueta = 'db_GraficaRecaudoMesDia_1'
    @meses = "'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'"
    @fechasshow = Dashboardcalculado.select(["to_char(fechakpi,'MM') mes, to_char(fechakpi,'YYYY') anno"]).where(["portafolio_id = #{@isportafolio} and etiqueta = '#{@etiqueta}'"]).distinct(["to_char(fechakpi,'MM') dia, to_char(fechakpi,'YYYY') anno"]).order("to_char(fechakpi,'YYYY') desc,to_char(fechakpi,'MM') desc")
  end

  def dash_recaudoacum
    @isportafolio = params[:p]
    @etiqueta = 'db_GraficaRecaudoAcumuladoMesDia_1'
    @meses = "'01','02','03','04','05','06','07','08','09','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31'"
    @fechasshow = Dashboardcalculado.select(["to_char(fechakpi,'MM') mes, to_char(fechakpi,'YYYY') anno"]).where(["portafolio_id = #{@isportafolio} and etiqueta = '#{@etiqueta}'"]).distinct(["to_char(fechakpi,'MM') dia, to_char(fechakpi,'YYYY') anno"]).order("to_char(fechakpi,'YYYY') desc,to_char(fechakpi,'MM') desc")
  end

  # Metodo - Grafica Estado de Cartera en Barra
  def dash_estadocartera
    @isportafolio = params[:p] # Recibe el portafolioID
    @modelo = params[:g].to_s # Recibe el modelo
    @titulograf = Portafoliosconfiguracion.where(portafolio_id: @isportafolio, modelo: @modelo)[0].titulo.to_s rescue nil # Titulo de la grafica
    datos1 = Dashboardcalculado.select(["nombrekpi, orden"]).where(["portafolio_id = #{@isportafolio} and modelo = '#{@modelo}'"]).distinct(["etiqueta,nombrealternativo"]).order("orden asc")
    datos = datos1.map(&:nombrekpi).join(',').split(',')
    @meses = ""
    @meses << "'#{datos.join("','")}'" # Nombres KPIName
    @fechasshow = Dashboardcalculado.select(["etiqueta fch1, nombrealternativo dato2"]).where(["portafolio_id = #{@isportafolio} and modelo = '#{@modelo}'"]).distinct(["etiqueta,nombrealternativo"]).order("nombrealternativo ")
  end

  def dash_cesiones
    @isportafolio = params[:p]
    @modelo = params[:g].to_s
    @titulograf = Portafoliosconfiguracion.where(portafolio_id: @isportafolio, modelo: @modelo)[0].titulo.to_s rescue nil
    datos1 = Dashboardcalculado.select(["nombrekpi, orden"]).where(["portafolio_id = #{@isportafolio} and modelo = '#{@modelo}'"]).distinct(["etiqueta,nombrealternativo"]).order("orden asc")
    datos = datos1.map(&:nombrekpi).join(',').split(',')
    @meses = ""
    @meses << "'#{datos.join("','")}'"
    @fechasshow = Dashboardcalculado.select(["etiqueta fch1, nombrealternativo dato2"]).where(["portafolio_id = #{@isportafolio} and modelo = '#{@modelo}'"]).distinct(["etiqueta,nombrealternativo"]).order("nombrealternativo ")
  end

  def dash_cesionesconsol
    @isportafolio = params[:p]
    @modelo = 'GraficaCesionesConsolidadoDesgloseSucursal'
    @fechasshow = Dashboardcalculado.select(["nombrekpi, sum(valor) valor"]).where(["portafolio_id = #{@isportafolio} and modelo = '#{@modelo}'"]).distinct(["nombrekpi"]).group("nombrekpi").order("nombrekpi")
    datos = @fechasshow.map(&:valor).join(',').split(',')
    @sqlDatos = ""
    @sqlDatos << "'#{datos.join("','")}'"
  end

  def dash_gestiones
    isportafolio = params[:p]
    @meses = "'07:00','08:00','09:00','10:00','11:00','12:00','01:00','02:00','03:00','04:00','05:00','06:00','06:01 +'"
    @efectivas = []
    @noefectivas = []
    @totales = []
    Dashboardcalculado.select(["nombrekpi, valor"]).where(["portafolio_id = #{isportafolio} and etiqueta = 'db_GraficaGestionEfectivaMesHora_1'"]).order("nombrekpi asc").each do |d|
      @efectivas << d.valor
    end
    Dashboardcalculado.select(["nombrekpi, valor"]).where(["portafolio_id = #{isportafolio} and etiqueta = 'db_GraficaGestionNoEfectivaMesHora_1'"]).order("nombrekpi asc").each do |d|
      @noefectivas << d.valor
    end
    Dashboardcalculado.select(["nombrekpi, valor"]).where(["portafolio_id = #{isportafolio} and etiqueta = 'db_GraficaGestionTotalMesHora_1'"]).order("nombrekpi asc").each do |d|
      @totales << d.valor
    end
  end

  def generar_factura
    personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    code = WsController.crear_factura(personasobligacion.id)
    flash[:success] = 'Factura de siigo generada con exito !!!'
    #redirect_to edit_persona_path(id: personasobligacion.persona_id, etapa: 'F')
    redirect_to procesos_path
  end

  def generar_factura_automatica
    Personasobligacion.select("id").where([" portafolio_id = #{is_portafolio} and trunc(created_at) >= to_date('13-01-2021','dd-mm-yyyy') and partiposcartera_id = 10082 and obl_saldototaldeuda = 0
                 and   valor = (select sum(valor) from planesrecaudos where personasobligacion_id = personasobligaciones.id and tipo_pago != 'AJUSTE CREDITO')
                 AND   siigo_id is null"]).order("trunc(created_at) asc").each do |p|
      code = WsController.crear_factura(p.id)
    end
    flash[:success] = 'Factura de siigo generada masivamente con exito !!!'
    redirect_to procesos_path
  end

  def index
    if current_user.persona_id.present?
      @persona = Persona.find(current_user.persona_id)
    end
  end

  def call
    #@call = "http://google.com"
  end

  def recaudo_detalle_dia

  end

  def evolucion_recaudo_completo_d_edupol
    isadmin = is_admin
    isportafolio = is_portafolio
    istipoconsulta = is_tipoconsulta
    if istipoconsulta.to_s == 'UNIVERSIDAD'
      @objetos = Objeto.find_by_sql(["select distinct universidad_id dato, 'universidad' clase from edupolrecmensual where portafolio_id = #{isportafolio}
                                      and universidad_id in (select universidad_id from universidadesusers where user_id = #{isadmin}) group by universidad_id"])

    elsif istipoconsulta.to_s == 'CENTROAPOYO'
      @objetos = Objeto.find_by_sql(["select distinct centro_id dato, 'centro' clase from edupolrecmensual where portafolio_id = #{isportafolio}
                                    and centro_id in (select centro_id from centrosusers where user_id = #{isadmin}) group by centro_id"])
    end
  end

  def dashsygma
    if is_sygma
      ActiveRecord::Base.connection.execute("update users set dashsoporte_admin = decode(dashsoporte_admin,'SI','NO','NO','SI'),dashsoporte = decode(dashsoporte,'SI','NO','NO','SI')
                                             where id = #{is_admin}")
    end
    redirect_to root_path
  end

  # Descripcion: Metodo para filtrar por Semana Gestor en personasobservaciones
  # Fecha Creacion: 7-Abril-2022
  # Autor: AFP
  def filtrogestorsemana
  end

  # Descripcion: Metodo para filtrar por Semana Gestor en personasobservaciones
  # Fecha Creacion: 7-Abril-2022
  # Autor: AFP
  def filtrogestordia
  end

  require 'find'

  # Descripcion: Metodo para cargar imagenes
  # Fecha Creacion: 7-Abril-2022
  # Autor: AFP
  def uploadimagenes
    rutaupload = "#{::Rails.root}/public/cargue_gps/"
    Find.find(rutaupload) do |f|
      type = case
             when File.file?(f) then
               "F"
               file = File.open(f, 'rb')
               path = File.join(rutaupload, File.basename(f).to_s)
               nombre2 = File.basename(f).to_s
               nombre2 = nombre2.gsub(".png", "")
               nombre2 = nombre2.gsub(".PNG", "")
               nombre2 = nombre2.gsub(".tif", "")
               nombre2 = nombre2.gsub(".TIF", "")
               nombre2 = nombre2.gsub("_1.pdf", "")
               nombre2 = nombre2.gsub("_2.pdf", "")
               nombre2 = nombre2.gsub("_3.pdf", "")
               nombre2 = nombre2.gsub("_4.pdf", "")
               nombre2 = nombre2.gsub("_5.pdf", "")
               nombre2 = nombre2.gsub("_6.pdf", "")
               nombre2 = nombre2.gsub("_7.pdf", "")
               nombre2 = nombre2.gsub("_8.pdf", "")
               nombre2 = nombre2.gsub("_9.pdf", "")
               nombre2 = nombre2.gsub("_10.pdf", "")
               nombre2 = nombre2.gsub("_11.pdf", "")
               nombre2 = nombre2.gsub("_12.pdf", "")
               nombre2 = nombre2.gsub("_13.pdf", "")
               nombre2 = nombre2.gsub("_14.pdf", "")
               nombre2 = nombre2.gsub("_15.pdf", "")
               nombre2 = nombre2.gsub("_16.pdf", "")
               nombre2 = nombre2.gsub("_17.pdf", "")
               nombre2 = nombre2.gsub("_18.pdf", "")
               nombre2 = nombre2.gsub("_19.pdf", "")
               nombre2 = nombre2.gsub("_20.pdf", "")
               nombre2 = nombre2.gsub(".PDF", "")
               nombre2 = nombre2.gsub(".pdf", "")

               @persona = Persona.where("portafolio_id = #{is_portafolio} and identificacion = '#{nombre2.to_s}'").first
               #@persona = Persona.where("portafolio_id = #{is_portafolio} and id = (select distinct persona_id from tmpguia2 where guia = '#{nombre2.to_s}' and persona_id is not null)").first
               #@persona = Persona.where("portafolio_id = 10013 and id = (select distinct persona_id from tmpguia2 where guia = '#{nombre2.to_s}')").first
               if @persona
                 #logger.error("Ingresoo..."+@persona.id.to_s)
                 @personasimagen = Personasimagen.new
                 @personasimagen.persona_id = @persona.id
                 @personasimagen.user_id = is_admin
                 @personasimagen.portafolio_id = is_portafolio
                 @personasimagen.portafoliostiposdocumento_id = 11643
                 @personasimagen.descripcion = "COPIA LITERAL"
                 @personasimagen.persona = file

                 @personasimagen.save
                 file.close
                 if @personasimagen.id.to_i > 0
                   File.delete(path)
                 end
                 logger.error("LISTO ...................." + nombre2.to_s)
               else
                 logger.error("No existe .." + nombre2.to_s)
               end
             end
    end
    redirect_to root_path
  end

  # Descripcion: Metodo para cargar imagenes
  # Fecha Creacion: 7-Abril-2022
  # Autor: AFP
  def uploadimg_dentix

    rutaupload = "#{::Rails.root}/public/upload_dentix/"
    @files = Dir[rutaupload].sort_by { |f| File.mtime(f) }
    Find.find(rutaupload) do |f|
      type = case
             when File.file?(f) then
               "F"
               file = File.open(f, 'rb')
               path = File.join(rutaupload, File.basename(f).to_s)
               nombre_original = File.basename(f).to_s
               if nombre_original != '.DS_Store'
                 nombre_original2 = nombre_original.gsub(" ", '&')
                 nombre_original2 = nombre_original2.split("_")
                 nombre_documento = nombre_original2[2].gsub("&", " ")
                 nombre_original2.delete(nombre_original2[-1])
                 nombre_original2 << nombre_documento
                 nombre_documento = nombre_documento.gsub(".pdf", "")
                 nombre_documento = nombre_documento.gsub(".PDF", "")
                 personasobligacion = Personasobligacion.where("nro_obligacion = '#{nombre_original2[0]}' and portafolio_id = 10031").first rescue nil
                 persona = Persona.where("identificacion = '#{nombre_original2[1]}' and portafolio_id = 10031").first rescue nil
                 tipodocumento = Portafoliostiposdocumento.where("portafolio_id = 10031 and descripcion like '%#{nombre_documento}%'").first
                 if personasobligacion.present? and persona.present? and tipodocumento.present?
                   @personasimagen = Personasimagen.new
                   @personasimagen.persona_id = persona.id
                   @personasimagen.user_id = is_admin
                   @personasimagen.portafolio_id = 10031
                   @personasimagen.portafoliostiposdocumento_id = tipodocumento.id
                   @personasimagen.descripcion = nombre_documento
                   @personasimagen.persona = file
                   @personasimagen.personasobligacion_id = personasobligacion.id
                   @personasimagen.save
                   file.close
                   if @personasimagen.id.to_i > 0
                     File.delete(file)
                   end
                   logger.error("LISTO ...................." + nombre_documento.to_s)
                 end
               else
                 logger.error("No existe .." + nombre_documento.to_s)
               end
             end
    end
    redirect_to root_path
  end

  private

  def set_layout
    if ['index'].include?(action_name)
      if User.find(is_admin).persona_id.to_s == ""
        "application_admin"
      else
        'application'
      end
    end
  end

end


