class HistoricostasasController < ApplicationController
  before_filter :require_user

  def index
    @historicostasas = Historicostasa.find(:all, :order=>"anno")
  end

  def new
    @historicostasa = Historicostasa.new
    render :action => "historicostasa_form"
  end

  def edit
    @historicostasa = Historicostasa.find(params[:id])
    respond_to do |format|
      format.html { render :action => "historicostasa_form" }
    end
  end

  def create
    @historicostasa = Historicostasa.new(params[:historicostasa])
    if @historicostasa.save
      flash[:notice] = "Tasa Creado con Exito."
      redirect_to edit_historicostasa_path(@historicostasa)
    else
      render :action => "historicostasa_form"
     end
  end

  def update
    @historicostasa = Historicostasa.find(params[:id])
    if @historicostasa.update_attributes(params[:historicostasa])
     flash[:notice] = "Tasa Actualizado con Exito."
      redirect_to edit_historicostasa_path(@historicostasa)
    else
      render :action => "historicostasa_form"
    end
  end

  def destroy
    @historicostasa = Historicostasa.find(params[:id])
    @historicostasa.destroy
    respond_to do |format|
      format.html { redirect_to(historicostasas_url) }
      format.xml  { head :ok }
    end
  end

end
