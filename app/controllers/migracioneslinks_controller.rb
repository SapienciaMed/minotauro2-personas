class MigracioneslinksController < ApplicationController
  before_action :set_migracioneslink, only: [:show, :edit, :update, :destroy]

  def cargar
    isadmin = is_admin
    @archivo = Archivo.find(params[:id])
    @consecutivo = is_consmig
    Migracioneslink.importar(params[:ruta],isadmin,@consecutivo,@archivo.id)
    #Ejecucion.create(portafolio_id: isportafolio, user_id: isadmin, descripcion: prcExecute, inicioejecucion: Time.now, finejecucion: Time.now, estado: 'PENDIENTE', tiempoejecucion: 1)
    flash[:notice] = 'El proceso se ha realizado con exito'
    redirect_to cargues_archivos_path
  end

  private
  def set_migracioneslink
    @migracioneslink = Migracioneslink.find(params[:id])
  end

  def migracioneslink_params
    params.require(:migracioneslink).permit!
  end

end
