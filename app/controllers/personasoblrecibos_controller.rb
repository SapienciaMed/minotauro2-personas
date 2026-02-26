
class PersonasoblrecibosController < ApplicationController

  def search
    @personas = Persona.where("autobuscar LIKE ?", "%#{replacespace(params[:q]).upcase}%").limit(10)
    respond_to do |format|
      format.json { render json: @personas.map { |p| { id: p.id, name: "#{p.autobuscar}" } } }
    end
  end

  def get_personasoblrecibo_personasobligacion_id
    persona_id = params[:persona_id]

    @personasobligaciones = Personasobligacion
                              .where(persona_id: persona_id)
                              .select { |p| p.totalvencido.to_i + p.vlrcuota.to_i > 0 }

    respond_to { |format| format.js }
  end

  def create
    @personasoblrecibo = Personasoblrecibo.new(personasoblrecibo_params)
    @personasoblrecibo.fecha_recaudo = Date.today
    @personasoblrecibo.user_id = is_admin
    @personasoblrecibo.forma_pago = 'COBRA'
    @personasoblrecibo.estado = 'PENDIENTE'
    @personasoblrecibo.observacion = "LINK PAGO COBRA"
    @personasoblrecibo.email = Personascorreo.where("persona_id = #{@personasoblrecibo.persona_id}").last.email.downcase rescue nil
    @personasoblrecibo.celular = Personastelefono.where("persona_id = #{@personasoblrecibo.persona_id} and tipo = 'CELULAR'").last.telefono rescue nil
    @personasoblrecibo.personasobligacion_id = @personasoblrecibo.personasobligacion_id
    @personasoblrecibo.persona_id = @personasoblrecibo.persona_id
    if @personasoblrecibo.save
      WsController.generar_link_pago_epayco(@personasoblrecibo.id)
      redirect_to links_path
    else
      redirect_to links_path
    end
  end

  private

  def personasoblrecibo_params
    params.require(:personasoblrecibo).permit!
  end
end