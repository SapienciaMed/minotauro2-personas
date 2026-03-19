class PersonascontrolesController < ApplicationController
  before_action :set_personascontroles, only: [:show, :index, :destroy, :activo, :inactivo, :tercero]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personascontrol.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personascontrol = Personascontrol.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personascontrol.find(params[:active_id]) if params[:active_id].present?
    @personascontrol = Personascontrol.find(params[:id])
    @persona = @personascontrol.persona
    respond_to { |format| format.js }
  end

  def visualizar
    @personascontrol  = Personascontrol.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personascontrol = Personascontrol.new(personascontrol_params)
    @personascontrol.persona_id = @persona.id
    @personascontrol.user_id = is_admin
    respond_to do |format|
      if @personascontrol.save
          flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personascontrol } }
      end
    end
  end

  def update
    @personascontrol = Personascontrol.find(params[:id])
    @persona = @personascontrol.persona
    respond_to do |format|
      if @personascontrol.update(personascontrol_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personascontrol } }
      end
    end
  end

  def destroy
    @personascontrol.destroy
  end

  private

  def set_personascontroles
    @persona = Persona.find(params[:persona_id])
    @personascontrol = Personascontrol.find(params[:id]) if params[:id]
  end

  def personascontrol_params
    params.require(:personascontrol).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
