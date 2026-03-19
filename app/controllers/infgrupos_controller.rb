class InfgruposController < ApplicationController
  before_action :set_infgrupo, only: [:show, :edit, :update, :destroy]

  # GET /infgrupos
  # GET /infgrupos.json
  def index
    @infgrupos = Infgrupo.all
  end

  # GET /infgrupos/1
  # GET /infgrupos/1.json
  def show
  end

  # GET /infgrupos/new
  def new
    @infgrupo = Infgrupo.new
  end

  # GET /infgrupos/1/edit
  def edit
  end

  # POST /infgrupos
  # POST /infgrupos.json
  def create
    @infgrupo = Infgrupo.new(infgrupo_params)

    respond_to do |format|
      if @infgrupo.save
        format.html { redirect_to @infgrupo, notice: 'Infgrupo was successfully created.' }
        format.json { render :show, status: :created, location: @infgrupo }
      else
        format.html { render :new }
        format.json { render json: @infgrupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /infgrupos/1
  # PATCH/PUT /infgrupos/1.json
  def update
    respond_to do |format|
      if @infgrupo.update(infgrupo_params)
        format.html { redirect_to @infgrupo, notice: 'Infgrupo was successfully updated.' }
        format.json { render :show, status: :ok, location: @infgrupo }
      else
        format.html { render :edit }
        format.json { render json: @infgrupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /infgrupos/1
  # DELETE /infgrupos/1.json
  def destroy
    @infgrupo.destroy
    respond_to do |format|
      format.html { redirect_to infgrupos_url, notice: 'Infgrupo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_infgrupo
      @infgrupo = Infgrupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def infgrupo_params
      params.require(:infgrupo).permit(:nombre, :nombre_archivo, :estado, :clase, :consulta)
    end
end
