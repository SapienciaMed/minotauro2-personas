class OficinasController < ApplicationController
  # GET /oficinas
  # GET /oficinas.xml
  def index
    @oficinas = Oficina.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oficinas }
    end
  end

  # GET /oficinas/1
  # GET /oficinas/1.xml
  def show
    @oficina = Oficina.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oficina }
    end
  end

  # GET /oficinas/new
  # GET /oficinas/new.xml
  def new
    @oficina = Oficina.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oficina }
    end
  end

  # GET /oficinas/1/edit
  def edit
    @oficina = Oficina.find(params[:id])
  end

  # POST /oficinas
  # POST /oficinas.xml
  def create
    @oficina = Oficina.new(params[:oficina])

    respond_to do |format|
      if @oficina.save
        flash[:notice] = 'Oficina was successfully created.'
        format.html { redirect_to(@oficina) }
        format.xml  { render :xml => @oficina, :status => :created, :location => @oficina }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oficina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oficinas/1
  # PUT /oficinas/1.xml
  def update
    @oficina = Oficina.find(params[:id])

    respond_to do |format|
      if @oficina.update_attributes(params[:oficina])
        flash[:notice] = 'Oficina was successfully updated.'
        format.html { redirect_to(@oficina) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oficina.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oficinas/1
  # DELETE /oficinas/1.xml
  def destroy
    @oficina = Oficina.find(params[:id])
    @oficina.destroy

    respond_to do |format|
      format.html { redirect_to(oficinas_url) }
      format.xml  { head :ok }
    end
  end
end
