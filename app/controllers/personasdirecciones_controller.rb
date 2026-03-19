class PersonasdireccionesController < ApplicationController
  before_action :set_personasdirecciones, only: [:show, :index, :destroy, :activo, :inactivo, :tercero]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personasdireccion.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personasdireccion = Personasdireccion.new
    respond_to { |format| format.js }
  end

  def abrirmapa
    @personasdireccion  = Personasdireccion.find(params[:id])
    respond_to { |format| format.js }
  end

  def abrirmapa2
    @personasdireccion  = Personasdireccion.find(params[:id])
    respond_to { |format| format.js }
  end

  def activo
    @personasdireccion.estado = 'ACTIVO'
    @personasdireccion.user_actualiza = is_admin
    respond_to do |format|
      if @personasdireccion.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def tercero
    @personasdireccion.estado = 'TERCERO'
    @personasdireccion.user_actualiza = is_admin
    respond_to do |format|
      if @personasdireccion.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def inactivo
    @personasdireccion.estado = 'INACTIVO'
    @personasdireccion.user_actualiza = is_admin
    respond_to do |format|
      if @personasdireccion.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end  

  def edit
    @active_record = Personasdireccion.find(params[:active_id]) if params[:active_id].present?
    @personasdireccion = Personasdireccion.find(params[:id])
    @persona = @personasdireccion.persona
    respond_to { |format| format.js }
  end

  def visualizar
    @personasdireccion  = Personasdireccion.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personasdireccion = Personasdireccion.new(personasdireccion_params)
    @personasdireccion.persona_id = @persona.id
    @personasdireccion.user_id = is_admin
    respond_to do |format|
      if @personasdireccion.save
          flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasdireccion } }
      end
    end
  end

  def update
    @personasdireccion = Personasdireccion.find(params[:id])
    @persona = @personasdireccion.persona
    respond_to do |format|
      if @personasdireccion.update(personasdireccion_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasdireccion } }
      end
    end
  end

  def destroy
    @personasdireccion.destroy
  end

  private

  def set_personasdirecciones
    @persona = Persona.find(params[:persona_id])
    @personasdireccion = Personasdireccion.find(params[:id]) if params[:id]
  end

  def personasdireccion_params
    params.require(:personasdireccion).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
