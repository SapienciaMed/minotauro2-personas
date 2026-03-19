class ComitesusersController < ApplicationController
before_filter :require_user
  layout :determine_layout

  def index
    comite   = Comite.find(params[:comite_id])
    @comitesusers = comite.comitesusers.all
  end

 def edit
    @comitesuser  = Comitesuser.find(params[:id], :include => "comite")
    @comite  = @comitesuser.comite
    respond_to do |format|
      format.js { render :action => "edit_comitesuser" }
    end
  end

  def create
    @comite  = Comite.find(params[:comite_id])
    @comitesuser = Comitesuser.new(params[:comitesuser])
    if @comitesuser.valid?
      @comite.comitesusers << @comitesuser
      @comite.save
      @comitesuser = Comitesuser.new
      flash[:comitesuser] = "Creado con exito"
    else
      flash[:comitesuser] = "Se produjo un error al guardar el registro"
    end
    respond_to do |format|
      format.js { render :action => "comitesusers" }
    end
  end

  def update
    @comitesuser        = Comitesuser.new
    comitesuser         = Comitesuser.find(params[:id])
    @comite        = comitesuser.comite
    ok = comitesuser.update_attributes(params[:comitesuser])
    if ok == true
      flash[:benevivienda] = "Actualizado con Exito"
      respond_to do |format|
        format.js { render :action => "comitesusers" }
      end
    else
      render :update do |page|
         page.alert "El registro tiene inconsistencias. Verifique!!"
      end
    end
  end

  def destroy
    comitesuser   = Comitesuser.find(params[:id])
    @comite  = comitesuser.comite
    @comitesuser  = Comitesuser.new
    comitesuser.destroy
    flash[:comitesuser] = "Borrado con exito"
    respond_to do |format|
      format.js { render :action => "comitesusers" }
    end
  end
end