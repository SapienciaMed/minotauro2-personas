class PersonasalislimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_personasalislaboral_and_personasalislimagen

  def index
    personasalislaboral   = Personasalislaboral.find(params[:personasalislaboral_id])
    @personasalislimagenes = personasalislaboral.personasalislimagenes.all
  end

  def new
    @personasalislimagen = Personasalislimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasalislimagen }
    end
  end

  def create
    @personasalislimagen = Personasalislimagen.new(params[:personasalislimagen])
    @personasalislimagen.personasalislaboral_id = @personasalislaboral.id
	  @personasalislimagen.user_id = is_admin
    respond_to do |format|
      if @personasalislimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_personasalistamiento_path(@personasalislaboral.personasalistamiento_id) }
        format.xml  { render :xml => @personasalislimagen, :status => :created, :location => @personasalislimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasalislimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    personasalislimagen   = Personasalislimagen.find(params[:id])
    @personasalislaboral         = personasalislimagen.personasalislaboral
    @personasalislimagen  = Personasalislimagen.new
    personasalislimagen.destroy
    render :update do |page|
      page.alert "MINOTAURO - Documento eliminado"
    end
  end

  def find_personasalislaboral_and_personasalislimagen
      @personasalislaboral = Personasalislaboral.find(params[:personasalislaboral_id])
      @personasalislimagen = Personasalislimagen.find(params[:id]) if params[:id]
  end
end
