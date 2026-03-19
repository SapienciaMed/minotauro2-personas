class ConvocatoriasController < ApplicationController
  layout :determine_layout
  def index
    if is_convocatoria.to_s == 'S'
      redirect_to indexfinal_convocatorias_path
    else
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @convocatorias }
      end
    end
  end
  
  def visualizar
    @convocatoria = Convocatoria.find(params[:id])
  end

  def new
    if is_convocatoria.to_s == 'S'
      redirect_to indexfinal_convocatorias_path
    else
      @convocatoria = Convocatoria.new
      @convocatoria.acepto =  params[:acepto].to_s
      if @convocatoria.acepto.to_s == ""
        flash[:warning] = "Debe aceptar o rechazar la politica del Habeas Data para poder iniciar el proceso.."
        redirect_to convocatorias_path
      else
        @convocatoriasdocumento = Convocatoriasdocumento.new
        render :action => "convocatoria_form"
      end
    end
  end

  def buscar
    if is_convocatoria.to_s == 'S'
      redirect_to indexfinal_convocatorias_path
    else
      if params[:buscaremail].to_s != "" and params[:buscarclave].to_s != ""
        @convocatorias = Convocatoria.search(params[:buscaremail],params[:buscarclave])
        if @convocatorias.count == 0
          flash[:notice] = "No hay resultados de la busqueda"
          redirect_to convocatorias_path
        elsif @convocatorias.count == 1
          flash[:notice] = "Bienvenido"
          redirect_to edit_convocatoria_path(@convocatorias)
        end
      else
        flash[:notice] = "No hay resultados de la busqueda"
        redirect_to convocatorias_path
      end
    end
  end

  def create
    if is_convocatoria.to_s == 'S'
      redirect_to indexfinal_convocatorias_path
    else
      @iniciocreate = ""
      begin
        @convocatoria = Convocatoria.new(params[:convocatoria])
        @convocatoria.identificacion = params[:convocatoria][:identificacion].to_s.strip
        @convocatoria.clvrand = is_claverandom
        if @convocatoria.save
          begin
            Notifier.deliver_convocatorias_message(@convocatoria)
            rescue Exception => exc
               logger.error("SICPA ERROR Convocatorias - Correo NO enviado a #{@convocatoria.email rescue nil}")
          end
           flash[:notice1]= "OK"
           flash[:notice] = "Formulario de Inscripcion realizado con Exito."
           redirect_to edit_convocatoria_path(@convocatoria)
        else
          @convocatoriasdocumento = Convocatoriasdocumento.new
          flash[:warning] = "Recuerde que debe diligenciar todos los campos obligatorios"
          render :action => "convocatoria_form"
        end
      end
    end
  end

  def enviobienvenida
    @convocatorias = Convocatoria.find(:all)
    @convocatorias.each do |convocatoria|
      begin
        Notifier.deliver_convocatorias_message(convocatoria)
        logger.error("SICPA Enviado Exitosamente a #{convocatoria.email rescue nil}")
        rescue Exception => exc
        logger.error("SICPA ERROR Convocatorias - Correo NO enviado a #{convocatoria.email rescue nil}")
      end
    end
    flash[:notice] = "Correos Listos"
    redirect_to convocatorias_path
  end

  def edit
      @convocatoria = Convocatoria.find(params[:id])
      @convocatoriasdocumento = Convocatoriasdocumento.new
      respond_to do |format|
        format.html { render :action => "convocatoria_form" }
      end
  end

  def update
      @diferente = ""
      @convocatoria = Convocatoria.find(params[:id])
      if @convocatoria.update_attributes(params[:convocatoria])
        redirect_to edit_convocatoria_path(@convocatoria)
      else
        flash[:warning] = "Recuerde que debe diligenciar todos los campos obligatorios"
        @convocatoriasdocumento = Convocatoriasdocumento.new
        render :action => "convocatoria_form"
      end
  end

  private
  def determine_layout
    if ['buscarx','cartam'].include?(action_name)
      "informes"
    elsif ['visualizar','visualizarconsejo'].include?(action_name)
      "basico"
    else
      "conv"
    end
  end
end
