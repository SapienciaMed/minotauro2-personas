class TasassimulacionesController < ApplicationController
  # GET /tasassimulaciones
  # GET /tasassimulaciones.xml
  def index
    @tasassimulaciones = Tasassimulacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasassimulaciones }
    end
  end

  # GET /tasassimulaciones/1
  # GET /tasassimulaciones/1.xml
  def show
    @tasassimulacion = Tasassimulacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tasassimulacion }
    end
  end

  # GET /tasassimulaciones/new
  # GET /tasassimulaciones/new.xml
  def new
    @tasassimulacion = Tasassimulacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tasassimulacion }
    end
  end

  # GET /tasassimulaciones/1/edit
  def edit
    @tasassimulacion = Tasassimulacion.find(params[:id])
  end

  # POST /tasassimulaciones
  # POST /tasassimulaciones.xml
  def create
    @tasassimulacion = Tasassimulacion.new(params[:tasassimulacion])

    respond_to do |format|
      if @tasassimulacion.save
        flash[:notice] = 'Tasassimulacion was successfully created.'
        format.html { redirect_to(@tasassimulacion) }
        format.xml  { render :xml => @tasassimulacion, :status => :created, :location => @tasassimulacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tasassimulacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasassimulaciones/1
  # PUT /tasassimulaciones/1.xml
  def update
    @tasassimulacion = Tasassimulacion.find(params[:id])

    respond_to do |format|
      if @tasassimulacion.update_attributes(params[:tasassimulacion])
        flash[:notice] = 'Tasassimulacion was successfully updated.'
        format.html { redirect_to(@tasassimulacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tasassimulacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasassimulaciones/1
  # DELETE /tasassimulaciones/1.xml
  def destroy
    @tasassimulacion = Tasassimulacion.find(params[:id])
    @tasassimulacion.destroy

    respond_to do |format|
      format.html { redirect_to(tasassimulaciones_url) }
      format.xml  { head :ok }
    end
  end
end
