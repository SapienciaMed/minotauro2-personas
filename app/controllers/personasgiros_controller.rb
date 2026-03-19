class PersonasgirosController < ApplicationController
  before_action :set_persona
  before_action :set_personasgiros, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js
  layout :determine_layout

  def show
    respond_to do |format|
      format.js
    end
  end

  def new
    @active_record = Personasgiro.find(params[:active_id]) if params[:active_id].present?
    @personasgiro = Personasgiro.new
    respond_to do |format|
      format.js
    end
  end

  def edit
    @active_record = Personasgiro.find(params[:active_id]) if params[:active_id].present?
    respond_to do |format|
      format.js
    end
  end

  def create
    @personasgiro = Personasgiro.new(personasgiro_params)
    @personasgiro.persona_id = @persona.id
    @personasgiro.user_id    = is_admin

    respond_to do |format|
      if @personasgiro.save
        flash['success'] = 'Creado con exito'
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasgiro } }
      end
    end
  end

  def update
    respond_to do |format|
      if @personasgiro.update(personasgiro_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasgiro } }
      end
    end
  end

  def destroy
    @personasgiro.destroy
    flash['success'] = 'Borrado con exito'
    respond_to do |format|
      format.js
    end
  end

  def visualizar
    @personasgiro = Personasgiro.find(params[:id])
  end

  private

  def determine_layout
    if ['rptpersonasgiro', 'visita'].include?(action_name)
      'excel'
    elsif ['rpttotal'].include?(action_name)
      'basico'
    else
      'application_admin'
    end
  end

  def set_personasgiros
    @personasgiro = Personasgiro.find(params[:id]) if params[:id]
  end

  def set_persona
    @persona = Persona.find(params[:persona_id])
  end

  def personasgiro_params
    params.require(:personasgiro).permit!
  end
end