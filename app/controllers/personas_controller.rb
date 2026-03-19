class PersonasController < ApplicationController
  before_action :set_persona, only: [:show, :edit, :update, :destroy]
  layout :set_layout

  def procesocreausers
    cadena = "begin DBMS_SCHEDULER.RUN_JOB(job_name => 'CREA_USERS', use_current_session => FALSE); end;"
    ActiveRecord::Base.connection.execute("#{cadena}")
    flash[:notice] = "Proceso de creacion de usuarios Iniciado"
    redirect_to personas_path
  end

  def etapar
    if params[:etapa].present?
      User.where(id: is_admin).update_all(etapa: params[:etapa].to_s, updated_at: Time.now)
    end
    redirect_to personas_path
  end

  def index
    @user = User.find(is_admin)
    if params[:identificacion].present? || params[:nro_obligacion].present?
      @personas = Persona.search(params[:identificacion], params[:nro_obligacion])
      if @personas.empty?
        flash[:notice] = "No hay resultados de la búsqueda"
      else
        respond_to do |format|
          format.html
          format.js
        end
      end
    end
  end

  def new
    @persona = Persona.new
    @persona.etapa = 'A'
    render action: "persona_form"
  end

  def edit
    respond_to do |format|
      format.html { render :action => "persona_form" }
    end
  end

  def create
    @persona = Persona.new(persona_params)
    @persona.etapa = 'A'
    respond_to do |format|
      if @persona.save
        format.html { redirect_to edit_persona_path(etapa: "A", id: @persona.id), notice: "Persona Creada con Exito." }
      else
        @persona.etapa = 'A'
        format.html { render "persona_form" }
      end
    end
  end

  def update
    if @persona.update(persona_params)
      flash['success'] = "Usuario Actualizado con Exito....!!!"
      redirect_to edit_persona_path(etapa: "A", id: @persona.id)
    else
      @personasdirecciones = @persona.personasdirecciones.all
      @personastelefonos = @persona.personastelefonos.all
      render action: "persona_form"
    end
  end


  # Metodo para la creacion de los usuarios
  def self.crear_usuario
    Objeto.find_by_sql("Select id, nombre_completo, email, telefono, identificacion From tmpcreacionusuarios").each do |persona|
      begin
        if persona.email.present?
          iduser = User.create!(username: persona.identificacion, email: persona.email.downcase, nombre: persona.nombre_completo, activo: 'S', acceso_remoto: 'N', cargo: 'Administrador', identificacion: persona.identificacion, observaciones: "CREACION DE USUARIOS #{Time.now}", password: persona.identificacion, persona_id: persona.id)
          persona = Persona.find(persona.id)
          #persona.user_aplicacion = iduser.id
          persona.save
          if iduser
            persona.update(observacion_creacion: nil)
          end
        end

      rescue ActiveRecord::ActiveRecordError => invalid
        error = invalid.to_s
        Persona.where(["id = #{persona.id}"]).update_all(observacion_creacion: error[0..999].to_s)
      end
    end
    # Complemento para crear los usuarios con identificaciones pequeñas
    Objeto.find_by_sql("Select id, nombre_completo, email, telefono, identificacion
                        From tmpcreacionusuarios
                        where id in (select id from personas where upper(observacion_creacion) like upper('%validaci%fall%Contra%demasiado corto%'))").each do |persona|
      begin
        if persona.email.present?
          us = User.new
          us.username = persona.identificacion.to_s
          us.email = persona.email.downcase.to_s
          us.nombre = persona.nombre_completo.to_s
          us.activo = 'S'
          us.acceso_remoto = 'N'
          us.cargo = 'Administrador'
          us.identificacion = persona.identificacion.to_s
          us.observaciones = "CREACION DE USUARIOS #{Time.now}".to_s
          us.password = persona.identificacion.to_s
          us.persona_id = persona.id
          us.save(validate: false)
          iduser = us.id
          persona = Persona.find(persona.id)
          #persona.user_aplicacion = iduser.id
          persona.save(validate: false)
          if iduser
            persona.update(observacion_creacion: nil)
          end
        end
      rescue ActiveRecord::ActiveRecordError => invalid
        error = invalid.to_s
        Persona.where(["id = #{persona.id}"]).update_all(observacion_creacion: error[0..999].to_s)
      end
    end
  end

  def sendpc
    @persona = Persona.find(params[:id])
    if @persona.valortotal.to_i > 0
      begin
        Notifier.deliver_pc_message(@persona)
        ActiveRecord::Base.connection.execute("update personas set fecha_enviopc = sysdate, user_enviopc = #{is_admin} where id = #{@persona.id}")
        flash[:notice] = "Solicitud enviada"
      rescue
        flash[:notice] = "Solicitud No enviada, contacte al Administrador."
        logger.error("Correo no enviado")
      end
    else
      flash[:notice] = "Solicitud No enviada, No tienen Valor para Paso al Cobro."
    end
    redirect_to edit_persona_path(@persona)
  end

  def sendpc_masive
    begin
      @personas = Persona.find(:all, :conditions => ["id in (select persona_id from controles where tiposcontrol_id = 10005 and web = 'SI')"])
      Notifier.deliver_pcmasive_message(@personas)
      flash[:notice] = "Solicitud enviada"
    rescue
      flash[:notice] = "Solicitud No enviada, contacte al Administrador."
      logger.error("Correo no enviado")
    end
    redirect_to publicacion_controles_path
  end

  private
  def set_layout
    if ['edit', 'index'].include?(action_name)#ojo prueb
      "application_personas"#ojo prueb
    else
      "application_admin"
    end
  end

  def set_persona
    params[:etapa].to_s != "" ? Persona.find(params[:id]).update_columns(etapa: params[:etapa].to_s) : nil
    @persona = Persona.find(params[:id])
  rescue
    redirect_to root_path
  end

  def persona_params
    params.require(:persona).permit!
  end
end
