class DesembolsoscreditosController < ApplicationController
  # GET /desembolsoscreditos
  # GET /desembolsoscreditos.xml
  def index
    @desembolsoscreditos = Desembolsoscredito.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @desembolsoscreditos }
    end
  end

  # GET /desembolsoscreditos/1
  # GET /desembolsoscreditos/1.xml
  def show
    @desembolsoscredito = Desembolsoscredito.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @desembolsoscredito }
    end
  end

  # GET /desembolsoscreditos/new
  # GET /desembolsoscreditos/new.xml
  def new
    @desembolsoscredito = Desembolsoscredito.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @desembolsoscredito }
    end
  end

  # GET /desembolsoscreditos/1/edit
  def edit
    @desembolsoscredito = Desembolsoscredito.find(params[:id])
  end

  # POST /desembolsoscreditos
  # POST /desembolsoscreditos.xml
  def create
    @desembolsoscredito = Desembolsoscredito.new(params[:desembolsoscredito])

    respond_to do |format|
      if @desembolsoscredito.save
        flash[:notice] = 'Desembolsoscredito was successfully created.'
        format.html { redirect_to(@desembolsoscredito) }
        format.xml  { render :xml => @desembolsoscredito, :status => :created, :location => @desembolsoscredito }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @desembolsoscredito.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /desembolsoscreditos/1
  # PUT /desembolsoscreditos/1.xml
  def update
    @desembolsoscredito = Desembolsoscredito.find(params[:id])

    respond_to do |format|
      if @desembolsoscredito.update_attributes(params[:desembolsoscredito])
        flash[:notice] = 'Desembolsoscredito was successfully updated.'
        format.html { redirect_to(@desembolsoscredito) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @desembolsoscredito.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /desembolsoscreditos/1
  # DELETE /desembolsoscreditos/1.xml
  def destroy
    @desembolsoscredito = Desembolsoscredito.find(params[:id])
    @desembolsoscredito.destroy

    respond_to do |format|
      format.html { redirect_to(desembolsoscreditos_url) }
      format.xml  { head :ok }
    end
  end
end
