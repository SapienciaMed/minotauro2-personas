class InfgruposcamposController < ApplicationController
  before_action :set_infgruposcampo, only: [:show, :edit, :update, :destroy]

  # GET /infgruposcampos
  # GET /infgruposcampos.json
  def index
    @infgruposcampos = Infgruposcampo.all
  end

  # GET /infgruposcampos/1
  # GET /infgruposcampos/1.json
  def show
  end

  # GET /infgruposcampos/new
  def new
    @infgruposcampo = Infgruposcampo.new
  end

  # GET /infgruposcampos/1/edit
  def edit
  end

  # POST /infgruposcampos
  # POST /infgruposcampos.json
  def create
    @infgruposcampo = Infgruposcampo.new(infgruposcampo_params)

    respond_to do |format|
      if @infgruposcampo.save
        format.html { redirect_to @infgruposcampo, notice: 'Infgruposcampo was successfully created.' }
        format.json { render :show, status: :created, location: @infgruposcampo }
      else
        format.html { render :new }
        format.json { render json: @infgruposcampo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infgruposcampos/1
  # PATCH/PUT /infgruposcampos/1.json
  def update
    respond_to do |format|
      if @infgruposcampo.update(infgruposcampo_params)
        format.html { redirect_to @infgruposcampo, notice: 'Infgruposcampo was successfully updated.' }
        format.json { render :show, status: :ok, location: @infgruposcampo }
      else
        format.html { render :edit }
        format.json { render json: @infgruposcampo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infgruposcampos/1
  # DELETE /infgruposcampos/1.json
  def destroy
    @infgruposcampo.destroy
    respond_to do |format|
      format.html { redirect_to infgruposcampos_url, notice: 'Infgruposcampo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infgruposcampo
      @infgruposcampo = Infgruposcampo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infgruposcampo_params
      params.require(:infgruposcampo).permit(:infgrupo_id, :orden, :nombre, :campo, :estilo, :tipo, :tamano, :estilo_encabezado)
    end
end
