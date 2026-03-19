class PersonasalisasociadosController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    personasalistamiento   = Personasalistamiento.find(params[:personasalistamiento_id])
    #@personasalisasociados = personasalistamiento.personasalisasociados.all
    @personasalisasociados = personasalistamiento.personasalisasociados.find(:all, :conditions => ['personasalistamiento_id = ?', params[:personasalistamiento_id]], :order => 'created_at')
  end

  def edit
    @personasalisasociado  = Personasalisasociado.find(params[:id], :include => "personasalistamiento")
    @personasalistamiento  = @personasalisasociado.personasalistamiento
    respond_to do |format|
      format.js { render :action => "edit_personasalisasociado" }
    end
  end

  def create
    @personasalistamiento  = Personasalistamiento.find(params[:personasalistamiento_id])
    @personasalisasociado = Personasalisasociado.new(params[:personasalisasociado])
    @personasalisasociado.user_id = is_admin
    if @personasalisasociado.valid?
      @personasalistamiento.personasalisasociados << @personasalisasociado
      @personasalistamiento.save
      @personasalisasociado = Personasalisasociado.new
      flash[:personasalisasociado] = "Creado con exito"
    else
      flash[:personasalisasociado] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasalisasociados" }
    end
  end

  def update
    @personasalisasociado        = Personasalisasociado.new
    personasalisasociado         = Personasalisasociado.find(params[:id])
    @personasalistamiento        = personasalisasociado.personasalistamiento
    ok = personasalisasociado.update_attributes(params[:personasalisasociado])
    flash[:personasalisasociado] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personasalisasociados" }
    end
  end

  def destroy
    personasalisasociado   = Personasalisasociado.find(params[:id])
    @personasalistamiento  = personasalisasociado.personasalistamiento
    @personasalisasociado  = Personasalisasociado.new
    personasalisasociado.destroy
    flash[:personasalisasociado] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasalisasociados" }
    end
  end

  def atencion
    @personasalisasociados = Personasalisasociado.find(params[:id])
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
