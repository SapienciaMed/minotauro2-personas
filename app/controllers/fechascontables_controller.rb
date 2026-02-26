class FechascontablesController < ApplicationController
  before_filter :require_user
  # GET /fechascontables
  # GET /fechascontables.xml
  def index
    @fechascontables = Fechascontable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fechascontables }
    end
  end

  # GET /fechascontables/1
  # GET /fechascontables/1.xml
  def show
    @fechascontable = Fechascontable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fechascontable }
    end
  end

  # GET /fechascontables/new
  # GET /fechascontables/new.xml
  def new
    @fechascontable = Fechascontable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fechascontable }
    end
  end

  # GET /fechascontables/1/edit
  def edit
    @fechascontable = Fechascontable.find(params[:id])
  end

  # POST /fechascontables
  # POST /fechascontables.xml
  def create
    @fechascontable = Fechascontable.new(params[:fechascontable])

    respond_to do |format|
      if @fechascontable.save
        flash[:notice] = 'Fechascontable was successfully created.'
        format.html { redirect_to(@fechascontable) }
        format.xml  { render :xml => @fechascontable, :status => :created, :location => @fechascontable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fechascontable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fechascontables/1
  # PUT /fechascontables/1.xml
  def update
    @fechascontable = Fechascontable.find(params[:id])

    respond_to do |format|
      if @fechascontable.update_attributes(params[:fechascontable])
        flash[:notice] = 'Fechascontable was successfully updated.'
        format.html { redirect_to(@fechascontable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fechascontable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fechascontables/1
  # DELETE /fechascontables/1.xml
  def destroy
    @fechascontable = Fechascontable.find(params[:id])
    @fechascontable.destroy

    respond_to do |format|
      format.html { redirect_to(fechascontables_url) }
      format.xml  { head :ok }
    end
  end
end
