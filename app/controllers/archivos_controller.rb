class ArchivosController < ApplicationController
  layout :set_layout
  before_action :set_archivo, only: [:show, :edit, :update, :destroy]
  require 'rubygems'
  require 'roo'

  def index
    @q = Archivo.ransack(params[:q])
    @archivos = @q.result.paginate(:page => params[:page], :per_page => 10).order("id desc")
    respond_to do |format|
      format.html
    end
  end

  def show
  end

  def get_tipoproceso
    @proceso = params[:archivo_proceso]
    @tipoarchivo = 'EXCEL'#Modulo.where(imagenmin: @proceso).last.tipo_archivo rescue nil
    respond_to { |format| format.js }
  end

  def cargues
    isadmin ||= is_admin
    @archivo = Archivo.new
    @select_cargues = Usersmodulo.joins(:modulo).where(["usersmodulos.user_id = ? and modulos.nivel = ? and modulos.imagenmin is not null", isadmin, 2]).select("modulos.*").order("modulos.descripcion")
    @query ||= @select_cargues.map { |m| [m.descripcion, m.imagenmin] }
  end

  def headxls
    @clase = params[:clase].to_s
    @moduloid = params[:modulo_id].to_s
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Mino_Encabezados_' + "#{Time.now.strftime("%Y%m%d_%X")}" + '.xlsx"'
      }
    end
  end

  def inconsistenciasgen
    moduloid = params[:modulo_id]
    cons = params[:cons]
    modulo = Modulo.find(moduloid).to_s rescue nil
    @moduloscampos = Moduloscampo.where(["modulo_id = #{moduloid}"]).order("orden asc")
    @mconerror = Objeto.find_by_sql("SELECT * FROM #{modulo.tabla.to_s} where consecutivo = #{cons} and error is not null ORDER BY id DESC")
    @nombreinforme = modulo.descripcion.to_s rescue nil
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = 'attachment; filename="Mino_Inconsistencias_' + "#{Time.now.strftime("%Y%m%d_%X")}" + '.xlsx"'
      }
    end
  end

  def new
    @archivo = Archivo.new
    @archivo.proceso = params[:var1]
    render action: "archivo_form"
  end

  def edit
    @archivo = Archivo.find(params[:id])
    respond_to do |format|
      format.html { render action: "archivo_form" }
    end
  end

  def informe
    @archivo = Archivo.find(params[:id])
  end

  def create
    @archivo = Archivo.new(archivo_params)
    @archivo.upload_file_name = sanitize_filename(@archivo.upload_file_name)
    @archivo.user_id = is_admin
    respond_to do |format|
      if @archivo.save
        archivo = @archivo.upload_file_name
        name =  archivo
        directory = "#{::Rails.root}/public/system/uploades/#{@archivo.id}/original/"
        extensionarchivo = archivo.slice(archivo.rindex("."), archivo.length).downcase
        n = File.basename(name, extensionarchivo) rescue nil
        alianza = @alianza_id
        path1 = File.join(directory, n)
        path2 = File.join(directory, name)
        if @archivo.proceso.to_s == 'CARGUELINK'
          format.html { redirect_to cargar_migracioneslinks_path(id: @archivo.id, ruta: path2, tipocargue: @archivo.proceso.to_s)}
        end
      else
        render action: "archivo_form"
      end
    end
  end

  def download_ctl
    @archivo = Archivo.find(params[:id])
    name = @archivo.upload_file_name
    ruta = "#{::Rails.root}/public/system/uploades/#{@archivo.id}/original/#{name}"
    send_file ruta, x_sendfile: true
  end


  private

  def set_layout
    if User.find(is_admin).persona_id.to_s == ""
      "application_admin"
    else
      'application'
    end
  end

  def set_archivo
    @archivo = Archivo.find(params[:id])
  end

  def archivo_params
    params.require(:archivo).permit!
  end

  def sanitize_filename(filename)
    filename = filename.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
    filename = filename.tr('ñÑáéíóúÁÉÍÓÚ', 'nNaeiouAEIOU')
    filename = filename.strip
    filename = filename.gsub(/[^\w\s\.\-]/, '')
    filename = filename.gsub(/\s+/, '_')
    filename
  end
end
