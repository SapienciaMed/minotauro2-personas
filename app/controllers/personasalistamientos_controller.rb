class PersonasalistamientosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
  end

  def new
    @personasalistamiento = Personasalistamiento.new
    @personasalistamiento.persona_id = params[:id]
    render :action => "personasalistamiento_form"
  end

  def edit
    @personasalistamiento = Personasalistamiento.find(params[:id])
    @personasalisbien = Personasalisbien.new
    @personasalislaboral = Personasalislaboral.new
    @personasalisasociado = Personasalisasociado.new
    respond_to do |format|
      format.html { render :action => "personasalistamiento_form" }
    end
  end

  def create
    @personasalistamiento = Personasalistamiento.new(params[:personasalistamiento])
    if @personasalistamiento.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_personasalistamiento_path(@personasalistamiento)
    else
      @personasalisbien = Personasalisbien.new
      @personasalislaboral = Personasalislaboral.new
      @personasalisasociado = Personasalisasociado.new
      render :action => "personasalistamiento_form"
     end
  end

  def update
    @personasalistamiento = Personasalistamiento.find(params[:id])
    if @personasalistamiento.update_attributes(params[:personasalistamiento])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_personasalistamiento_path(@personasalistamiento)
    else
      @personasalisbien = Personasalisbien.new
      @personasalislaboral = Personasalislaboral.new
      @personasalisasociado = Personasalisasociado.new
      render :action => "personasalistamiento_form"
    end
  end

  def destroy
    @personasalistamiento = Personasalistamiento.find(params[:id])
    @personasalistamiento.destroy
    respond_to do |format|
      format.html { redirect_to(personas_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['procesofactura','demografico','informecontable','informecartera'].include?(action_name)
      "informes"
    elsif ['infoevolucionrecaudo'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
