class PlanpagosController < ApplicationController
  before_filter :require_user

  require 'ruby_plsql'
  
  def buscar
    var1 = params[:var1]
    var2 = params[:var2]
    var3 = params[:var3]
    var4 = params[:var4]
    var5 = params[:var5]
    var6 = params[:var6]
    var7 = params[:var7]
    ActiveRecord::Base.connection.execute("truncate table planpagos")
    ActiveRecord::Base.connection.execute("begin prc_planpagos('#{var1.to_s}','#{var2.to_s}','#{var3.to_s}','#{var4.to_s}','#{var5.to_s}','#{var6.to_s}','#{var7.to_s}'); end;")
    @planpagos = Planpago.all
    respond_to do |format|
         format.html
         format.xls if params[:format] == 'xls'
    end
  end

  def index
    @planpagos = Planpago.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @planpagos }
    end
  end

  # GET /planpagos/1
  # GET /planpagos/1.xml
  def show
    @planpago = Planpago.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @planpago }
    end
  end

  # GET /planpagos/new
  # GET /planpagos/new.xml
  def new
    @planpago = Planpago.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @planpago }
    end
  end

  # GET /planpagos/1/edit
  def edit
    @planpago = Planpago.find(params[:id])
  end

  # POST /planpagos
  # POST /planpagos.xml
  def create
    @planpago = Planpago.new(params[:planpago])

    respond_to do |format|
      if @planpago.save
        flash[:notice] = 'Planpago was successfully created.'
        format.html { redirect_to(@planpago) }
        format.xml  { render :xml => @planpago, :status => :created, :location => @planpago }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planpago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /planpagos/1
  # PUT /planpagos/1.xml
  def update
    @planpago = Planpago.find(params[:id])

    respond_to do |format|
      if @planpago.update_attributes(params[:planpago])
        flash[:notice] = 'Planpago was successfully updated.'
        format.html { redirect_to(@planpago) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planpago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /planpagos/1
  # DELETE /planpagos/1.xml
  def destroy
    @planpago = Planpago.find(params[:id])
    @planpago.destroy

    respond_to do |format|
      format.html { redirect_to(planpagos_url) }
      format.xml  { head :ok }
    end
  end
end
