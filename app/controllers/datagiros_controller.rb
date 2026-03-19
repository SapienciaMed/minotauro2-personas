class DatagirosController < ApplicationController
  # GET /datagiros
  # GET /datagiros.xml
  def index
    @datagiros = Datagiro.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @datagiros }
    end
  end

  # GET /datagiros/1
  # GET /datagiros/1.xml
  def show
    @datagiro = Datagiro.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @datagiro }
    end
  end

  # GET /datagiros/new
  # GET /datagiros/new.xml
  def new
    @datagiro = Datagiro.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @datagiro }
    end
  end

  # GET /datagiros/1/edit
  def edit
    @datagiro = Datagiro.find(params[:id])
  end

  # POST /datagiros
  # POST /datagiros.xml
  def create
    @datagiro = Datagiro.new(params[:datagiro])

    respond_to do |format|
      if @datagiro.save
        flash[:notice] = 'Datagiro was successfully created.'
        format.html { redirect_to(@datagiro) }
        format.xml  { render :xml => @datagiro, :status => :created, :location => @datagiro }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @datagiro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /datagiros/1
  # PUT /datagiros/1.xml
  def update
    @datagiro = Datagiro.find(params[:id])

    respond_to do |format|
      if @datagiro.update_attributes(params[:datagiro])
        flash[:notice] = 'Datagiro was successfully updated.'
        format.html { redirect_to(@datagiro) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @datagiro.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /datagiros/1
  # DELETE /datagiros/1.xml
  def destroy
    @datagiro = Datagiro.find(params[:id])
    @datagiro.destroy

    respond_to do |format|
      format.html { redirect_to(datagiros_url) }
      format.xml  { head :ok }
    end
  end
end
