class PersonasoblcambiosController < ApplicationController
  before_action :set_personasoblcambio, only: [:show, :visualizar, :index, :destroy, :activo, :inactivo]
  respond_to :html, :js
  layout :determine_layout

  def show
    respond_to { |format| format.js}
  end

  def index
    personasobligacion   = Personasobligacion.find(params[:personasobligacion_id])
    @personasoblcambios = personasobligacion.personasoblcambios.all
  end

  def new
    @active_record1 = Personasoblcambio.find(params[:active_id]) if params[:active_id].present?
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @personasoblcambio = Personasoblcambio.new
    respond_to { |format| format.js }
  end


  def edit
    @active_record = Personasoblcambio.find(params[:active_id]) if params[:active_id].present?
    @personasoblcambio = Personasoblcambio.find(params[:id])
    @personasobligacion = @personasoblcambio.personasobligacion
    respond_to { |format| format.js }
  end

  def create
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @personasoblcambio = Personasoblcambio.new(personasoblcambio_params)
    @personasoblcambio.personasobligacion_id = @personasobligacion.id
    @personasoblcambio.persona_id  = @personasobligacion.persona_id
    @personasoblcambio.user_id = is_admin
    @personasoblcambio.estado = 'APROBADO'
    respond_to do |format|
      if @personasoblcambio.save
        ActiveRecord::Base.connection.execute("begin prc_sygma_oblcambio(#{@personasoblcambio.id}); end;")
        flash[:notice] = "#{t :notice_crea_msj}"
        format.js { render inline: "location.reload();" }
      else
        format.js { render 'layouts/errors', locals: { object: @personasoblcambio } }
      end
    end
  end

  private

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    else
      "application_admin"
    end
  end

  def set_personasoblcambio
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @personasoblcambio = Personasoblcambio.find(params[:id]) if params[:id]
  end

  def personasoblcambio_params
    params.require(:personasoblcambio).permit!
  end
end
