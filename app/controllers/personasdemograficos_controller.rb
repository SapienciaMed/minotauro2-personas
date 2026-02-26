class PersonasdemograficosController < ApplicationController
  # GET /personasdemograficos
  # GET /personasdemograficos.xml
  def index
    @personasdemograficos = Personasdemografico.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @personasdemograficos }
    end
  end

  # GET /personasdemograficos/1
  # GET /personasdemograficos/1.xml
  def show
    @personasdemografico = Personasdemografico.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @personasdemografico }
    end
  end

  # GET /personasdemograficos/new
  # GET /personasdemograficos/new.xml
  def new
    @personasdemografico = Personasdemografico.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @personasdemografico }
    end
  end

  # GET /personasdemograficos/1/edit
  def edit
    @personasdemografico = Personasdemografico.find(params[:id])
  end

  # POST /personasdemograficos
  # POST /personasdemograficos.xml
  def create
    @personasdemografico = Personasdemografico.new(params[:personasdemografico])

    respond_to do |format|
      if @personasdemografico.save
        flash[:notice] = 'Personasdemografico was successfully created.'
        format.html { redirect_to(@personasdemografico) }
        format.xml  { render :xml => @personasdemografico, :status => :created, :location => @personasdemografico }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @personasdemografico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /personasdemograficos/1
  # PUT /personasdemograficos/1.xml
  def update
    @personasdemografico = Personasdemografico.find(params[:id])

    respond_to do |format|
      if @personasdemografico.update_attributes(params[:personasdemografico])
        flash[:notice] = 'Personasdemografico was successfully updated.'
        format.html { redirect_to(@personasdemografico) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @personasdemografico.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /personasdemograficos/1
  # DELETE /personasdemograficos/1.xml
  def destroy
    @personasdemografico = Personasdemografico.find(params[:id])
    @personasdemografico.destroy

    respond_to do |format|
      format.html { redirect_to(personasdemograficos_url) }
      format.xml  { head :ok }
    end
  end
end
