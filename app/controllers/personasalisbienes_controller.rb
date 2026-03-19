class PersonasalisbienesController < ApplicationController
  before_filter :require_user
  layout :determine_layout

  def index
    personasalistamiento   = Personasalistamiento.find(params[:personasalistamiento_id])
    #@personasalisbienes = personasalistamiento.personasalisbienes.all
    @personasalisbienes = personasalistamiento.personasalisbienes.find(:all, :conditions => ['personasalistamiento_id = ?', params[:personasalistamiento_id]], :order => 'created_at')
  end

  def edit
    @personasalisbien  = Personasalisbien.find(params[:id], :include => "personasalistamiento")
    @personasalistamiento  = @personasalisbien.personasalistamiento
    respond_to do |format|
      format.js { render :action => "edit_personasalisbien" }
    end
  end

  def create
    @personasalistamiento  = Personasalistamiento.find(params[:personasalistamiento_id])
    @personasalisbien = Personasalisbien.new(params[:personasalisbien])
    @personasalisbien.user_id = is_admin
    if @personasalisbien.valid?
      @personasalistamiento.personasalisbienes << @personasalisbien
      @personasalistamiento.save
      @personasalisbien = Personasalisbien.new
      flash[:personasalisbien] = "Creado con exito"
    else
      flash[:personasalisbien] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "personasalisbienes" }
    end
  end

  def update
    @personasalisbien        = Personasalisbien.new
    personasalisbien         = Personasalisbien.find(params[:id])
    @personasalistamiento        = personasalisbien.personasalistamiento
    ok = personasalisbien.update_attributes(params[:personasalisbien])
    flash[:personasalisbien] = ok ? "Actualizado con Exito" : "Se produjo un error al actualizar el registro"
    respond_to do |format|
      format.js { render :action => "personasalisbienes" }
    end
  end

  def destroy
    personasalisbien   = Personasalisbien.find(params[:id])
    @personasalistamiento  = personasalisbien.personasalistamiento
    @personasalisbien  = Personasalisbien.new
    personasalisbien.destroy
    flash[:personasalisbien] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "personasalisbienes" }
    end
  end

  def atencion
    @personasalisbienes = Personasalisbien.find(params[:id])
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
