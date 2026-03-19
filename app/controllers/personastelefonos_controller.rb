class PersonastelefonosController < ApplicationController
  before_action :set_personastelefonos, only: [:show, :index, :destroy, :activo, :inactivo, :tercero]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personastelefono.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personastelefono = Personastelefono.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personastelefono.find(params[:active_id]) if params[:active_id].present?
    @personastelefono = Personastelefono.find(params[:id])
    @persona = @personastelefono.persona
    respond_to { |format| format.js }
  end

  def activo
    @personastelefono.estado = 'ACTIVO'
    @personastelefono.user_actualiza = is_admin
    respond_to do |format|
      if @personastelefono.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def tercero
    @personastelefono.estado = 'TERCERO'
    @personastelefono.user_actualiza = is_admin
    respond_to do |format|
      if @personastelefono.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end    
  end

  def inactivo
    @personastelefono.estado = 'INACTIVO'
    @personastelefono.user_actualiza = is_admin
    respond_to do |format|
      if @personastelefono.save(validate: false)
        format.js
      else
        flash['danger'] = "Se produjo un error"
        format.js
      end
    end
  end

  def visualizar
    @personastelefono  = Personastelefono.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personastelefono = Personastelefono.new(personastelefono_params)
    @personastelefono.persona_id = @persona.id
    @personastelefono.user_id = is_admin
    respond_to do |format|
      if @personastelefono.save
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personastelefono } }
      end
    end
  end

  def update
    @personastelefono = Personastelefono.find(params[:id])
    @persona = @personastelefono.persona
    respond_to do |format|
      if @personastelefono.update(personastelefono_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personastelefono } }
      end
    end
  end

  def destroy
    @personastelefono.destroy
  end

  private

  def set_personastelefonos
    @persona = Persona.find(params[:persona_id])
    @personastelefono = Personastelefono.find(params[:id]) if params[:id]
  end

  def personastelefono_params
    params.require(:personastelefono).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end
end
