class ActasController < ApplicationController
  # GET /actas
  # GET /actas.xml
  def index
    @actas = Acta.all

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @actas }
    end
  end

  # GET /actas/1
  # GET /actas/1.xml
  def show
    @acta = Acta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @acta }
    end
  end

  # GET /actas/new
  # GET /actas/new.xml
  def new
    @acta = Acta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @acta }
    end
  end

  # GET /actas/1/edit
  def edit
    @acta = Acta.find(params[:id])
  end

  # POST /actas
  # POST /actas.xml
  def create
    @acta = Acta.new(params[:acta])

    respond_to do |format|
      if @acta.save
        flash[:notice] = 'Acta was successfully created.'
        format.html { redirect_to(@acta) }
        format.xml  { render :xml => @acta, :status => :created, :location => @acta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @acta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /actas/1
  # PUT /actas/1.xml
  def update
    @acta = Acta.find(params[:id])

    respond_to do |format|
      if @acta.update_attributes(params[:acta])
        flash[:notice] = 'Acta was successfully updated.'
        format.html { redirect_to(@acta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @acta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /actas/1
  # DELETE /actas/1.xml
  def destroy
    @acta = Acta.find(params[:id])
    @acta.destroy

    respond_to do |format|
      format.html { redirect_to(actas_url) }
      format.xml  { head :ok }
    end
  end
end
