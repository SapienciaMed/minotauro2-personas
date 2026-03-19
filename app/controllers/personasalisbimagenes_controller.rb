class PersonasalisbimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_personasalisbien_and_personasalisbimagen

  def index
    personasalisbien   = Personasalisbien.find(params[:personasalisbien_id])
    @personasalisbimagenes = personasalisbien.personasalisbimagenes.all
  end

  def new
    @personasalisbimagen = Personasalisbimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasalisbimagen }
    end
  end

  def create
    @personasalisbimagen = Personasalisbimagen.new(params[:personasalisbimagen])
    @personasalisbimagen.personasalisbien_id = @personasalisbien.id
	  @personasalisbimagen.user_id = is_admin
    respond_to do |format|
      if @personasalisbimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_personasalistamiento_path(@personasalisbien.personasalistamiento_id) }
        format.xml  { render :xml => @personasalisbimagen, :status => :created, :location => @personasalisbimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasalisbimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    personasalisbimagen   = Personasalisbimagen.find(params[:id])
    @personasalisbien         = personasalisbimagen.personasalisbien
    @personasalisbimagen  = Personasalisbimagen.new
    personasalisbimagen.destroy
    render :update do |page|
      page.alert "MINOTAURO - Documento eliminado"
    end
  end

  def find_personasalisbien_and_personasalisbimagen
      @personasalisbien = Personasalisbien.find(params[:personasalisbien_id])
      @personasalisbimagen = Personasalisbimagen.find(params[:id]) if params[:id]
  end
end
