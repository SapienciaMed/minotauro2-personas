class PlanesrecaudosdetallesController < ApplicationController
  before_filter :require_user
  # GET /planesrecaudosdetalles
  # GET /planesrecaudosdetalles.xml
  def index
    @planesrecaudosdetalles = Planesrecaudosdetalle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planesrecaudosdetalles }
    end
  end

  # GET /planesrecaudosdetalles/1
  # GET /planesrecaudosdetalles/1.xml
  def show
    @planesrecaudosdetalle = Planesrecaudosdetalle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planesrecaudosdetalle }
    end
  end

  # GET /planesrecaudosdetalles/new
  # GET /planesrecaudosdetalles/new.xml
  def new
    @planesrecaudosdetalle = Planesrecaudosdetalle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planesrecaudosdetalle }
    end
  end

  # GET /planesrecaudosdetalles/1/edit
  def edit
    @planesrecaudosdetalle = Planesrecaudosdetalle.find(params[:id])
  end

  # POST /planesrecaudosdetalles
  # POST /planesrecaudosdetalles.xml
  def create
    @planesrecaudosdetalle = Planesrecaudosdetalle.new(params[:planesrecaudosdetalle])

    respond_to do |format|
      if @planesrecaudosdetalle.save
        flash[:notice] = 'Planesrecaudosdetalle was successfully created.'
        format.html { redirect_to(@planesrecaudosdetalle) }
        format.xml  { render :xml => @planesrecaudosdetalle, :status => :created, :location => @planesrecaudosdetalle }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planesrecaudosdetalle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planesrecaudosdetalles/1
  # PUT /planesrecaudosdetalles/1.xml
  def update
    @planesrecaudosdetalle = Planesrecaudosdetalle.find(params[:id])

    respond_to do |format|
      if @planesrecaudosdetalle.update_attributes(params[:planesrecaudosdetalle])
        flash[:notice] = 'Planesrecaudosdetalle was successfully updated.'
        format.html { redirect_to(@planesrecaudosdetalle) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planesrecaudosdetalle.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planesrecaudosdetalles/1
  # DELETE /planesrecaudosdetalles/1.xml
  def destroy
    @planesrecaudosdetalle = Planesrecaudosdetalle.find(params[:id])
    @planesrecaudosdetalle.destroy

    respond_to do |format|
      format.html { redirect_to(planesrecaudosdetalles_url) }
      format.xml  { head :ok }
    end
  end
end
