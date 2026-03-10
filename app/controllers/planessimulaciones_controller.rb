class PlanessimulacionesController < ApplicationController
  #before_action :set_planessimulacion, only: [:show, :index, :destroy]
  layout :determine_layout

  def detalle
    @planessimulaciones = Planessimulacion.where(personasobligacion_id: params[:id]).order("nro_cuota asc")
    @personasobligacion = Personasobligacion.find(params[:id])
  end

  def index
    @reestructuacion = params[:reestructuacion]
    @personasobligacion = Personasobligacion.find(params[:id])
    if @reestructuacion.to_s == ""
      if params[:plazo].to_i > 0 and params[:plazo].to_i <= 120
        ActiveRecord::Base.connection.execute("begin prc_obligacionsimulacion('#{@personasobligacion.id.to_i}','#{@personasobligacion.saldocapital}','#{@personasobligacion.saldootrosrreestruc}','#{params[:plazo].to_i}'); end;")
      else
        ActiveRecord::Base.connection.execute("delete from planessimulaciones where personasobligacion_id =#{@personasobligacion.id} ")
      end
    elsif @reestructuacion.to_s == "SI"
      if params[:plazo].to_i > 0 and params[:plazo].to_i <= 120
        ActiveRecord::Base.connection.execute("begin prc_obligacionreestructuracion('#{@personasobligacion.id.to_i}','#{@personasobligacion.saldocapitalreestruc}','#{@personasobligacion.saldootrosrreestruc}','#{params[:plazo].to_i}'); end;")
      else
        ActiveRecord::Base.connection.execute("delete from planessimulaciones where personasobligacion_id =#{@personasobligacion.id} ")
      end
    end
    @planessimulaciones = Planessimulacion.where(["personasobligacion_id = #{@personasobligacion.id}"]).order("nro_cuota")
    if params[:plazo].to_i > 120
      flash[:warning] = "El plazo maximo es de 120 Cuotas"
    end
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def restruct
    @solicitudes = Solicitud.where(["estado not in ('APROBADO','NEGADO')"])
    @solicitudes.each do |solicitud|
      personasobligacion = Personasobligacion.find(solicitud.personasobligacion_id)
      if solicitud.sim_plazo.to_i > 0
        ActiveRecord::Base.connection.execute("begin prc_obligacionreestructuracion('#{personasobligacion.id}','#{personasobligacion.saldocapitalreestruc}','#{personasobligacion.saldootrosrreestruc}','#{solicitud.sim_plazo.to_i}'); end;")
        #logger.error("Simulacion Finalizo")
        @personasobligacion = Personasobligacion.find(solicitud.personasobligacion_id)
        #logger.error("Simulacion Finalizo..."+@personasobligacion.totalotrossimulacion.to_s)
        solicitud.mescuota = is_fechahoy.strftime("%m-%Y").to_s
        solicitud.ori_diasvencoblig = @personasobligacion.diasvencoblig rescue nil
        solicitud.ori_calificacion = @personasobligacion.calificacion rescue nil
        solicitud.ori_valor = @personasobligacion.valor rescue nil
        solicitud.ori_fch_ult_pago = @personasobligacion.fch_ult_pago rescue nil
        solicitud.ori_valortotalrecaudo = @personasobligacion.planesrecaudos.sum("valor").to_i rescue nil
        solicitud.ori_saldocapitalvencido = @personasobligacion.saldocapitalvencido rescue nil
        solicitud.ori_saldointerescorriente = @personasobligacion.saldointerescorriente rescue nil
        if solicitud.propuesta == 'REESTRUCTURACION' or solicitud.propuesta == 'CONGELAMIENTO OBLIGACION'
          solicitud.ori_saldootros = @personasobligacion.saldootros rescue nil
        else
          solicitud.ori_saldootros = @personasobligacion.saldototalotros rescue nil
        end
        solicitud.ori_saldointeresmora = @personasobligacion.saldointeresmora rescue nil
        solicitud.ori_totalvencido = @personasobligacion.totalvencido rescue nil
        solicitud.ori_vlrcuota = @personasobligacion.vlrcuota rescue nil
        solicitud.ori_vlrcuotaminimo = @personasobligacion.vlrcuota.to_i + @personasobligacion.totalvencido.to_i rescue nil
        solicitud.ori_capitalporpagar = @personasobligacion.capitalporpagar rescue nil
        solicitud.ori_saldototaldeuda = @personasobligacion.saldototaldeuda rescue nil
        solicitud.ori_obplazo = @personasobligacion.obplazo rescue nil
        solicitud.ori_obaltura = @personasobligacion.obaltura rescue nil
        solicitud.ori_obcuotaspagadas = @personasobligacion.obcuotaspagadas rescue nil
        solicitud.ori_obcuotasmora = @personasobligacion.obcuotasmora rescue nil
        solicitud.ori_obcuotasporpagar = @personasobligacion.obcuotasporpagar rescue nil
        solicitud.ori_estadoobli = @personasobligacion.estadoobli rescue nil
        solicitud.sim_cuota = @personasobligacion.vlrcuotasimulacion rescue nil
        solicitud.sim_saldocapital = @personasobligacion.saldocapital rescue nil
        solicitud.sim_totalinteres = @personasobligacion.totalcorrientesimulacion rescue nil
        solicitud.sim_totalpagar = (@personasobligacion.saldocapital.to_i + @personasobligacion.totalcorrientesimulacion.to_i + @personasobligacion.totalotrossimulacion.to_i) rescue nil
        solicitud.sim_plazo = @personasobligacion.obplazosimulacion rescue nil
        solicitud.sim_otros = @personasobligacion.totalotrossimulacion rescue nil
        solicitud.save
      end
    end
    flash[:notice] = 'Reestructuraciones actualizadas con exito'
    redirect_to comites_path
  end

  private

  def determine_layout
    if ['imprimir'].include?(action_name)
      "informes"
    else
      "iframe"
    end
  end

  def planessimulacion_params
    params.require(:planessimulacion).permit!
  end

  def set_planessimulacion
    @planessimulacion = Planessimulacion.find(params[:id]) if params[:id]
  end

end
