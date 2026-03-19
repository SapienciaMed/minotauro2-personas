class PlanesfacturasController < ApplicationController
  before_filter :require_user

  def detalle
    @planesfacturas = Planesfactura.find(:all, :conditions=>["personasobligacion_id = #{params[:id]}"], :order=>"id desc")
    @personasobligacion = Personasobligacion.find(params[:id])
  end

  def index
    @planesfacturas = Planesfactura.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planesfacturas }
    end
  end

  # GET /planesfacturas/1
  # GET /planesfacturas/1.xml
  def show
    @planesfactura = Planesfactura.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planesfactura }
    end
  end

  # GET /planesfacturas/new
  # GET /planesfacturas/new.xml
  def new
    @planesfactura = Planesfactura.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planesfactura }
    end
  end

  # GET /planesfacturas/1/edit
  def edit
    @planesfactura = Planesfactura.find(params[:id])
  end

  # POST /planesfacturas
  # POST /planesfacturas.xml
  def create
    @planesfactura = Planesfactura.new(params[:planesfactura])

    respond_to do |format|
      if @planesfactura.save
        flash[:notice] = 'Planesfactura was successfully created.'
        format.html { redirect_to(@planesfactura) }
        format.xml  { render :xml => @planesfactura, :status => :created, :location => @planesfactura }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planesfactura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planesfacturas/1
  # PUT /planesfacturas/1.xml
  def update
    @planesfactura = Planesfactura.find(params[:id])

    respond_to do |format|
      if @planesfactura.update_attributes(params[:planesfactura])
        flash[:notice] = 'Planesfactura was successfully updated.'
        format.html { redirect_to(@planesfactura) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planesfactura.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planesfacturas/1
  # DELETE /planesfacturas/1.xml
  def destroy
    @planesfactura = Planesfactura.find(params[:id])
    @planesfactura.destroy

    respond_to do |format|
      format.html { redirect_to(planesfacturas_url) }
      format.xml  { head :ok }
    end
  end
end
