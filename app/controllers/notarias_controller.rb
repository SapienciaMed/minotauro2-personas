class NotariasController < ApplicationController
  # GET /notarias
  # GET /notarias.xml
  def index
    @notarias = Notaria.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notarias }
    end
  end

  # GET /notarias/1
  # GET /notarias/1.xml
  def show
    @notaria = Notaria.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @notaria }
    end
  end

  # GET /notarias/new
  # GET /notarias/new.xml
  def new
    @notaria = Notaria.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @notaria }
    end
  end

  # GET /notarias/1/edit
  def edit
    @notaria = Notaria.find(params[:id])
  end

  # POST /notarias
  # POST /notarias.xml
  def create
    @notaria = Notaria.new(params[:notaria])

    respond_to do |format|
      if @notaria.save
        flash[:notice] = 'Notaria was successfully created.'
        format.html { redirect_to(@notaria) }
        format.xml  { render :xml => @notaria, :status => :created, :location => @notaria }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @notaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /notarias/1
  # PUT /notarias/1.xml
  def update
    @notaria = Notaria.find(params[:id])

    respond_to do |format|
      if @notaria.update_attributes(params[:notaria])
        flash[:notice] = 'Notaria was successfully updated.'
        format.html { redirect_to(@notaria) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @notaria.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notarias/1
  # DELETE /notarias/1.xml
  def destroy
    @notaria = Notaria.find(params[:id])
    @notaria.destroy

    respond_to do |format|
      format.html { redirect_to(notarias_url) }
      format.xml  { head :ok }
    end
  end
end
