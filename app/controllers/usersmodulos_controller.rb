class UsersmodulosController < ApplicationController

  before_filter :require_user

  def index
    user   = User.find(params[:user_id])
    @usersmodulos = user.usersmodulos.all
  end

  def edit
    @usersmodulo  = Usersmodulo.find(params[:id], :include => "user")
    @user  = @usersmodulo.user
    respond_to do |format|
      format.js { render :action => "edit_usersmodulo" }
    end
  end

  def create
    @user  = User.find(params[:user_id])
    @usersmodulo = Usersmodulo.new(params[:usersmodulo])
    if @usersmodulo.valid?
      @user.usersmodulos << @usersmodulo
      @user.save
      @usersmodulo = Usersmodulo.new
    else
      flash[:warning] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end

  def update
    @usersmodulo        = Usersmodulo.new
    usersmodulo         = Usersmodulo.find(params[:id])
    @user        = usersmodulo.user
    ok = usersmodulo.update_attributes(params[:usersmodulo])
    flash[:notice] = ok ? "Usuario asociado Correctamente." : "Se produjo un error al Asociar"
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end

  def destroy
    usersmodulo   = Usersmodulo.find(params[:id])
    @user  = usersmodulo.user
    @usersmodulo  = Usersmodulo.new
    usersmodulo.destroy
    respond_to do |format|
      format.js { render :action => "usersmodulos" }
    end
  end
end

#  before_filter :require_user
#
#  def index
#    @usersmodulos = Usersmodulo.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.xml  { render :xml => @usersmodulos }
#    end
#  end
#
#  # GET /usersmodulos/1
#  # GET /usersmodulos/1.xml
#  def show
#    @usersmodulo = Usersmodulo.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.xml  { render :xml => @usersmodulo }
#    end
#  end
#
#  # GET /usersmodulos/new
#  # GET /usersmodulos/new.xml
#  def new
#    @usersmodulo = Usersmodulo.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.xml  { render :xml => @usersmodulo }
#    end
#  end
#
#  # GET /usersmodulos/1/edit
#  def edit
#    @usersmodulo = Usersmodulo.find(params[:id])
#  end
#
#  # POST /usersmodulos
#  # POST /usersmodulos.xml
#  def create
#    @usersmodulo = Usersmodulo.new(params[:usersmodulo])
#
#    respond_to do |format|
#      if @usersmodulo.save
#        flash[:notice] = 'Usersmodulo was successfully created.'
#        format.html { redirect_to(@usersmodulo) }
#        format.xml  { render :xml => @usersmodulo, :status => :created, :location => @usersmodulo }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @usersmodulo.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /usersmodulos/1
#  # PUT /usersmodulos/1.xml
#  def update
#    @usersmodulo = Usersmodulo.find(params[:id])
#
#    respond_to do |format|
#      if @usersmodulo.update_attributes(params[:usersmodulo])
#        flash[:notice] = 'Usersmodulo was successfully updated.'
#        format.html { redirect_to(@usersmodulo) }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @usersmodulo.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /usersmodulos/1
#  # DELETE /usersmodulos/1.xml
#  def destroy
#    @usersmodulo = Usersmodulo.find(params[:id])
#    @usersmodulo.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(usersmodulos_url) }
#      format.xml  { head :ok }
#    end
#  end
#end
