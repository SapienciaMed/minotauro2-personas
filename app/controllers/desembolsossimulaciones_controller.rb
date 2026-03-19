class DesembolsossimulacionesController < ApplicationController
  # GET /desembolsossimulaciones
  # GET /desembolsossimulaciones.xml
  def index
    @desembolsossimulaciones = Desembolsossimulacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @desembolsossimulaciones }
    end
  end

  # GET /desembolsossimulaciones/1
  # GET /desembolsossimulaciones/1.xml
  def show
    @desembolsossimulacion = Desembolsossimulacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @desembolsossimulacion }
    end
  end

  # GET /desembolsossimulaciones/new
  # GET /desembolsossimulaciones/new.xml
  def new
    @desembolsossimulacion = Desembolsossimulacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @desembolsossimulacion }
    end
  end

  # GET /desembolsossimulaciones/1/edit
  def edit
    @desembolsossimulacion = Desembolsossimulacion.find(params[:id])
  end

  # POST /desembolsossimulaciones
  # POST /desembolsossimulaciones.xml
  def create
    @desembolsossimulacion = Desembolsossimulacion.new(params[:desembolsossimulacion])

    respond_to do |format|
      if @desembolsossimulacion.save
        flash[:notice] = 'Desembolsossimulacion was successfully created.'
        format.html { redirect_to(@desembolsossimulacion) }
        format.xml  { render :xml => @desembolsossimulacion, :status => :created, :location => @desembolsossimulacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @desembolsossimulacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /desembolsossimulaciones/1
  # PUT /desembolsossimulaciones/1.xml
  def update
    @desembolsossimulacion = Desembolsossimulacion.find(params[:id])

    respond_to do |format|
      if @desembolsossimulacion.update_attributes(params[:desembolsossimulacion])
        flash[:notice] = 'Desembolsossimulacion was successfully updated.'
        format.html { redirect_to(@desembolsossimulacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @desembolsossimulacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /desembolsossimulaciones/1
  # DELETE /desembolsossimulaciones/1.xml
  def destroy
    @desembolsossimulacion = Desembolsossimulacion.find(params[:id])
    @desembolsossimulacion.destroy

    respond_to do |format|
      format.html { redirect_to(desembolsossimulaciones_url) }
      format.xml  { head :ok }
    end
  end
end
