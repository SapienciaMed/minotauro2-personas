class ModuloscamposController < ApplicationController
  before_action :set_moduloscampo, only: [:show, :edit, :update, :destroy]

  # GET /moduloscampos
  # GET /moduloscampos.json
  def index
    @moduloscampos = Moduloscampo.all
  end

  # GET /moduloscampos/1
  # GET /moduloscampos/1.json
  def show
  end

  # GET /moduloscampos/new
  def new
    @moduloscampo = Moduloscampo.new
  end

  # GET /moduloscampos/1/edit
  def edit
  end

  # POST /moduloscampos
  # POST /moduloscampos.json
  def create
    @moduloscampo = Moduloscampo.new(moduloscampo_params)

    respond_to do |format|
      if @moduloscampo.save
        format.html { redirect_to @moduloscampo, notice: 'Moduloscampo was successfully created.' }
        format.json { render :show, status: :created, location: @moduloscampo }
      else
        format.html { render :new }
        format.json { render json: @moduloscampo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /moduloscampos/1
  # PATCH/PUT /moduloscampos/1.json
  def update
    respond_to do |format|
      if @moduloscampo.update(moduloscampo_params)
        format.html { redirect_to @moduloscampo, notice: 'Moduloscampo was successfully updated.' }
        format.json { render :show, status: :ok, location: @moduloscampo }
      else
        format.html { render :edit }
        format.json { render json: @moduloscampo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /moduloscampos/1
  # DELETE /moduloscampos/1.json
  def destroy
    @moduloscampo.destroy
    respond_to do |format|
      format.html { redirect_to moduloscampos_url, notice: 'Moduloscampo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_moduloscampo
      @moduloscampo = Moduloscampo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def moduloscampo_params
      params.require(:moduloscampo).permit(:modulo_id, :orden, :encabezado, :campo, :tipo, :detalle)
    end
end
