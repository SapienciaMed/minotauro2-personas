class PersonascorreosController < ApplicationController
  before_action :set_personascorreo, only: [:show, :visualizar, :index, :destroy, :activo, :inactivo]
  respond_to :html, :js
  layout :determine_layout

  def show
    respond_to { |format| format.js}
  end

  def index
    persona   = Persona.find(params[:persona_id])
    @personascorreos = persona.personascorreos.all
  end

  def enviarcorreo
    @persona = Persona.find(params[:persona_id])
    @personascorreo = Personascorreo.find(params[:id])
    @email = params[:email]
  end

  def new
    @active_record1 = Personascorreo.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personascorreo = Personascorreo.new
    respond_to { |format| format.js }
  end

  def activo
    @personascorreo.estado = 'ACTIVO'
    @personascorreo.user_actualiza = is_admin
    respond_to do |format|
      if @personascorreo.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def inactivo
    @personascorreo.estado = 'INACTIVO'
    @personascorreo.user_actualiza = is_admin
    respond_to do |format|
      if @personascorreo.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def edit
    @active_record = Personascorreo.find(params[:active_id]) if params[:active_id].present?
    @personascorreo = Personascorreo.find(params[:id])
    @persona = @personascorreo.persona
     respond_to { |format| format.js }
  end

  def visualizar
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personascorreo = Personascorreo.new(personascorreo_params)
    @personascorreo.persona_id = @persona.id
    @personascorreo.user_id = is_admin
    respond_to do |format|
      if @personascorreo.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personascorreo } }
      end
    end
  end

  def destroy
    @personascorreo.destroy
  end

  private

    def determine_layout
      if ['visualizar','visita'].include?(action_name)
        "basico"
      else
        "application_admin"
      end
    end

    def set_personascorreo
      @persona = Persona.find(params[:persona_id])
      @personascorreo = Personascorreo.find(params[:id]) if params[:id]
    end

    def personascorreo_params
      params.require(:personascorreo).permit!
    end
end
