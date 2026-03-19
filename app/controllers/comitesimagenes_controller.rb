class ComitesimagenesController < ApplicationController

  before_filter :require_user
  before_filter :find_comite_and_comitesimagen

  def index
    comite   = Comite.find(params[:comite_id])
    @comitesimagenes = comite.comitesimagenes.all
  end

  def new
    @comitesimagen = Comitesimagen.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comitesimagen }
    end
  end

  def create
    @comitesimagen = Comitesimagen.new(params[:comitesimagen])
    @comitesimagen.comite_id = @comite.id
    respond_to do |format|
      if @comitesimagen.save
        format.html { redirect_to edit_comite_path(@comite) }
        format.xml  { render :xml => @comitesimagen, :status => :created, :location => @comitesimagen }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comitesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @comitesimagen = Comitesimagen.find(params[:id])
    respond_to do |format|
      if @comitesimagen.update_attributes(params[:comitesimagen])
        format.html { redirect_to comite_comitesimagenes_path(@comite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comitesimagen.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    comitesimagen   = Comitesimagen.find(params[:id])
    @comite         = comitesimagen.comite
    @comitesimagen  = Comitesimagen.new
    comitesimagen.destroy
    respond_to do |format|
      format.js { render :action => "comitesimagenes" }
    end
  end

  def find_comite_and_comitesimagen
      @comite = Comite.find(params[:comite_id])
      @comitesimagen = Comitesimagen.find(params[:id]) if params[:id]
  end

end
