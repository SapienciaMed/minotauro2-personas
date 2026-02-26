class ComitesController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout

  def index
    @comites = Comite.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comites }
    end
  end

  def new
    @comite = Comite.new
    render :action => "comite_form"
  end

  def buscar
    @comites = Comite.search(
      params[:ubicacion][:creainicial],
      params[:ubicacion][:creafinal],
      params[:temas],
      params[:ubicacion][:vencinicial],
      params[:ubicacion][:vencfinal],
      params[:comiteid])
    if @comites.count == 0 and params[:format] != 'xls'
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_comites_path
    elsif @comites.count == 1 and params[:format] != 'xls'
      redirect_to edit_comite_path(@comites)
    else
      respond_to do |format|
        format.html
        format.xls if params[:format] == 'xls'
      end
    end
  end

  def buscarx
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="informecomite_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    @comitesactividades = Comitesactividad.search(
                             params[:ubicacion][:fchinicial],
                             params[:ubicacion][:fchfinal],
                             params[:ubicacion][:estado],
                             params[:ubicacion][:user_asignado],
                             params[:ubicacion][:fchiniciallimite],
                             params[:ubicacion][:fchfinallimite])
    if @comitesactividades.count == 0
      flash[:notice] = "No hay resultados de la busqueda"
      redirect_to busqueda_comites_path
    end
  end
  
  def create
    last_id = Comite.maximum('id')
    begin
      comite = Comite.find(last_id)
      conse = comite.consecutivo.to_i + 1
    rescue
      conse = '1'
    end
    @comite = Comite.new(params[:comite])
    @comite.user_id = is_admin
    @comite.consecutivo = conse
    if @comite.save
      ActiveRecord::Base.connection.execute("insert into comitessolicitudes (id,comite_id,solicitud_id,created_at,updated_at)
                                             select comitessolicitudes_seq.nextval,#{@comite.id},id,sysdate,sysdate
                                             from   solicitudes where estado in ('LISTO PARA COMITE','DEVUELTO')")
=begin
      @solicitudes = Solicitud.find(:all, :conditions=>["estado in ('LISTO PARA COMITE','DEVUELTO')"])
      @solicitudes.each do |solicitud|
        @comitessolicitud = Comitessolicitud.new
        @comitessolicitud.comite_id = @comite.id
        @comitessolicitud.solicitud_id = solicitud.id
        @comitessolicitud.save        
      end
=end
      flash[:notice] = "Comite nro #{@comite.id.to_s} Creado con Exito y solicitudes incluidas exitosamente"
      redirect_to edit_comite_path(@comite)
    else
      flash[:warning] = "Problemas con la creacion del registro."
      render :action => "comite_form"
     end
  end

  def ejecutar
    @comitessolicitudes = Comitessolicitud.find(:all, :conditions=>["comite_id = #{params[:id]}"])
    @comitessolicitudes.each do |comitessolicitud|
      #Eliminacion del detalle de la obligacion
      @solicitud = Solicitud.find(comitessolicitud.solicitud_id)
      if @solicitud.estado == 'APROBADO'
        ActiveRecord::Base.connection.execute("begin prc_sygma_solicitudes(#{@solicitud.id}); end;")

=begin  # 2021-06 FFA: Se traslada funcionamiento al procedimiento prc_sygma_solicitudes
        ActiveRecord::Base.connection.execute("delete from planesobligaciones where personasobligacion_id = #{comitessolicitud.solicitud.personasobligacion_id}")
        #Actualizacion del plazo
        #ActiveRecord::Base.connection.execute("update personasobligaciones set plazo = #{comitessolicitud.solicitud.sim_plazo}
#                                               where id = #{comitessolicitud.solicitud.personasobligacion_id}")
        # 2014-11-08 Se actualiza el proceso original agregando el valor de otros si el origen de la solicitud es una reestructuracion
        ActiveRecord::Base.connection.execute("update personasobligaciones set plazo = #{comitessolicitud.solicitud.sim_plazo},
                                                                               reestruc_vlr_otros = nvl(#{comitessolicitud.solicitud.sim_otros rescue 0},0),
                                                                               reestruc_vlr_otros_ori = nvl(#{comitessolicitud.solicitud.sim_otros rescue 0},0),
                                                                               valor = nvl(#{comitessolicitud.solicitud.sim_saldocapital rescue 0},0),
                                                                               fch_reestructuracion = sysdate,
                                                                               fch_ult_pago = null
                                               where id = #{comitessolicitud.solicitud.personasobligacion_id}")
        if @solicitud.propuesta.to_s == 'CONGELAMIENTO OBLIGACION'
          ActiveRecord::Base.connection.execute("update personasobligaciones set fch_reinicio = '#{comitessolicitud.solicitud.fch_reinicio}'
                                                 where  id = #{comitessolicitud.solicitud.personasobligacion_id}")
        end
        #Crear plan de pagos...
        #Crea la obligacion
        ActiveRecord::Base.connection.execute("begin prc_obligacion(#{comitessolicitud.solicitud.personasobligacion_id.to_i}); end;")
=end
      end
    end
    ActiveRecord::Base.connection.execute("update comites set proceso = 'SI' where id = #{params[:id]}")
    #inicia proceso de creacion de gestiones
    @comitessolicitudes = Comitessolicitud.find(:all, :conditions=>["comite_id = #{params[:id]}"])
    @comitessolicitudes.each do |comitessolicitud|
      personasobservacion = Personasobservacion.new
      personasobservacion.persona_id = comitessolicitud.solicitud.persona_id
      personasobservacion.user_id = comitessolicitud.solicitud.user_id
      personasobservacion.tipo = 'CORREO FISICO'
      personasobservacion.tiposestado_id = 3
      personasobservacion.observacion = "SE PRESENTO AL COMITE DE CARTERA LA SOLICITUD FORMULADA POR EL DEUDOR, EL COMITE HA "+comitessolicitud.solicitud.estado.to_s+" Y SE REMITE COMUNICACION FORMAL CON LA DECISION DEL COMITE AL DEUDOR."
      personasobservacion.situacion_econo = comitessolicitud.solicitud.situacion_econo
      personasobservacion.situacion_bene = comitessolicitud.solicitud.situacion_bene
      personasobservacion.created_at = comitessolicitud.comite.created_at
      personasobservacion.updated_at = comitessolicitud.comite.updated_at
      personasobservacion.save
    end
    flash[:notice] = ".... Planes de pago actualizados con exito"
    redirect_to edit_comite_path(params[:id])    
  end

  def aprobarmasiva
    comiteId = params[:id]
    ActiveRecord::Base.connection.execute("begin prc_sygma_comitessol(#{comiteId},#{is_admin}); end;")
    flash[:notice] = "Solicitudes aprobadas con exito"
    redirect_to edit_comite_path(params[:id])
  end

  def cargagestiones
    #inicia proceso de creacion de gestiones
    @comitessolicitudes = Comitessolicitud.find(:all)
    @comitessolicitudes.each do |comitessolicitud|
      personasobservacion = Personasobservacion.new
      personasobservacion.persona_id = comitessolicitud.solicitud.persona_id
      personasobservacion.user_id = comitessolicitud.solicitud.user_id
      personasobservacion.tipo = 'CORREO FISICO'
      personasobservacion.tiposestado_id = 3
      personasobservacion.observacion = "SE PRESENTO AL COMITE DE CARTERA LA SOLICITUD FORMULADA POR EL DEUDOR, EL COMITE HA "+comitessolicitud.solicitud.estado.to_s+" Y SE REMITE COMUNICACION FORMAL CON LA DECISION DEL COMITE AL DEUDOR."
      personasobservacion.situacion_econo = comitessolicitud.solicitud.situacion_econo
      personasobservacion.situacion_bene = comitessolicitud.solicitud.situacion_bene
      personasobservacion.created_at = comitessolicitud.comite.created_at
      personasobservacion.updated_at = comitessolicitud.comite.updated_at
      personasobservacion.save
    end
    flash[:notice] = "MAGO.... Observaciones listas"
    redirect_to menus_path
  end

  def show
    @comite = Comite.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comite }
    end
  end

  def visualizar
    @comite = Comite.find(params[:id])
  end

   def cartam
     @comite = Comite.find(params[:id])
     #@personasobligaciones = Personasobligacion.find(:all, :conditions=>["persona_id in (select id from personas where radicado is not null)"])
  end

  def visualizarconsejo
    @comite = Comite.find(params[:id])
  end

  def edit
    @comite = Comite.find(params[:id])
    @comitesobservacion = Comitesobservacion.new
    @comitesuser = Comitesuser.new
    @comitesimagen = Comitesimagen.new
    respond_to do |format|
      format.html { render :action => "comite_form" }
    end
  end

  def update
    @procesoact = ""
    @comite = Comite.find(params[:id])
    if params[:comite][:radicado_inicial].to_i > 0 and params[:comite][:radicado_final].to_i > 0
      @procesoact = 'SI'
      @inicial = params[:comite][:radicado_inicial].to_i
      @final = params[:comite][:radicado_final].to_i
    end
    if @comite.update_attributes(params[:comite])
      flash[:notice] = "Comite actualizado correctamente."
      if @procesoact == 'SI'
        @i = @inicial
        for comitessolicitud in @comite.comitessolicitudes.find(:all, :conditions=>["solicitud_id in (select id from solicitudes where estado in ('NEGADO','APROBADO'))"], :order => 'id DESC')
          if @i <= @final
            comitessolicitud.radicado = @i.to_i
            comitessolicitud.save
            @i = @i+1
          end
        end
      end
      redirect_to edit_comite_path(@comite)
    else
      @comitesobservacion = Comitesobservacion.new
      @comitesuser = Comitesuser.new
      @comitesimagen = Comitesimagen.new
      render :action => "comite_form"
    end
#    rescue
#    redirect_to edit_comite_path(@comite)
  end

 def enviomensaje
    @comite = Comite.find(params[:id])
    Comite.mensaje(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def enviomensajeconsejo
    @comite = Comite.find(params[:id])
    Comite.mensajeconsejo(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito al Consejo via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def enviomensajejefe
    @comite = Comite.find(params[:id])
    Comite.mensajejefe(@comite)
    flash[:notice] = "La informacion ha sido enviada con Exito via Electronica."
    redirect_to edit_comite_path(@comite)
  end

  def notificacionactrealizada
    # Inicia el proceso marcando como enviadas las Notificaciones
    ActiveRecord::Base.connection.execute("update comitesactividades set fechaenvio = curdate(),envioinformacion = 'SI' where envioinformacion is null and act_realizada = 'SI'")
    # Continua con el envio acumulado de la informacion no revisada
    @comites = Comite.all(:select => "distinct(user_responsable)", :conditions =>[" id in (select distinct comite_id from comitesactividades where envioinformacion is not null and estado not in ('SI REALIZADA','DESACTIVADA'))"])
    @comites.each do |comite|
      Comite.notifica(comite)
    end
    flash[:notice] = "Notificaciones Enviadas con Exito"
    redirect_to busqueda_comites_path
  end

  private
  def determine_layout
    if ['buscarx','cartam'].include?(action_name)
      "informes"
    elsif ['visualizar','visualizarconsejo'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end