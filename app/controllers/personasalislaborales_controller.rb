class PersonasalislaboralesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    personasalistamiento   = Personasalistamiento.find(params[:personasalistamiento_id])
    #@personasalislaborales = personasalistamiento.personasalislaborales.all
    @personasalislaborales = personasalistamiento.personasalislaborales.find(:all, :conditions => ['personasalistamiento_id = ?', params[:personasalistamiento_id]], :order => 'created_at')
  end

  def edit
    @personasalislaboral  = Personasalislaboral.find(params[:id], :include => "personasalistamiento")
    @personasalistamiento  = @personasalislaboral.personasalistamiento
    respond_to do |format|
      format.js { render :action => "edit_personasalislaboral" }
    end
  end

  def create
    @personasalistamiento  = Personasalistamiento.find(params[:personasalistamiento_id])
    @personasalislaboral = Personasalislaboral.new(params[:personasalislaboral])
    @personasalislaboral.user_id = is_admin
    if @personasalislaboral.valid?
      @personasalistamiento.personasalislaborales << @personasalislaboral
      @personasalistamiento.save
      @personasalislaboral = Personasalislaboral.new
      flash[:personasalislaboral] = "Creado con exito"
    else
      flash[:personasalislaboral] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasalislaborales" }
    end
  end

  def update
    @personasalislaboral        = Personasalislaboral.new
    personasalislaboral         = Personasalislaboral.find(params[:id])
    @personasalistamiento        = personasalislaboral.personasalistamiento
    ok = personasalislaboral.update_attributes(params[:personasalislaboral])
    flash[:personasalislaboral] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personasalislaborales" }
    end
  end

  def destroy
    personasalislaboral   = Personasalislaboral.find(params[:id])
    @personasalistamiento  = personasalislaboral.personasalistamiento
    @personasalislaboral  = Personasalislaboral.new
    personasalislaboral.destroy
    flash[:personasalislaboral] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasalislaborales" }
    end
  end

  def atencion
    @personasalislaborales = Personasalislaboral.find(params[:id])
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
