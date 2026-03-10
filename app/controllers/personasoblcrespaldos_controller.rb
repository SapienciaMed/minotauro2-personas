class PersonasoblcrespaldosController < ApplicationController
  # GET /personasoblcrespaldos
  # GET /personasoblcrespaldos.xml
  def index
    @personasoblcrespaldos = Personasoblcrespaldo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personasoblcrespaldos }
    end
  end

  # GET /personasoblcrespaldos/1
  # GET /personasoblcrespaldos/1.xml
  def show
    @personasoblcrespaldo = Personasoblcrespaldo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @personasoblcrespaldo }
    end
  end

  # GET /personasoblcrespaldos/new
  # GET /personasoblcrespaldos/new.xml
  def new
    @personasoblcrespaldo = Personasoblcrespaldo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasoblcrespaldo }
    end
  end

  # GET /personasoblcrespaldos/1/edit
  def edit
    @personasoblcrespaldo = Personasoblcrespaldo.find(params[:id])
  end

  # POST /personasoblcrespaldos
  # POST /personasoblcrespaldos.xml
  def create
    @personasoblcrespaldo = Personasoblcrespaldo.new(params[:personasoblcrespaldo])

    respond_to do |format|
      if @personasoblcrespaldo.save
        format.html { redirect_to(@personasoblcrespaldo, :notice => 'Personasoblcrespaldo was successfully created.') }
        format.xml  { render :xml => @personasoblcrespaldo, :status => :created, :location => @personasoblcrespaldo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasoblcrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /personasoblcrespaldos/1
  # PUT /personasoblcrespaldos/1.xml
  def update
    @personasoblcrespaldo = Personasoblcrespaldo.find(params[:id])

    respond_to do |format|
      if @personasoblcrespaldo.update_attributes(params[:personasoblcrespaldo])
        format.html { redirect_to(@personasoblcrespaldo, :notice => 'Personasoblcrespaldo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personasoblcrespaldo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personasoblcrespaldos/1
  # DELETE /personasoblcrespaldos/1.xml
  def destroy
    @personasoblcrespaldo = Personasoblcrespaldo.find(params[:id])
    @personasoblcrespaldo.destroy

    respond_to do |format|
      format.html { redirect_to(personasoblcrespaldos_url) }
      format.xml  { head :ok }
    end
  end
end
