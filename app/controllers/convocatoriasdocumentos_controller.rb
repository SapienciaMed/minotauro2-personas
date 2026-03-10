class ConvocatoriasdocumentosController < ApplicationController
  # GET /convocatoriasdocumentos
  # GET /convocatoriasdocumentos.xml
  def index
    @convocatoriasdocumentos = Convocatoriasdocumento.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @convocatoriasdocumentos }
    end
  end

  # GET /convocatoriasdocumentos/1
  # GET /convocatoriasdocumentos/1.xml
  def show
    @convocatoriasdocumento = Convocatoriasdocumento.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @convocatoriasdocumento }
    end
  end

  # GET /convocatoriasdocumentos/new
  # GET /convocatoriasdocumentos/new.xml
  def new
    @convocatoriasdocumento = Convocatoriasdocumento.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @convocatoriasdocumento }
    end
  end

  # GET /convocatoriasdocumentos/1/edit
  def edit
    @convocatoriasdocumento = Convocatoriasdocumento.find(params[:id])
  end

  # POST /convocatoriasdocumentos
  # POST /convocatoriasdocumentos.xml
  def create
    @convocatoriasdocumento = Convocatoriasdocumento.new(params[:convocatoriasdocumento])

    respond_to do |format|
      if @convocatoriasdocumento.save
        flash[:notice] = 'Convocatoriasdocumento was successfully created.'
        format.html { redirect_to(@convocatoriasdocumento) }
        format.xml  { render :xml => @convocatoriasdocumento, :status => :created, :location => @convocatoriasdocumento }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @convocatoriasdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /convocatoriasdocumentos/1
  # PUT /convocatoriasdocumentos/1.xml
  def update
    @convocatoriasdocumento = Convocatoriasdocumento.find(params[:id])

    respond_to do |format|
      if @convocatoriasdocumento.update_attributes(params[:convocatoriasdocumento])
        flash[:notice] = 'Convocatoriasdocumento was successfully updated.'
        format.html { redirect_to(@convocatoriasdocumento) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @convocatoriasdocumento.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /convocatoriasdocumentos/1
  # DELETE /convocatoriasdocumentos/1.xml
  def destroy
    @convocatoriasdocumento = Convocatoriasdocumento.find(params[:id])
    @convocatoriasdocumento.destroy

    respond_to do |format|
      format.html { redirect_to(convocatoriasdocumentos_url) }
      format.xml  { head :ok }
    end
  end
end
