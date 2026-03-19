class PersonasalisaimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_personasalisasociado_and_personasalisaimagen

  def index
    personasalisasociado   = Personasalisasociado.find(params[:personasalisasociado_id])
    @personasalisaimagenes = personasalisasociado.personasalisaimagenes.all
  end

  def new
    @personasalisaimagen = Personasalisaimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasalisaimagen }
    end
  end

  def create
    @personasalisaimagen = Personasalisaimagen.new(params[:personasalisaimagen])
    @personasalisaimagen.personasalisasociado_id = @personasalisasociado.id
	  @personasalisaimagen.user_id = is_admin
    respond_to do |format|
      if @personasalisaimagen.save
        flash[:notice] = "Documento Cargado con Exito."
        format.html { redirect_to edit_personasalistamiento_path(@personasalisasociado.personasalistamiento_id) }
        format.xml  { render :xml => @personasalisaimagen, :status => :created, :location => @personasalisaimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasalisaimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    personasalisaimagen   = Personasalisaimagen.find(params[:id])
    @personasalisasociado         = personasalisaimagen.personasalisasociado
    @personasalisaimagen  = Personasalisaimagen.new
    personasalisaimagen.destroy
    render :update do |page|
      page.alert "MINOTAURO - Documento eliminado"
    end
  end

  def find_personasalisasociado_and_personasalisaimagen
      @personasalisasociado = Personasalisasociado.find(params[:personasalisasociado_id])
      @personasalisaimagen = Personasalisaimagen.find(params[:id]) if params[:id]
  end
end
