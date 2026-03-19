class OficinasregistrosController < ApplicationController
  # GET /oficinasregistros
  # GET /oficinasregistros.xml
  def index
    @oficinasregistros = Oficinasregistro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @oficinasregistros }
    end
  end

  # GET /oficinasregistros/1
  # GET /oficinasregistros/1.xml
  def show
    @oficinasregistro = Oficinasregistro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @oficinasregistro }
    end
  end

  # GET /oficinasregistros/new
  # GET /oficinasregistros/new.xml
  def new
    @oficinasregistro = Oficinasregistro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @oficinasregistro }
    end
  end

  # GET /oficinasregistros/1/edit
  def edit
    @oficinasregistro = Oficinasregistro.find(params[:id])
  end

  # POST /oficinasregistros
  # POST /oficinasregistros.xml
  def create
    @oficinasregistro = Oficinasregistro.new(params[:oficinasregistro])

    respond_to do |format|
      if @oficinasregistro.save
        flash[:notice] = 'Oficinasregistro was successfully created.'
        format.html { redirect_to(@oficinasregistro) }
        format.xml  { render :xml => @oficinasregistro, :status => :created, :location => @oficinasregistro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @oficinasregistro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /oficinasregistros/1
  # PUT /oficinasregistros/1.xml
  def update
    @oficinasregistro = Oficinasregistro.find(params[:id])

    respond_to do |format|
      if @oficinasregistro.update_attributes(params[:oficinasregistro])
        flash[:notice] = 'Oficinasregistro was successfully updated.'
        format.html { redirect_to(@oficinasregistro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @oficinasregistro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /oficinasregistros/1
  # DELETE /oficinasregistros/1.xml
  def destroy
    @oficinasregistro = Oficinasregistro.find(params[:id])
    @oficinasregistro.destroy

    respond_to do |format|
      format.html { redirect_to(oficinasregistros_url) }
      format.xml  { head :ok }
    end
  end
end
