class InformescontablesController < ApplicationController
  # GET /informescontables
  # GET /informescontables.xml
  def index
    @informescontables = Informescontable.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @informescontables }
    end
  end

  # GET /informescontables/1
  # GET /informescontables/1.xml
  def show
    @informescontable = Informescontable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @informescontable }
    end
  end

  # GET /informescontables/new
  # GET /informescontables/new.xml
  def new
    @informescontable = Informescontable.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @informescontable }
    end
  end

  # GET /informescontables/1/edit
  def edit
    @informescontable = Informescontable.find(params[:id])
  end

  # POST /informescontables
  # POST /informescontables.xml
  def create
    @informescontable = Informescontable.new(params[:informescontable])

    respond_to do |format|
      if @informescontable.save
        flash[:notice] = 'Informescontable was successfully created.'
        format.html { redirect_to(@informescontable) }
        format.xml  { render :xml => @informescontable, :status => :created, :location => @informescontable }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @informescontable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /informescontables/1
  # PUT /informescontables/1.xml
  def update
    @informescontable = Informescontable.find(params[:id])

    respond_to do |format|
      if @informescontable.update_attributes(params[:informescontable])
        flash[:notice] = 'Informescontable was successfully updated.'
        format.html { redirect_to(@informescontable) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @informescontable.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /informescontables/1
  # DELETE /informescontables/1.xml
  def destroy
    @informescontable = Informescontable.find(params[:id])
    @informescontable.destroy

    respond_to do |format|
      format.html { redirect_to(informescontables_url) }
      format.xml  { head :ok }
    end
  end
end
