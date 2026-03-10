class PlanesrecaudosController < ApplicationController
  before_action :set_planesrecaudo, only: [:show, :index, :destroy], except: [:ver, :prepara, :extinguir, :preparaa, :anulacion, :cambiotipopago]
  layout :determine_layout

  #before_action :checkaccess, if: :user_signed_in?

  #def checkaccess
  #  return is_permit('personas')
  #end

  def show_detalle
    @ruta = params[:ruta]
    @planesrecaudo = Planesrecaudo.find(params[:id])
  end

  def index
    @persona = @personasobligacion.persona
    @planesrecaudos = Planesrecaudo.select("planesrecaudos.*,
                                            (select distinct 'X' from planesrespaldos where planesrecaudo_id = planesrecaudos.id) existeresp,
                                            (select distinct 'X' from planesrecaudosdetalles where planesrecaudo_id = planesrecaudos.id and valor_aplicado > 0) existeapl,
                                            '' existetanque,
                                            '' existedoc,
                                            '' existehono,
                                            '' tanqueidf,
                                            '' tanquemasidf,
                                            '' existeajuste,
                                            '' nombreorigenpago,
                                            (select nombre from users where id = planesrecaudos.user_id) nombreusers
                                            ")
                                  .includes([:personasobligacion,:user])
                                  .where("personasobligacion_id = #{@personasobligacion.id}").order('fecha_recaudo DESC, id DESC')
    @planesobligaciones = @personasobligacion.planesobligaciones.select("planesobligaciones.*, 
        '' comodin, 
        (select max(r.fecha_recaudo)
        from   planesrecaudos r, planesrecaudosdetalles d
        where  r.personasobligacion_id = planesobligaciones.personasobligacion_id
        and    r.id = d.planesrecaudo_id
        and    d.tipo = 'CAPITAL CUOTA '||planesobligaciones.nro_cuota) - planesobligaciones.fecha_vence cp").order("nro_cuota asc")
    #@planeshobligaciones = @personasobligacion.planeshobligaciones.order("nro_cuota asc")
    #@personasoblgastos = @personasobligacion.personasoblgastos.order("fecha desc")
    #@personasoblcontables = @personasobligacion.personasoblcontables.order("fecha asc")
    #@gastosporanno = Personasprogasto.where("personasobligacion_id = #{params[:personasobligacion_id]} and estado not in ('NO APROBADO','RECHAZADO REEMBOLSO/GIRO','RECHAZADO')").select("to_char(fecha_autolega,'YYYY') anno, unidad_denominacion, count(9) cant, sum(valor) valortotal").group("to_char(fecha_autolega,'YYYY'),unidad_denominacion").order("to_char(fecha_autolega,'YYYY') desc") rescue nil
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    respond_to { |format| format.js }
  end

  def ver
    @planesrecaudo = Planesrecaudo.find(params[:id])
  end

  def veraplicacion
    @planesrecaudo = Planesrecaudo.find(params[:id])
  end

  def verliquidacion
    @planesrecaudo = Planesrecaudo.find(params[:id])
    @centrosliquidacion = Centrosliquidacion.find_by(planesrecaudo_id: @planesrecaudo.id, estado: 'PAGADO')
    @personasobligacion = @planesrecaudo.personasobligacion
  end

  def prepara
    @personasobligacion = Personasobligacion.find(params[:id])
  end

  def preparaajuste
    @personasobligacion = Personasobligacion.find(params[:id])
    @ajustes = Planesrecaudosdetalle.where(["tipo in ('SFC','FAVOR','CAPITAL SFC') and planesrecaudo_id in (select id from planesrecaudos where personasobligacion_id = #{@personasobligacion.id})
                                         and planesrecaudo_id not in (select planesrecaudo_id from planesajustesdetalles)"]).sum(:valor_aplicado)
    #@ajustes = Planesrecaudosdetalle.includes(:planesrecaudo).where(:planesrecaudos => { :portafolio_id=>is_portafolio, :personasobligacion_id=>@personasobligacion}, :planesrecaudosdetalles => {:tipo=>"SFC"}).sum("planesrecaudosdetalles.valor_aplicado")
  end

  def ajustar
    personasobligacionid = params[:personasobligacion_id].to_i rescue nil
    fecha = params[:fecha].to_date rescue nil
    obs = params[:observaciones].to_s
    origenid = params[:ubicacion][:origenid] rescue nil
    if origenid.to_s != ""
      idParOrigenesPagoId = origenid.to_i
    else
      idParOrigenesPagoId = -1
    end
    if personasobligacionid and fecha and obs
      ProcesoJob.perform_now("prc_planesajuste('#{personasobligacionid}','#{fecha}','#{is_admin}','#{obs}',#{idParOrigenesPagoId})")
    end
    redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
  end

  def prereversion
    @planesrecaudo = Planesrecaudo.find(params[:id])
    @personasobligacion = @planesrecaudo.personasobligacion
  end

  def reversion
    @planesrecaudo = Planesrecaudo.find(params[:id])
    if params[:observaciones].to_s != ""
      p = Planesreversion.new
      p.planesrecaudo_id = @planesrecaudo.id
      p.personasobligacion_id = @planesrecaudo.personasobligacion_id
      p.user_id = is_admin
      p.observacion_reversion = params[:observaciones].to_s.upcase
      if Planesrespaldo.exists?(planesrecaudo_id: @planesrecaudo.id) == false
        p.tipo = 'REVERSIONPAGONOTESEO'
        if params[:idrecaudoult_teseo].to_i > 0
          p.planesrecaudo_id = params[:idrecaudoult_teseo].to_i
        else
          p.planesrecaudo_id = nil
        end
        p.consecutivo = @planesrecaudo.id
      else
        p.tipo = 'REVERSION'
        p.consecutivo = params[:consecutivo].to_i
      end
      p.estado = 'PENDIENTE'
      p.fecha_recaudo = @planesrecaudo.fecha_recaudo
      p.save
      ProcesoJob.perform_now("prc_teseo_reversar(#{p.id.to_i})")
      flash[:success] = "Proceso de Reversión: Reversado Correctamente"
      redirect_to personasobligacion_planesrecaudos_path(@planesrecaudo.personasobligacion_id)
    else
      flash[:warning] = "Proceso de Reversión: Este proceso requiere de todos los datos registrados"
      redirect_to personasobligacion_planesrecaudos_path(@planesrecaudo.personasobligacion_id)
    end
  end

  def extinguir
    origenid = params[:ubicacion][:origenid] rescue nil
    if origenid.to_s != ""
      idParOrigenesPagoId = params[:ubicacion][:origenid].to_i
    else
      idParOrigenesPagoId = 8
    end
    @ultfecha = Planesrecaudo.where(personasobligacion_id: params[:personasobligacion_id].to_i).last.fecha_recaudo rescue nil
    mes = params[:fecha].to_date.strftime("%m-%Y") rescue nil
    mesac = DateTime.now.strftime("%m-%Y")
    if is_portafolio == 10040
      if params[:fecha].to_s != "" and params[:observaciones].to_s != "" and params[:personasobligacion_id].to_s != ""
        observaciones = params[:observaciones].gsub("'", "")
        ProcesoJob.perform_now("prc_teseoextincion(#{params[:personasobligacion_id].to_i}, '#{params[:fecha]}', '#{observaciones}', #{is_admin}, #{is_portafolio}, #{idParOrigenesPagoId})")
        WsController.revocatoria_individual_vardi(params[:personasobligacion_id].to_i) # Ejecutar el servicio en WsController para enviar la revocatoria a Vardi individual - AFP - 31-Marzo-2022
        flash[:notice] = "El Proceso ha sido realizado con exito"
        redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
      else
        flash[:warning] = "Este proceso requiere de todos los datos registrados"
        redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
      end
    else
      if mes == mesac or is_sygma == true
        if @ultfecha.to_s != ""
          if params[:fecha].to_date < @ultfecha.to_date
            flash[:warning] = "Proceso de Extinción: La fecha no puede ser menor al último recaudo"
            redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
          elsif params[:fecha].to_date > DateTime.now
            flash[:warning] = "Proceso de Extinción: La fecha no puede ser mayor a la actual"
            redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
          else
            observaciones = params[:observaciones].gsub("'", "")
            if params[:fecha].to_s != "" and params[:observaciones].to_s != "" and params[:personasobligacion_id].to_s != ""
              ProcesoJob.perform_now("prc_teseoextincion(#{params[:personasobligacion_id].to_i}, '#{params[:fecha]}', '#{observaciones}', #{is_admin}, #{is_portafolio}, #{idParOrigenesPagoId})")
              flash[:notice] = "El Proceso ha sido realizado con exito"
              redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
            else
              flash[:warning] = "Este proceso requiere de todos los datos registrados"
              redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
            end
          end
        else
          observaciones = params[:observaciones].gsub("'", "")
          if params[:fecha].to_s != "" and params[:observaciones].to_s != "" and params[:personasobligacion_id].to_s != ""
            ProcesoJob.perform_now("prc_teseoextincion(#{params[:personasobligacion_id].to_i}, '#{params[:fecha]}', '#{observaciones}', #{is_admin}, #{is_portafolio}, #{idParOrigenesPagoId})")
            flash[:notice] = "El Proceso ha sido realizado con exito"
            redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
          else
            flash[:warning] = "Este proceso requiere de todos los datos registrados"
            redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
          end
        end
      else
        flash[:warning] = "Proceso de Extinción: El mes no puede ser diferente al actual"
        redirect_to personasobligacion_planesrecaudos_path(params[:personasobligacion_id])
      end
    end
  end

  def preparaa
    @planesrecaudo = Planesrecaudo.find(params[:id])
    @personasobligacion = Personasobligacion.find(@planesrecaudo.personasobligacion_id)
  end

  def anulacion
    if params[:observaciones].to_s != "" and params[:planesrecaudo_id].to_s != ""
      @planesrecaudo = Planesrecaudo.find(params[:planesrecaudo_id])
      personasobligacion_id = @planesrecaudo.personasobligacion_id
      observacionanulacion = params[:observaciones].to_s
      isadmin = is_admin
      ProcesoJob.perform_now("prc_anulacionpago(#{@planesrecaudo.id.to_i},#{isadmin},'#{observacionanulacion.to_s}')")
      flash[:notice] = "El Proceso de Anulación ha sido realizado con exito"
      redirect_to personasobligacion_planesrecaudos_path(personasobligacion_id)
    else
      flash[:warning] = "Proceso de Anulación: Este proceso requiere de todos los datos registrados"
      redirect_to :controller => "planesrecaudos", :action => "preparaa", :id => params[:planesrecaudo_id].to_i
    end
  end

  def new
    if is_auth_c('personasrecaudo')
      @active_record = Planesrecaudo.find(params[:active_id]) if params[:active_id].present?
      @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
      @planesrecaudo = Planesrecaudo.new
      respond_to { |format| format.js }
    end
  end

  def edit
  end

  def create
    if is_auth_c('personasrecaudo')
      @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
      @planesrecaudo = Planesrecaudo.new(planesrecaudo_params)
      @planesrecaudo.user_id = is_admin
      @planesrecaudo.personasobligacion_id = @personasobligacion.id
      ProcesoJob.perform_now("prc_obligacionmoraf_sygma(#{@personasobligacion.id},'#{@planesrecaudo.fecha_recaudo.to_date rescue nil}')")
      respond_to do |format|
        if @planesrecaudo.save
          ProcesoJob.perform_now("prc_planesrecaudos(#{@planesrecaudo.id.to_i})")
          @planesrecaudos = Planesrecaudo.select("planesrecaudos.*,
                                                  (select distinct 'X' from planesrespaldos where planesrecaudo_id = planesrecaudos.id) existeresp,
                                                  (select distinct 'X' from planesrecaudosdetalles where planesrecaudo_id = planesrecaudos.id and valor_aplicado > 0) existeapl,
                                                  '' existetanque,
                                                  '' existedoc,
                                                  '' existehono,
                                                  '' tanqueidf,
                                                  '' tanquemasidf,
                                                  '' existeajuste,
                                                  '' nombreorigenpago,
                                                  (select nombre from users where id = planesrecaudos.user_id) nombreusers
                                                  ")
                                        .includes([:personasobligacion,:user])
                                        .where("personasobligacion_id = #{@personasobligacion.id}").order('fecha_recaudo DESC, id DESC')
          @planesobligaciones = @personasobligacion.planesobligaciones.select("planesobligaciones.*, 
              '' comodin, 
              (select max(r.fecha_recaudo)
              from   planesrecaudos r, planesrecaudosdetalles d
              where  r.personasobligacion_id = planesobligaciones.personasobligacion_id
              and    r.id = d.planesrecaudo_id
              and    d.tipo = 'CAPITAL CUOTA '||planesobligaciones.nro_cuota) - planesobligaciones.fecha_vence cp").order("nro_cuota asc")
          @persona = Persona.find(@personasobligacion.persona_id)
          flash[:notice] = "#{t :notice_crearec_msj}"
          format.js { render inline: "location.reload();" }
        else
          format.js { render 'layouts/errors', locals: { object: @planesrecaudo } }
        end
      end
    else
      flash[:warning] = 'Usted no tiene Acceso a este modulo'
      redirect_to root_path
    end
  end

  def update
    #@planesrecaudo.user_actualiza = is_admin
    respond_to do |format|
      if @planesrecaudo.update(planesrecaudo_params)
        format.html { redirect_to personasobligacion_planesrecaudos_url(@personasobligacion) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    if is_auth_e("personasrecaudo")
      ProcesoJob.perform_now("prc_reversarpago(#{@planesrecaudo.id.to_i})")
      @planesrecaudo.destroy
      ProcesoJob.perform_now("prc_verifica_acuerdo(#{@personasobligacion.id},'#{@planesrecaudo.fecha_recaudo.to_date}',10000,#{is_admin})")
      respond_to do |format|
        format.html { redirect_to personasobligacion_planesrecaudos_path(@personasobligacion) }
        format.xml { head :ok }
      end
    else
      flash[:warning] = 'Usted no tiene Acceso a este modulo'
      redirect_to root_path
    end
  end

  private

  def determine_layout
    if ['ver'].include?(action_name)
      "informes"
    elsif ['veraplicacion'].include?(action_name)
      "blank"
    else
      "application_admin"
    end
  end

  def planesrecaudo_params
    params.require(:planesrecaudo).permit!
  end

  def set_planesrecaudo
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @planesrecaudo = Planesrecaudo.find(params[:id]) if params[:id]
  end
end
