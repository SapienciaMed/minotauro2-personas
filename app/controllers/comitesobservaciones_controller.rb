class ComitesobservacionesController < ApplicationController
  before_filter :require_user

  layout :determine_layout

  def index
    comite   = Comite.find(params[:comite_id])
    #@comitesobservaciones = comite.comitesobservaciones.all
    @comitesobservaciones = comite.comitesobservaciones.find(:all, :conditions => ['comite_id = ?', params[:comite_id]], :order => 'created_at')
  end

  def edit
    @comitesobservacion  = Comitesobservacion.find(params[:id], :include => "comite")
    @comite  = @comitesobservacion.comite
    respond_to do |format|
      format.js { render :action => "edit_comitesobservacion" }
    end
  end

  def create
    @comite  = Comite.find(params[:comite_id])
    @comitesobservacion = Comitesobservacion.new(params[:comitesobservacion])
    @comitesobservacion.user_id = is_admin
    if @comitesobservacion.valid?
      @comite.comitesobservaciones << @comitesobservacion
      @comite.save
      @comitesobservacion = Comitesobservacion.new
      flash[:comitesobservacion] = "Creado con exito"
    else
      flash[:comitesobservacion] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comitesobservaciones" }
    end
  end

  def update
    @comitesobservacion        = Comitesobservacion.new
    comitesobservacion         = Comitesobservacion.find(params[:id])
    @comite        = comitesobservacion.comite
    ok = comitesobservacion.update_attributes(params[:comitesobservacion])
    flash[:comitesobservacion] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "comitesobservaciones" }
    end
  end

  def destroy
    comitesobservacion   = Comitesobservacion.find(params[:id])
    @comite  = comitesobservacion.comite
    @comitesobservacion  = Comitesobservacion.new
    comitesobservacion.destroy
    flash[:comitesobservacion] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "comitesobservaciones" }
    end
  end

  def atencion
    @comitesobservaciones = Comitesobservacion.find(params[:id])
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
