class PersonascodeudoresController < ApplicationController
  before_action :set_persona
  before_action :set_personascodeudores, only: [:show, :edit, :update, :destroy, :autoriza, :noautoriza]

  respond_to :html, :js

  layout :determine_layout

  def show
    respond_to { |format| format.js }
  end

  def new
    @active_record = Personascodeudor.find(params[:active_id]) if params[:active_id].present?
    @personascodeudor = Personascodeudor.new
    respond_to { |format| format.js }
  end

  def edit
    @active_record = Personascodeudor.find(params[:active_id]) if params[:active_id].present?
    respond_to { |format| format.js }
  end

  def create
    @personascodeudor = Personascodeudor.new(personascodeudor_params)
    @personascodeudor.persona_id = @persona.id
    @personascodeudor.user_id = is_admin
    respond_to do |format|
      if @personascodeudor.save
        flash['success'] = 'Creado con exito'
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personascodeudor } }
      end
    end
  end

  def update
    respond_to do |format|
      if @personascodeudor.update(personascodeudor_params)
        flash[:notice] = "#{t :notice_actualiza_msj}"
        format.js
      else
        format.js { render 'layouts/errors', locals: { object: @personascodeudor } }
      end
    end
  end

  def destroy
    @personascodeudor.destroy
    flash['success'] = 'Borrado con exito'
    respond_to { |format| format.js }
  end

   def visualizar
     @personascodeudor  = Personascodeudor.find(params[:id])
   end

  def rpttotal
    @personascodeudores  = Personascodeudor.where("persona_id = #{params[:id]}").order("created_at desc")
  end

  def rptpersonascodeudor
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="Gestiones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    if params[:ubicacion][:fchinicial].to_s != "" and params[:ubicacion][:fchfinal].to_s != ""
      @personascodeudores = Personascodeudor.find_by_sql("select *
                                            from   personascodeudores
                                            where  fecha is null
                                            and    trunc(created_at) between '#{params[:ubicacion][:fchinicial]}' and '#{params[:ubicacion][:fchfinal]}'")
    else
      flash[:notice] = "No hay información"
      redirect_to cargues_path
    end
  end

  private

    def determine_layout
      if ['rptpersonascodeudor','visita'].include?(action_name)
        "excel"
      elsif  ['rpttotal'].include?(action_name)
        "basico"
      else
        "application_admin"
      end
    end

    def set_personascodeudores
      @personascodeudor = Personascodeudor.find(params[:id]) if params[:id]
    end

    def set_persona
      @persona = Persona.find(params[:persona_id])
    end

    def personascodeudor_params
      params.require(:personascodeudor).permit!
    end
end
