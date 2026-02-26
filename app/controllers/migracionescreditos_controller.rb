class MigracionescreditosController < ApplicationController
  # GET /migracionescreditos
  # GET /migracionescreditos.xml
  def index
    @migracionescreditos = Migracionescredito.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @migracionescreditos }
    end
  end

  # GET /migracionescreditos/1
  # GET /migracionescreditos/1.xml
  def show
    @migracionescredito = Migracionescredito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @migracionescredito }
    end
  end

  # GET /migracionescreditos/new
  # GET /migracionescreditos/new.xml
  def new
    @migracionescredito = Migracionescredito.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @migracionescredito }
    end
  end

  # GET /migracionescreditos/1/edit
  def edit
    @migracionescredito = Migracionescredito.find(params[:id])
  end

  # POST /migracionescreditos
  # POST /migracionescreditos.xml
  def create
    @migracionescredito = Migracionescredito.new(params[:migracionescredito])

    respond_to do |format|
      if @migracionescredito.save
        format.html { redirect_to(@migracionescredito, :notice => 'Migracionescredito was successfully created.') }
        format.xml  { render :xml => @migracionescredito, :status => :created, :location => @migracionescredito }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @migracionescredito.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /migracionescreditos/1
  # PUT /migracionescreditos/1.xml
  def update
    @migracionescredito = Migracionescredito.find(params[:id])

    respond_to do |format|
      if @migracionescredito.update_attributes(params[:migracionescredito])
        format.html { redirect_to(@migracionescredito, :notice => 'Migracionescredito was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @migracionescredito.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /migracionescreditos/1
  # DELETE /migracionescreditos/1.xml
  def destroy
    @migracionescredito = Migracionescredito.find(params[:id])
    @migracionescredito.destroy

    respond_to do |format|
      format.html { redirect_to(migracionescreditos_url) }
      format.xml  { head :ok }
    end
  end
end
