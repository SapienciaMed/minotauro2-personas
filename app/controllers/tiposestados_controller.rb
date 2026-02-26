class TiposestadosController < ApplicationController
  # GET /tiposestados
  # GET /tiposestados.xml
  def index
    @tiposestados = Tiposestado.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tiposestados }
    end
  end

  # GET /tiposestados/1
  # GET /tiposestados/1.xml
  def show
    @tiposestado = Tiposestado.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @tiposestado }
    end
  end

  # GET /tiposestados/new
  # GET /tiposestados/new.xml
  def new
    @tiposestado = Tiposestado.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @tiposestado }
    end
  end

  # GET /tiposestados/1/edit
  def edit
    @tiposestado = Tiposestado.find(params[:id])
  end

  # POST /tiposestados
  # POST /tiposestados.xml
  def create
    @tiposestado = Tiposestado.new(params[:tiposestado])

    respond_to do |format|
      if @tiposestado.save
        flash[:notice] = 'Tiposestado was successfully created.'
        format.html { redirect_to(@tiposestado) }
        format.xml  { render :xml => @tiposestado, :status => :created, :location => @tiposestado }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @tiposestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tiposestados/1
  # PUT /tiposestados/1.xml
  def update
    @tiposestado = Tiposestado.find(params[:id])

    respond_to do |format|
      if @tiposestado.update_attributes(params[:tiposestado])
        flash[:notice] = 'Tiposestado was successfully updated.'
        format.html { redirect_to(@tiposestado) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tiposestado.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tiposestados/1
  # DELETE /tiposestados/1.xml
  def destroy
    @tiposestado = Tiposestado.find(params[:id])
    @tiposestado.destroy

    respond_to do |format|
      format.html { redirect_to(tiposestados_url) }
      format.xml  { head :ok }
    end
  end
end
