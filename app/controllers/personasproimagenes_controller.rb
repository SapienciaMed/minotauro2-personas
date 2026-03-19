class PersonasproimagenesController < ApplicationController
  before_filter :require_user
  before_filter :find_personasproceso_and_personasproimagen, :except=>"destroy2"
  layout :determine_layout

  def index
    personasproceso   = Personasproceso.find(params[:personasproceso_id])
    @personasproimagenes = personasproceso.personasproimagenes.all
  end

  def new
    @personasproimagen = Personasproimagen.new
    @personasproimagen.descripcion = params[:descripcion]
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasproimagen }
    end
  end

  def create
    @personasproimagen = Personasproimagen.new(params[:personasproimagen])
    @personasproimagen.personasproceso_id = @personasproceso.id
    #@personasproimagen.user_id = is_admin
    respond_to do |format|
      if @personasproimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_personasproceso_path(@personasproceso) }
        format.xml  { render :xml => @personasproimagen, :status => :created, :location => @personasproimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasproimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @personasproimagen = Personasproimagen.find(params[:id])
    respond_to do |format|
      if @personasproimagen.update_attributes(params[:personasproimagen])
        format.html { redirect_to personasproceso_personasproimagenes_path(@personasproceso) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personasproimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    personasproimagen   = Personasproimagen.find(params[:id])
    @personasproceso    = personasproimagen.personasproceso
    @personasproimagen  = Personasproimagen.new
    personasproimagen.destroy
    render :update do |page|
      page.alert "SIIS - Documento eliminado"
    end
  end

  def destroy2
    personasproimagen = Personasproimagen.find(params[:id])
    personasproimagen.destroy
    flash[:notice] = "Documento Eliminado con Exito."
    redirect_to :controller=>"personasproceso", :action=>"edit", :id=>params[:personasproceso_id]
  end

  def find_personasproceso_and_personasproimagen
      @personasproceso = Personasproceso.find(params[:personasproceso_id])
      @personasproimagen = Personasproimagen.find(params[:id]) if params[:id]
  end

  private
  def determine_layout
    if ['buscarx','rptdatos','rptconsolidado'].include?(action_name)
      "informes"
    else
      "application"
    end
  end
end