class TiposcontrolesController < ApplicationController
  before_filter :require_user

  def index
    @tiposcontroles = Tiposcontrol.find(:all, :order=>"descripcion")
  end

  def new
    @tiposcontrol = Tiposcontrol.new
    render :action => "tiposcontrol_form"
  end

  def edit
    @tiposcontrol = Tiposcontrol.find(params[:id])
    respond_to do |format|
      format.html { render :action => "tiposcontrol_form" }
    end
  end

  def create
    @tiposcontrol = Tiposcontrol.new(params[:tiposcontrol])
    if @tiposcontrol.save
      flash[:notice] = "Creado con Exito."
      redirect_to edit_tiposcontrol_path(@tiposcontrol)
    else
      render :action => "tiposcontrol_form"
     end
  end

  def update
    @tiposcontrol = Tiposcontrol.find(params[:id])
    if @tiposcontrol.update_attributes(params[:tiposcontrol])
     flash[:notice] = "Actualizado con Exito."
      redirect_to edit_tiposcontrol_path(@tiposcontrol)
    else
      render :action => "tiposcontrol_form"
    end
  end

  def destroy
    @tiposcontrol = Tiposcontrol.find(params[:id])
    @tiposcontrol.destroy
    respond_to do |format|
      format.html { redirect_to(tiposcontroles_url) }
      format.xml  { head :ok }
    end
  end

end
