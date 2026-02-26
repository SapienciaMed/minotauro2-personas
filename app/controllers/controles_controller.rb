class ControlesController < ApplicationController
  before_action :set_controles, only: [:show, :index, :destroy, :publicacion]
  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def visualizar
    @control  = Control.find(params[:id])
  end

  def acta1
    @control  = Control.find(params[:id])
  end

  def acta2
    @control  = Control.find(params[:id])
  end

  def acta3
    @control  = Control.find(params[:id])
  end

  def new
    @active_record = Control.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @control = Control.new
    respond_to { |format| format.js }
  end

=begin

  def publicacion
    @controles = Control.search(params[:search], params[:page])
    ActiveRecord::Base.connection.execute("begin prc_detectacumplimiento; end;")        
    if Control.exists?(["tiposcontrol_id = 10005 and web = 'SI'"]) == true
      begin
        @personas = Persona.find(:all, :conditions=>["id in (select persona_id from controles 
                                                             where  tiposcontrol_id = 10005 and web = 'SI') 
                                                      and to_number(VALORTOTAL) > 0"])
        Notifier.deliver_pcmasive_message(@personas)
        ActiveRecord::Base.connection.execute("update personas set fecha_enviopc = sysdate, user_enviopc = 10002 where id in (select persona_id from controles where tiposcontrol_id = 10005 and web = 'SI')")
        ActiveRecord::Base.connection.execute("update controles set web = null where tiposcontrol_id = 10005 and web = 'SI'")
        flash[:notice] = "Solicitud enviada"
      rescue
        flash[:notice] = "Solicitud No enviada, contacte al Administrador."
        logger.error("Correo no enviado")
      end
      redirect_to publicacion_controles_path
    end
  end

def edit
    @control   = Control.new
    control   = Control.find(params[:id])
    @persona  = control.persona
    ActiveRecord::Base.connection.execute(
    "update controles set fecha_realterminacion = sysdate, user_marcaterminacion = #{is_admin}, updated_at = sysdate
     where  id = #{control.id}")
    respond_to do |format|
      format.js { render :action => "controles" }
    end
  end
=end    

  def edit
    @active_record = Control.find(params[:active_id]) if params[:active_id].present?
    @control = Control.find(params[:id])
    @persona = @control.persona
    respond_to { |format| format.js }
  end

  def visualizar
    @control  = Control.find(params[:id])
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @control = Control.new(control_params)
    @control.persona_id = @persona.id
    @control.user_id = is_admin
    respond_to do |format|
      if @control.save
        if @control.tiposcontrol_id == 10005
          format.js { render inline: "location.reload();" }
        else
          flash[:notice] = "#{t :notice_crea_msj}"
          format.js
        end
      else
        format.js { render 'layouts/errors', locals: { object: @control } }
      end
    end
  end

  def update
    @control = Control.find(params[:id])
    @persona = @control.persona
    respond_to do |format|
      if @control.update(control_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @control } }
      end
    end
  end

  def destroy
    ActiveRecord::Base.connection.execute("update personas set fecha_enviopc = null, user_enviopc = null where id = #{@persona.id}")
    @control.destroy
  end

  private

  def set_controles
    @persona = Persona.find(params[:persona_id])
    @control = Control.find(params[:id]) if params[:id]
  end

  def control_params
    params.require(:control).permit!
  end

  def determine_layout
    if ['visualizar','visita'].include?(action_name)
      "basico"
    elsif ['publicacion'].include?(action_name)
      "basicoreporte"
    elsif ['acta1','acta2','acta3'].include?(action_name)
      "blank"  
    else
      "application_admin"
    end
  end
end

