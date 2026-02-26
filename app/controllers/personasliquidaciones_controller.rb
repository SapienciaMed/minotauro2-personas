class PersonasliquidacionesController < ApplicationController
  before_action :set_persona
  before_action :set_personasliquidaciones, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js
  layout :determine_layout

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @active_record = Personasliquidacion.find(params[:active_id]) if params[:active_id].present?
    @personasliquidacion = Personasliquidacion.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @active_record = Personasliquidacion.find(params[:active_id]) if params[:active_id].present?
    respond_to do |format|
      format.js
    end
  end

  def create
    @personasliquidacion = Personasliquidacion.new(personasliquidacion_params)
    @personasliquidacion.persona_id = @persona.id
    @personasliquidacion.user_id    = is_admin

    respond_to do |format|
      if @personasliquidacion.save
        flash['success'] = 'Creado con exito'
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasliquidacion } }
      end
    end
  end

  def update
    respond_to do |format|
      if @personasliquidacion.update(personasliquidacion_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasliquidacion } }
      end
    end
  end

  def destroy
    @personasliquidacion.destroy
    flash['success'] = 'Borrado con exito'
    respond_to do |format|
      format.js
    end
  end

  def visualizar
    @personasliquidacion = Personasliquidacion.find(params[:id])
  end

  private

  def determine_layout
    if ['rptpersonasliquidacion', 'visita'].include?(action_name)
      'excel'
    elsif ['rpttotal'].include?(action_name)
      'basico'
    else
      'application_admin'
    end
  end

  def set_personasliquidaciones
    @personasliquidacion = Personasliquidacion.find(params[:id]) if params[:id]
  end

  def set_persona
    @persona = Persona.find(params[:persona_id])
  end

  def personasliquidacion_params
    params.require(:personasliquidacion).permit!
  end
end