class PlanespagosController < ApplicationController
  before_filter :require_user
  # GET /planespagos
  # GET /planespagos.xml
  def index
    @planespagos = Planespago.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planespagos }
    end
  end

  # GET /planespagos/1
  # GET /planespagos/1.xml
  def show
    @planespago = Planespago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planespago }
    end
  end

  # GET /planespagos/new
  # GET /planespagos/new.xml
  def new
    @planespago = Planespago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planespago }
    end
  end

  # GET /planespagos/1/edit
  def edit
    @planespago = Planespago.find(params[:id])
  end

  # POST /planespagos
  # POST /planespagos.xml
  def create
    @planespago = Planespago.new(params[:planespago])

    respond_to do |format|
      if @planespago.save
        flash[:notice] = 'Planespago was successfully created.'
        format.html { redirect_to(@planespago) }
        format.xml  { render :xml => @planespago, :status => :created, :location => @planespago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planespago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planespagos/1
  # PUT /planespagos/1.xml
  def update
    @planespago = Planespago.find(params[:id])

    respond_to do |format|
      if @planespago.update_attributes(params[:planespago])
        flash[:notice] = 'Planespago was successfully updated.'
        format.html { redirect_to(@planespago) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planespago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planespagos/1
  # DELETE /planespagos/1.xml
  def destroy
    @planespago = Planespago.find(params[:id])
    @planespago.destroy

    respond_to do |format|
      format.html { redirect_to(planespagos_url) }
      format.xml  { head :ok }
    end
  end
end
