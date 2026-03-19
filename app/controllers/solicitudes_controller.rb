class SolicitudesController < ApplicationController
  before_action :set_solicitud, only: [:show, :index, :destroy], except: [:ver, :prepara, :extinguir, :preparaa, :anulacion, :cambiotipopago]
  layout :determine_layout

  def index
    @solicitudes = Solicitud.search(params[:search],params[:searchn],params[:search0], params[:page])
    if @solicitudes.count == 0
      #flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @solicitudes }
      end
    elsif @solicitudes.count == 1
      #flash[:notice] = "Dato localizado"
      redirect_to :controller=>"solicitudes", :action=>"edit", :id=>@solicitudes, :etapa=>"A"
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @solicitudes }
      end
    end
  end

  def new
    @solicitud = Solicitud.new
    @personasobligacion = Personasobligacion.find(params[:id])
    @solicitud.personasobligacion_id = @personasobligacion.id
    @solicitud.persona_id = @personasobligacion.persona_id
    @solicitud.propuesta = params[:propuesta].to_s
    render :action => "solicitud_form"
  end

  def visualizar
    @solicitud = Solicitud.find(params[:id])
    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)
    fname = "SolicitudNro_" + @solicitud.id.to_s + '_NroObl_' + @personasobligacion.nro_obligacion.to_s + '_' + @personasobligacion.persona.identificacion
    respond_to do |format|
      format.pdf {render pdf: "#{fname}", template: "solicitudes/visualizar.html.erb", encoding: "UTF-8", page_size: 'Letter',:margin => {top: 15, :bottom => 20, :left => 15,:right => 15}}
    end
  end

  def activar
    @solicitud = Solicitud.find(params[:id])
    ActiveRecord::Base.connection.execute("update solicitudes set estado = 'LISTO PARA COMITE' where id = #{@solicitud.id}")
    redirect_to edit_persona_path(@solicitud.persona_id)
  end

  def update2
    @solicitud = Solicitud.find(params[:id])
    @conse1 = params[:conse1].to_i
    if @solicitud.update_attributes(params[:solicitud])
      flash[:notice] = "Solicitud realizada con Exito."
      redirect_to :controller=>"solicitudes", :action=>"visualizarcomite", :id=>@solicitud.id, :consecutivo1 =>@conse1
    else
      redirect_to :controller=>"solicitudes", :action=>"visualizarcomite", :id=>@solicitud.id, :consecutivo1 =>@conse1
    end
    #rescue
     # redirect_to :controller=>"solicitudes", :action=>"visualizarcomite", :id=>@solicitud.id, :consecutivo1 =>@conse1
  end


  def visualizarcomite
    @solicitud = Solicitud.find(params[:id])
    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)
    if params[:consecutivo].to_i > 0
      @conse = params[:consecutivo].to_i + 1
      if Comitessolicitud.exists?(["id = #{@conse}"]) == true
        @conse1 = @conse
      else
        @conse1 = 0
      end
    elsif params[:consecutivo1].to_i > 0
      @conse = params[:consecutivo1].to_i
      if Comitessolicitud.exists?(["id = #{@conse}"]) == true
        @conse1 = @conse
      else
        @conse1 = 0
      end
    end
  end

  def edit
    @solicitud = Solicitud.find(params[:id])
    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)
    @solicitudesobservacion = Solicitudesobservacion.new
    respond_to do |format|
      format.html { render :action => "solicitud_form" }
    end
  end

  def actdatos
    @solicitud = Solicitud.find(453)
    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)
    @solicitud.cuota = @personasobligacion.vlrcuota rescue nil
    @solicitud.saldocapital = @personasobligacion.saldocapital rescue nil
    @solicitud.totalinteres = @personasobligacion.totalcorriente rescue nil
    @solicitud.totalpagar = @personasobligacion.saldototalsimulador rescue nil
    @solicitud.plazo = @personasobligacion.obplazo rescue nil
    if @solicitud.propuesta == 'REESTRUCTURACION'
      @solicitud.ori_saldootros = @personasobligacion.saldootros rescue nil
    else
      @solicitud.ori_saldootros = @personasobligacion.saldototalotros rescue nil
    end
    @solicitud.save
    redirect_to menus_path
  end

  def create
    @solicitud = Solicitud.new(params[:solicitud])
    @solicitud.user_id = is_admin
    @solicitud.estado = 'RADICADA'

    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)

    @solicitud.cuota = @personasobligacion.vlrcuota rescue nil
    @solicitud.saldocapital = @personasobligacion.saldocapital rescue nil
    @solicitud.totalinteres = @personasobligacion.totalcorriente rescue nil
    @solicitud.totalpagar = @personasobligacion.saldototalsimulador rescue nil
    @solicitud.plazo = @personasobligacion.obplazo rescue nil

    @solicitud.personasobligacion_id = @personasobligacion.id
    @solicitud.persona_id = @personasobligacion.persona_id

    @solicitud.tasa_ipc = @personasobligacion.tasa_ipc
    @solicitud.tasa_puntos = @personasobligacion.tasa_puntos
    @solicitud.tasa_final = @personasobligacion.tasa_final

    #@solicitud.historicostasa_id = @personasobligacion.historicostasa_id
    @solicitud.mescuota = is_fechahoy.strftime("%m-%Y").to_s

    @solicitud.ori_diasvencoblig = @personasobligacion.diasvencoblig rescue nil
    @solicitud.ori_calificacion = @personasobligacion.calificacion rescue nil
    @solicitud.ori_valor = @personasobligacion.valor rescue nil
    @solicitud.ori_fch_ult_pago = @personasobligacion.fch_ult_pago rescue nil
    @solicitud.ori_valortotalrecaudo = @personasobligacion.planesrecaudos.sum("valor").to_i rescue nil
    @solicitud.ori_saldocapitalvencido = @personasobligacion.saldocapitalvencido rescue nil
    @solicitud.ori_saldointerescorriente = @personasobligacion.saldointerescorriente rescue nil    
    if @solicitud.propuesta == 'REESTRUCTURACION'
      @solicitud.ori_saldootros = @personasobligacion.saldootros rescue nil
    else
      @solicitud.ori_saldootros = @personasobligacion.saldototalotros rescue nil
    end
    @solicitud.ori_saldootros = @personasobligacion.saldootros rescue nil
    @solicitud.ori_saldointeresmora = @personasobligacion.saldointeresmora rescue nil
    @solicitud.ori_totalvencido = @personasobligacion.totalvencido rescue nil
    @solicitud.ori_vlrcuota = @personasobligacion.vlrcuota rescue nil
    @solicitud.ori_vlrcuotaminimo = @personasobligacion.vlrcuota.to_i + @personasobligacion.totalvencido.to_i rescue nil
    @solicitud.ori_capitalporpagar = @personasobligacion.capitalporpagar rescue nil
    @solicitud.ori_saldototaldeuda = @personasobligacion.saldototaldeuda rescue nil
    @solicitud.ori_obplazo = @personasobligacion.obplazo rescue nil
    @solicitud.ori_obaltura = @personasobligacion.obaltura rescue nil
    @solicitud.ori_obcuotaspagadas = @personasobligacion.obcuotaspagadas rescue nil
    @solicitud.ori_obcuotasmora = @personasobligacion.obcuotasmora rescue nil
    @solicitud.ori_obcuotasporpagar = @personasobligacion.obcuotasporpagar rescue nil
    @solicitud.ori_estadoobli = @personasobligacion.estadoobli rescue nil

    @solicitud.sim_cuota = @personasobligacion.vlrcuotasimulacion rescue nil
    @solicitud.sim_saldocapital = @personasobligacion.saldocapital rescue nil
    @solicitud.sim_totalinteres = @personasobligacion.totalcorrientesimulacion rescue nil
    @solicitud.sim_totalpagar = (@personasobligacion.saldocapital.to_i + @personasobligacion.totalcorrientesimulacion.to_i + @personasobligacion.totalotrossimulacion.to_i) rescue nil
    @solicitud.sim_plazo = @personasobligacion.obplazosimulacion rescue nil
    @solicitud.sim_otros = @personasobligacion.totalotrossimulacion rescue nil

    if @solicitud.save
      flash[:notice] = "Solicitud Creada con Exito."
      ActiveRecord::Base.connection.execute("begin prc_sygma_solicitudes(#{@solicitud.id}); end;")
      redirect_to edit_solicitud_path(@solicitud)
    else
      @solicitudesobservacion = Solicitudesobservacion.new
      render :action => "solicitud_form"
     end
  end

  def updatedatos
    @solicitud = Solicitud.find(params[:id])
    @personasobligacion = Personasobligacion.find(@solicitud.personasobligacion_id)
    @solicitud.personasobligacion_id = @personasobligacion.id
    @solicitud.persona_id = @personasobligacion.persona_id
    @solicitud.tasa_ipc = @personasobligacion.tasa_ipc
    @solicitud.tasa_puntos = @personasobligacion.tasa_puntos
    @solicitud.tasa_final = @personasobligacion.tasa_final
    #@solicitud.historicostasa_id = @personasobligacion.historicostasa_id
    @solicitud.mescuota = is_fechahoy.strftime("%m-%Y").to_s
    @solicitud.ori_diasvencoblig = @personasobligacion.diasvencoblig rescue nil
    @solicitud.ori_calificacion = @personasobligacion.calificacion rescue nil
    @solicitud.ori_valor = @personasobligacion.valor rescue nil
    @solicitud.ori_fch_ult_pago = @personasobligacion.fch_ult_pago rescue nil
    @solicitud.ori_valortotalrecaudo = @personasobligacion.planesrecaudos.sum("valor").to_i rescue nil
    @solicitud.ori_saldocapitalvencido = @personasobligacion.saldocapitalvencido rescue nil
    @solicitud.ori_saldointerescorriente = @personasobligacion.saldointerescorriente rescue nil
    @solicitud.ori_saldootros = @personasobligacion.saldootros rescue nil
    @solicitud.ori_saldointeresmora = @personasobligacion.saldointeresmora rescue nil
    @solicitud.ori_totalvencido = @personasobligacion.totalvencido rescue nil
    @solicitud.ori_vlrcuota = @personasobligacion.vlrcuota rescue nil
    @solicitud.ori_vlrcuotaminimo = @personasobligacion.vlrcuota.to_i + @personasobligacion.totalvencido.to_i rescue nil
    @solicitud.ori_capitalporpagar = @personasobligacion.capitalporpagar rescue nil
    @solicitud.ori_saldototaldeuda = @personasobligacion.saldototaldeuda rescue nil
    @solicitud.ori_obplazo = @personasobligacion.obplazo rescue nil
    @solicitud.ori_obaltura = @personasobligacion.obaltura rescue nil
    @solicitud.ori_obcuotaspagadas = @personasobligacion.obcuotaspagadas rescue nil
    @solicitud.ori_obcuotasmora = @personasobligacion.obcuotasmora rescue nil
    @solicitud.ori_obcuotasporpagar = @personasobligacion.obcuotasporpagar rescue nil
    @solicitud.ori_estadoobli = @personasobligacion.estadoobli rescue nil
    if @solicitud.propuesta == 'REESTRUCTURACION'
      ActiveRecord::Base.connection.execute("begin prc_obligacionreestructuracion('#{@personasobligacion.id}','#{@personasobligacion.saldocapitalreestruc}','#{@personasobligacion.saldootrosrreestruc}','#{@solicitud.sim_plazo.to_i}'); end;")
      @solicitud.sim_cuota = @personasobligacion.vlrcuotasimulacion rescue nil
      @solicitud.sim_saldocapital = @personasobligacion.saldocapital rescue nil
      @solicitud.sim_totalinteres = @personasobligacion.totalcorrientesimulacion rescue nil
      @solicitud.sim_totalpagar = (@personasobligacion.saldocapital.to_i + @personasobligacion.totalcorrientesimulacion.to_i + @personasobligacion.totalotrossimulacion.to_i) rescue nil
      @solicitud.sim_otros = @personasobligacion.totalotrossimulacion rescue nil
    end
    @solicitud.save
    flash[:notice] = "Solicitud reevaluada con exito"
    redirect_to edit_solicitud_path(@solicitud)    
  end

  def update
    @solicitud = Solicitud.find(params[:id])
    if permiso("solicitudjuridico","C").to_s == "S"
      if params[:solicitud][:concepto_juridico].to_s != ""
        params[:solicitud][:user_juridico] = is_admin
        params[:solicitud][:fecha_juridico] = Time.now
        params[:solicitud][:estado] = 'LISTO PARA COMITE'
      end
    end
    params[:solicitud][:user_actualiza] = is_admin
    if @solicitud.update_attributes(params[:solicitud])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_solicitud_path(@solicitud)
    else
      flash[:warning] = "Problemas---"
      @solicitudesobservacion = Solicitudesobservacion.new
      render :action => "solicitud_form"
    end
  end

  def destroy
    @solicitud = Solicitud.find(params[:id])
    personaid = @solicitud.persona_id
    @solicitud.destroy
    respond_to do |format|
      format.html { redirect_to :controller=>"personas", :action=>"edit", :id =>personaid }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['visualizar','visualizarcomite','cartam'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
