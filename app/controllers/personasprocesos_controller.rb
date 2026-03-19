class PersonasprocesosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
  end

  def new
    @personasproceso = Personasproceso.new
    @personasproceso.persona_id = params[:id]
    render :action => "personasproceso_form"
  end

  def edit
    @personasproceso = Personasproceso.find(params[:id])
    @personasproimagen = Personasproimagen.new
    respond_to do |format|
      format.html { render :action => "personasproceso_form" }
    end
  end

  def create
    @personasproceso = Personasproceso.new(params[:personasproceso])
    if @personasproceso.save
      flash[:notice] = "Usuario Creado con Exito."
      redirect_to edit_personasproceso_path(@personasproceso)
    else
      @personasproimagen = Personasproimagen.new
      render :action => "personasproceso_form"
     end
  end

  def update
    @personasproceso = Personasproceso.find(params[:id])
    if @personasproceso.update_attributes(params[:personasproceso])
     flash[:notice] = "Usuario Actualizado con Exito."
      redirect_to edit_personasproceso_path(@personasproceso)
    else
      @personasproimagen = Personasproimagen.new
      render :action => "personasproceso_form"
    end
  end

  def destroy
    @personasproceso = Personasproceso.find(params[:id])
    @personasproceso.destroy
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
