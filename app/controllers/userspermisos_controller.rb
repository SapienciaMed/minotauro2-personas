class UserspermisosController < ApplicationController

  before_filter :require_user

  def index
    user   = User.find(params[:user_id])
    @userspermisos = user.userspermisos.all
  end

  def edit
    @userspermiso  = Userspermiso.find(params[:id], :include => "user")
    @user  = @userspermiso.user
    respond_to do |format|
      format.js { render :action => "edit_userspermiso" }
    end
  end

  def create
    @user  = User.find(params[:user_id])
    @userspermiso = Userspermiso.new(params[:userspermiso])
    if @userspermiso.valid?
      @user.userspermisos << @userspermiso
      @user.save
      @userspermiso = Userspermiso.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end

  def update
    @userspermiso        = Userspermiso.new
    userspermiso         = Userspermiso.find(params[:id])
    @user        = userspermiso.user
    ok = userspermiso.update_attributes(params[:userspermiso])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end

  def destroy
    userspermiso   = Userspermiso.find(params[:id])
    @user  = userspermiso.user
    @userspermiso  = Userspermiso.new
    userspermiso.destroy
    respond_to do |format|
      format.js { render :action => "userspermisos" }
    end
  end
end

#
## GET /userspermisos
#  # GET /userspermisos.xml
#  def index
#    @userspermisos = Userspermiso.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @userspermisos }
#    end
#  end
#
#  # GET /userspermisos/1
#  # GET /userspermisos/1.xml
#  def show
#    @userspermiso = Userspermiso.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @userspermiso }
#    end
#  end
#
#  # GET /userspermisos/new
#  # GET /userspermisos/new.xml
#  def new
#    @userspermiso = Userspermiso.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @userspermiso }
#    end
#  end
#
#  # GET /userspermisos/1/edit
#  def edit
#    @userspermiso = Userspermiso.find(params[:id])
#  end
#
#  # POST /userspermisos
#  # POST /userspermisos.xml
#  def create
#    @userspermiso = Userspermiso.new(params[:userspermiso])
#
#    respond_to do |format|
#      if @userspermiso.save
#        flash[:notice] = 'Userspermiso was successfully created.'
#        format.html { redirect_to(@userspermiso) }
#        format.xml  { render :xml => @userspermiso, :status => :created, :location => @userspermiso }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @userspermiso.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /userspermisos/1
#  # PUT /userspermisos/1.xml
#  def update
#    @userspermiso = Userspermiso.find(params[:id])
#
#    respond_to do |format|
#      if @userspermiso.update_attributes(params[:userspermiso])
#        flash[:notice] = 'Userspermiso was successfully updated.'
#        format.html { redirect_to(@userspermiso) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @userspermiso.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /userspermisos/1
#  # DELETE /userspermisos/1.xml
#  def destroy
#    @userspermiso = Userspermiso.find(params[:id])
#    @userspermiso.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(userspermisos_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
