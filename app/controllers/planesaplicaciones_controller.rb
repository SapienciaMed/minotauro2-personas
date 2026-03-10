class PlanesaplicacionesController < ApplicationController
  before_filter :require_user
  # GET /planesaplicaciones
  # GET /planesaplicaciones.xml
  def index
    @planesaplicaciones = Planesaplicacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planesaplicaciones }
    end
  end

  # GET /planesaplicaciones/1
  # GET /planesaplicaciones/1.xml
  def show
    @planesaplicacion = Planesaplicacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planesaplicacion }
    end
  end

  # GET /planesaplicaciones/new
  # GET /planesaplicaciones/new.xml
  def new
    @planesaplicacion = Planesaplicacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planesaplicacion }
    end
  end

  # GET /planesaplicaciones/1/edit
  def edit
    @planesaplicacion = Planesaplicacion.find(params[:id])
  end

  # POST /planesaplicaciones
  # POST /planesaplicaciones.xml
  def create
    @planesaplicacion = Planesaplicacion.new(params[:planesaplicacion])

    respond_to do |format|
      if @planesaplicacion.save
        flash[:notice] = 'Planesaplicacion was successfully created.'
        format.html { redirect_to(@planesaplicacion) }
        format.xml  { render :xml => @planesaplicacion, :status => :created, :location => @planesaplicacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planesaplicacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planesaplicaciones/1
  # PUT /planesaplicaciones/1.xml
  def update
    @planesaplicacion = Planesaplicacion.find(params[:id])

    respond_to do |format|
      if @planesaplicacion.update_attributes(params[:planesaplicacion])
        flash[:notice] = 'Planesaplicacion was successfully updated.'
        format.html { redirect_to(@planesaplicacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planesaplicacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planesaplicaciones/1
  # DELETE /planesaplicaciones/1.xml
  def destroy
    @planesaplicacion = Planesaplicacion.find(params[:id])
    @planesaplicacion.destroy

    respond_to do |format|
      format.html { redirect_to(planesaplicaciones_url) }
      format.xml  { head :ok }
    end
  end
end
