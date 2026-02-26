class PlanesrespaldosController < ApplicationController
  before_filter :require_user
  # GET /planesrespaldos
  # GET /planesrespaldos.xml
  def index
    @planesrespaldos = Planesrespaldo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planesrespaldos }
    end
  end

  # GET /planesrespaldos/1
  # GET /planesrespaldos/1.xml
  def show
    @planesrespaldo = Planesrespaldo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planesrespaldo }
    end
  end

  # GET /planesrespaldos/new
  # GET /planesrespaldos/new.xml
  def new
    @planesrespaldo = Planesrespaldo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planesrespaldo }
    end
  end

  # GET /planesrespaldos/1/edit
  def edit
    @planesrespaldo = Planesrespaldo.find(params[:id])
  end

  # POST /planesrespaldos
  # POST /planesrespaldos.xml
  def create
    @planesrespaldo = Planesrespaldo.new(params[:planesrespaldo])

    respond_to do |format|
      if @planesrespaldo.save
        flash[:notice] = 'Planesrespaldo was successfully created.'
        format.html { redirect_to(@planesrespaldo) }
        format.xml  { render :xml => @planesrespaldo, :status => :created, :location => @planesrespaldo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planesrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planesrespaldos/1
  # PUT /planesrespaldos/1.xml
  def update
    @planesrespaldo = Planesrespaldo.find(params[:id])

    respond_to do |format|
      if @planesrespaldo.update_attributes(params[:planesrespaldo])
        flash[:notice] = 'Planesrespaldo was successfully updated.'
        format.html { redirect_to(@planesrespaldo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planesrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planesrespaldos/1
  # DELETE /planesrespaldos/1.xml
  def destroy
    @planesrespaldo = Planesrespaldo.find(params[:id])
    @planesrespaldo.destroy

    respond_to do |format|
      format.html { redirect_to(planesrespaldos_url) }
      format.xml  { head :ok }
    end
  end
end
