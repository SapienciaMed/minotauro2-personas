class PlanesobligacionesController < ApplicationController
  before_filter :require_user

  def detalle
    @planesobligaciones = Planesobligacion.find(:all, :conditions=>["personasobligacion_id = #{params[:id]}"], :order=>"nro_cuota asc")
    @personasobligacion = Personasobligacion.find(params[:id])
    @planesobligacion = Planesobligacion.new
  end

  def edit
    @planesobligacion  = Planesobligacion.find(params[:id], :include => "personasobligacion")
    @personasobligacion  = @planesobligacion.personasobligacion
    respond_to do |format|
      format.js { render :action => "edit_planesobligacion" }
    end
  end

  def visualizar
    @planesobligacion  = Planesobligacion.find(params[:id])
  end

  def update
    @planesobligacion        = Planesobligacion.new
    planesobligacion         = Planesobligacion.find(params[:id])
    @personasobligacion        = planesobligacion.personasobligacion
    ok = planesobligacion.update_attributes(params[:planesobligacion])
    if ok == true
      ActiveRecord::Base.connection.execute("begin prc_planflexible(#{planesobligacion.personasobligacion_id}, #{planesobligacion.nro_cuota.to_i}); end;")
      flash[:planesobligacion] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "planesobligaciones" }
      end
    else
      flash[:planesobligacion] = "Se produjo un error al guardar el registro"
      render :update do |page|
        page.alert "ATENCIÓN: Modificación no permitida. Revisar el nro de cuotas contemplado"
      end
    end
  end

end
