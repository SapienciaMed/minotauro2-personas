class HistoricostasasusurasController < ApplicationController
  before_filter :require_user

  def index
    @historicostasasusuras = Historicostasasusura.find(:all, :order=>"anno,mes")
  end

  def new
    @historicostasasusura = Historicostasasusura.new
    render :action => "historicostasasusura_form"
  end

  def edit
    @historicostasasusura = Historicostasasusura.find(params[:id])
    respond_to do |format|
      format.html { render :action => "historicostasasusura_form" }
    end
  end

  def create
    @historicostasasusura = Historicostasasusura.new(params[:historicostasasusura])
    if @historicostasasusura.save
      flash[:notice] = "Tasa Creado con Exito."
      redirect_to edit_historicostasasusura_path(@historicostasasusura)
    else
      render :action => "historicostasasusura_form"
     end
  end

  def update
    @historicostasasusura = Historicostasasusura.find(params[:id])
    if @historicostasasusura.update_attributes(params[:historicostasasusura])
     flash[:notice] = "Tasa Actualizado con Exito."
      redirect_to edit_historicostasasusura_path(@historicostasasusura)
    else
      render :action => "historicostasasusura_form"
    end
  end

  def destroy
    @historicostasasusura = Historicostasasusura.find(params[:id])
    @historicostasasusura.destroy
    respond_to do |format|
      format.html { redirect_to(historicostasasusuras_url) }
      format.xml  { head :ok }
    end
  end

end
