class DesembolsosrelacionesController < ApplicationController
  # GET /desembolsosrelaciones
  # GET /desembolsosrelaciones.xml
  def index
    @desembolsosrelaciones = Desembolsosrelacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @desembolsosrelaciones }
    end
  end

  # GET /desembolsosrelaciones/1
  # GET /desembolsosrelaciones/1.xml
  def show
    @desembolsosrelacion = Desembolsosrelacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @desembolsosrelacion }
    end
  end

  # GET /desembolsosrelaciones/new
  # GET /desembolsosrelaciones/new.xml
  def new
    @desembolsosrelacion = Desembolsosrelacion.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @desembolsosrelacion }
    end
  end

  # GET /desembolsosrelaciones/1/edit
  def edit
    @desembolsosrelacion = Desembolsosrelacion.find(params[:id])
  end

  # POST /desembolsosrelaciones
  # POST /desembolsosrelaciones.xml
  def create
    @desembolsosrelacion = Desembolsosrelacion.new(params[:desembolsosrelacion])

    respond_to do |format|
      if @desembolsosrelacion.save
        flash[:notice] = 'Desembolsosrelacion was successfully created.'
        format.html { redirect_to(@desembolsosrelacion) }
        format.xml  { render :xml => @desembolsosrelacion, :status => :created, :location => @desembolsosrelacion }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @desembolsosrelacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /desembolsosrelaciones/1
  # PUT /desembolsosrelaciones/1.xml
  def update
    @desembolsosrelacion = Desembolsosrelacion.find(params[:id])

    respond_to do |format|
      if @desembolsosrelacion.update_attributes(params[:desembolsosrelacion])
        flash[:notice] = 'Desembolsosrelacion was successfully updated.'
        format.html { redirect_to(@desembolsosrelacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @desembolsosrelacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /desembolsosrelaciones/1
  # DELETE /desembolsosrelaciones/1.xml
  def destroy
    @desembolsosrelacion = Desembolsosrelacion.find(params[:id])
    @desembolsosrelacion.destroy

    respond_to do |format|
      format.html { redirect_to(desembolsosrelaciones_url) }
      format.xml  { head :ok }
    end
  end
end
