class PersonasimagenesController < ApplicationController
  before_action :set_personasimagenes, only: [:show, :index, :destroy, :activo, :inactivo, :tercero]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personasimagen.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personasimagen = Personasimagen.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personasimagen.find(params[:active_id]) if params[:active_id].present?
    @personasimagen = Personasimagen.find(params[:id])
    @persona = @personasimagen.persona
    respond_to { |format| format.js }
  end

  def visualizar
    @personasimagen  = Personasimagen.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personasimagen = Personasimagen.new(personasimagen_params)
    @personasimagen.persona_id = @persona.id
    @personasimagen.user_id = is_admin
    respond_to do |format|
      if @personasimagen.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personasimagen } }
      end
    end
  end

  def destroy
    @personasimagen.destroy
    respond_to do |format|
      flash[:notice] = "Documento Eliminado con Exito."
      format.js { render inline: "location.reload();" }
    end
  end


  private

  def set_personasimagenes
    @persona = Persona.find(params[:persona_id])
    @personasimagen = Personasimagen.find(params[:id]) if params[:id]
  end

  def personasimagen_params
    params.require(:personasimagen).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
