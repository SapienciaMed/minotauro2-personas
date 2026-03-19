class PersonasacademicosController < ApplicationController
  before_action :set_persona
  before_action :set_personasacademicos, only: [:show, :edit, :update, :destroy]

  respond_to :html, :js

  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personasacademico.find(params[:active_id]) if params[:active_id].present?
    @personasacademico = Personasacademico.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personasacademico.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @personasacademico = Personasacademico.new(personasacademico_params)
    @personasacademico.persona_id = @persona.id
    @personasacademico.user_id = is_admin
    respond_to do |format|
      if @personasacademico.save
        flash['success'] = 'Creado con exito'
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasacademico } }
      end
    end
  end

  def update
    respond_to do |format|
      if @personasacademico.update(personasacademico_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasacademico } }
      end
    end
  end

  def destroy
    @personasacademico.destroy
    flash['success'] = 'Borrado con exito'
    respond_to { |format| format.js }
  end

   def visualizar
     @personasacademico  = Personasacademico.find(params[:id])
   end 


  private

    def determine_layout
      if ['rptpersonasacademico','visita'].include?(action_name)
        "excel"
      elsif  ['rpttotal'].include?(action_name)
        "basico"
      else
        "application_admin"
      end
    end

    def set_personasacademicos
      @personasacademico = Personasacademico.find(params[:id]) if params[:id]
    end

    def set_persona
      @persona = Persona.find(params[:persona_id])
    end

    def personasacademico_params
      params.require(:personasacademico).permit!
    end
end
