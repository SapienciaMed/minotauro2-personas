class PlanesController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :checkaccess

  def checkaccess
    return is_permit('planes')
  end

  #require 'ruby_plsql'

  def param
    fecha = params[:ubicacion][:fecha]
    ActiveRecord::Base.connection.execute("update param set fecha = '#{fecha.to_date}'")
    flash[:notice] = 'Fecha Actualizada'
    redirect_to personas_path
  end

  def index
    @planes = Plan.all.order('id')
  end

  def show
  end

  def new
    @plan = Plan.new
  end

  def edit
  end

  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        flash[:notice] = 'Plan was successfully created.'
        format.html { redirect_to(@plan) }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @plan.update(plan_params)
        flash[:notice] = 'Plan was successfully updated.'
        format.html { redirect_to(@plan) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to(planes_url) }
    end
  end

  private

    def set_plan
      @plan = Plan.find(params[:id])
    end

    def plan_params
      params.require(:plan).permit!
    end
end
