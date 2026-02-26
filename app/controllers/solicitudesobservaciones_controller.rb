class SolicitudesobservacionesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    solicitud   = Solicitud.find(params[:solicitud_id])
    #@solicitudesobservaciones = solicitud.solicitudesobservaciones.all
    @solicitudesobservaciones = solicitud.solicitudesobservaciones.find(:all, :conditions => ['solicitud_id = ?', params[:solicitud_id]], :order => 'created_at')
  end

  def edit
    @solicitudesobservacion  = Solicitudesobservacion.find(params[:id], :include => "solicitud")
    @solicitud  = @solicitudesobservacion.solicitud
    respond_to do |format|
      format.js { render :action => "edit_solicitudesobservacion" }
    end
  end

  def create
    @solicitud  = Solicitud.find(params[:solicitud_id])
    @solicitudesobservacion = Solicitudesobservacion.new(params[:solicitudesobservacion])
    @solicitudesobservacion.user_id = is_admin
    if @solicitudesobservacion.valid?
      @solicitud.solicitudesobservaciones << @solicitudesobservacion
      @solicitud.save
      @solicitudesobservacion = Solicitudesobservacion.new
      flash[:solicitudesobservacion] = "Creado con exito"
    else
      flash[:solicitudesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "solicitudesobservaciones" }
    end
  end

  def update
    @solicitudesobservacion        = Solicitudesobservacion.new
    solicitudesobservacion         = Solicitudesobservacion.find(params[:id])
    @solicitud        = solicitudesobservacion.solicitud
    ok = solicitudesobservacion.update_attributes(params[:solicitudesobservacion])
    flash[:solicitudesobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "solicitudesobservaciones" }
    end
  end

  def destroy
    solicitudesobservacion   = Solicitudesobservacion.find(params[:id])
    @solicitud  = solicitudesobservacion.solicitud
    @solicitudesobservacion  = Solicitudesobservacion.new
    solicitudesobservacion.destroy
    flash[:solicitudesobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "solicitudesobservaciones" }
    end
  end

  def atencion
    @solicitudesobservaciones = Solicitudesobservacion.find(params[:id])
  end

  private
  def determine_layout
    if ['atencion'].include?(action_name)
      "atencion"
    else
      "application"
    end
  end
end
