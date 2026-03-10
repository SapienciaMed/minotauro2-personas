class PersonasobservacionesController < ApplicationController
  before_action :set_personasobservaciones, only: [:show, :index, :destroy, :activo, :inactivo, :tercero]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personasobservacion.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personasobservacion = Personasobservacion.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personasobservacion.find(params[:active_id]) if params[:active_id].present?
    @personasobservacion = Personasobservacion.find(params[:id])
    @persona = @personasobservacion.persona
    respond_to { |format| format.js }
  end

  def visualizar
    @personasobservacion  = Personasobservacion.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personasobservacion = Personasobservacion.new(personasobservacion_params)
    @personasobservacion.persona_id = @persona.id
    @personasobservacion.user_id = is_admin
    respond_to do |format|
      if @personasobservacion.save
          flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasobservacion } }
      end
    end
  end

  def update
    @personasobservacion = Personasobservacion.find(params[:id])
    @persona = @personasobservacion.persona
    respond_to do |format|
      if @personasobservacion.update(personasobservacion_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasobservacion } }
      end
    end
  end

  def destroy
    @personasobservacion.destroy
  end

  private

  def set_personasobservaciones
    @persona = Persona.find(params[:persona_id])
    @personasobservacion = Personasobservacion.find(params[:id]) if params[:id]
  end

  def personasobservacion_params
    params.require(:personasobservacion).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
