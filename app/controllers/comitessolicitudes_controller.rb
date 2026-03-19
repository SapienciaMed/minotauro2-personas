class ComitessolicitudesController < ApplicationController
  before_filter :require_solicitud
  layout :determine_layout

  def index
    comite   = Comite.find(params[:comite_id])
    @comitessolicitudes = comite.comitessolicitudes.all
  end

 def edit
    @comitessolicitud  = Comitessolicitud.find(params[:id], :include => "comite")
    @comite  = @comitessolicitud.comite
    respond_to do |format|
      format.js { render :action => "edit_comitessolicitud" }
    end
  end

  def create
    @comite  = Comite.find(params[:comite_id])
    @comitessolicitud = Comitessolicitud.new(params[:comitessolicitud])
    if @comitessolicitud.valid?
      @comite.comitessolicitudes << @comitessolicitud
      @comite.save
      @comitessolicitud = Comitessolicitud.new
      flash[:comitessolicitud] = "Creado con exito"
    else
      flash[:comitessolicitud] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comitessolicitudes" }
    end
  end

  def update
    @comitessolicitud        = Comitessolicitud.new
    comitessolicitud         = Comitessolicitud.find(params[:id])
    @comite        = comitessolicitud.comite
    ok = comitessolicitud.update_attributes(params[:comitessolicitud])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "comitessolicitudes" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    comitessolicitud   = Comitessolicitud.find(params[:id])
    @comite  = comitessolicitud.comite
    @comitessolicitud  = Comitessolicitud.new
    comitessolicitud.destroy
    flash[:comitessolicitud] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "comitessolicitudes" }
    end
  end
end