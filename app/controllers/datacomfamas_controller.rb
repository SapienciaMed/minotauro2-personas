class DatacomfamasController < ApplicationController
  # GET /datacomfamas
  # GET /datacomfamas.xml
  def index
    @datacomfamas = Datacomfama.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datacomfamas }
    end
  end

  # GET /datacomfamas/1
  # GET /datacomfamas/1.xml
  def show
    @datacomfama = Datacomfama.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @datacomfama }
    end
  end

  # GET /datacomfamas/new
  # GET /datacomfamas/new.xml
  def new
    @datacomfama = Datacomfama.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @datacomfama }
    end
  end

  # GET /datacomfamas/1/edit
  def edit
    @datacomfama = Datacomfama.find(params[:id])
  end

  # POST /datacomfamas
  # POST /datacomfamas.xml
  def create
    @datacomfama = Datacomfama.new(params[:datacomfama])

    respond_to do |format|
      if @datacomfama.save
        flash[:notice] = 'Datacomfama was successfully created.'
        format.html { redirect_to(@datacomfama) }
        format.xml  { render :xml => @datacomfama, :status => :created, :location => @datacomfama }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @datacomfama.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /datacomfamas/1
  # PUT /datacomfamas/1.xml
  def update
    @datacomfama = Datacomfama.find(params[:id])

    respond_to do |format|
      if @datacomfama.update_attributes(params[:datacomfama])
        flash[:notice] = 'Datacomfama was successfully updated.'
        format.html { redirect_to(@datacomfama) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @datacomfama.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /datacomfamas/1
  # DELETE /datacomfamas/1.xml
  def destroy
    @datacomfama = Datacomfama.find(params[:id])
    @datacomfama.destroy

    respond_to do |format|
      format.html { redirect_to(datacomfamas_url) }
      format.xml  { head :ok }
    end
  end
end
