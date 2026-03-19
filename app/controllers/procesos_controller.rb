class ProcesosController < ApplicationController
  before_filter :require_user
  layout :determine_layout
  require 'csv'
  require 'oci8'
  require 'ruby_plsql'

  require 'ruby_plsql'

  def sygma_infrecdetallados
    fecha_inicio = params[:ubicacion][:fecha_inicio]
    fecha_fin = params[:ubicacion][:fecha_fin]
    if fecha_inicio.to_s != "" and fecha_fin.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_sygma_infrecdetallados('#{fecha_inicio.to_date}','#{fecha_fin.to_date}'); end;")
      @datos = Objeto.find_by_sql("select * from infrecaudosdetallados order by fecha_recaudo")
      #headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="InfoRecDetallados_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
        format.xls
      end
    else
      flash[:notice] = 'Debe diligencias los datos completos para la consulta'
      redirect_to procesos_path
    end
  end

  def sygma_infrecconsol
    ActiveRecord::Base.connection.execute("begin prc_sygma_infrecconsol; end;")
    @datos = Objeto.find_by_sql("select * from infrecaudosdetallados order by fecha_recaudo")
    #headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="InfoRecConsolidado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    respond_to do |format|
      format.xls
    end
  end

  def sygma_infobservaciones
    fecha_inicio = params[:ubicacion][:fecha_inicio]
    fecha_fin = params[:ubicacion][:fecha_fin]
    if fecha_inicio.to_s != "" and fecha_fin.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_sygma_infobservaciones('#{fecha_inicio.to_date}','#{fecha_fin.to_date}'); end;")
      @datos = Objeto.find_by_sql("select * from infobservaciones order by nombre")
      @datos2 = Objeto.find_by_sql("select * from infobservaciones_det order by nombre_completo")
      #headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="InfoObservaciones_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
        format.xls
      end
    else
      flash[:notice] = 'Debe diligencias los datos completos para la consulta'
      redirect_to procesos_path
    end
  end

  def sygma_infestadocontable
    anno = params[:ubicacion][:anno]
    mes = params[:ubicacion][:mes]
    if anno.to_s != "" and mes.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_sygma_infestadocontable('#{anno.to_s}-#{mes.to_s}'); end;")
      @datos = Objeto.find_by_sql("select * from infestadocontable order by nombre")
      #headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="InfoEstadoContable_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
        format.xls
      end
    else
      flash[:notice] = 'Debe diligencias los datos completos para la consulta'
      redirect_to procesos_path
    end
  end

  def sygma_costoamortizado
    anno = params[:ubicacion][:anno]
    mes = params[:ubicacion][:mes]
    if anno.to_s != "" and mes.to_s != ""
      @datos = Objeto.find_by_sql("select * from vpninforme
                                   where periodo = '#{anno.to_s}-#{mes.to_s}'
                                   and periodo <= to_char(trunc(sysdate),'YYYY-MM')
                                   and personasobligacion_id not in (select a.personasobligacion_id
                                                                 from   (select personasobligacion_id, sum(nvl(amortiza,0)) valor
                                                                         from  planesobligaciones
                                                                         group by personasobligacion_id) a
                                                                 where a.valor = 0) order by nro_obligacion")
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="InfoCostoAmortizado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
        format.xls
      end
    else
      flash[:notice] = 'Debe diligencias los datos completos para la consulta'
      redirect_to procesos_path
    end
  end

  def sygma_costodamortizado
    anno = params[:ubicacion][:anno]
    if anno.to_s != ""
      @datos = Objeto.find_by_sql("select * from vpninforme
                                   where  to_char(fecha_matricula,'YYYY') = '#{anno.to_s}'
                                   and    personasobligacion_id not in (select a.personasobligacion_id
                                                                    from   (select personasobligacion_id, sum(nvl(amortiza,0)) valor
                                                                            from  planesobligaciones
                                                                            group by personasobligacion_id) a
                                                                    where a.valor = 0) order by nro_obligacion, alturacredito")
      headers['Content-Type'] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="InfoCostoDetAmortizado_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
      headers['Cache-Control'] = 'max-age=0'
      headers['pragma']="public"
      respond_to do |format|
        format.xls
      end
    else
      flash[:notice] = 'Debe diligencias los datos completos para la consulta'
      redirect_to procesos_path
    end
  end

  def sygma_infdavivienda
    ActiveRecord::Base.connection.execute("begin prc_sygma_infdavivienda; end;")
    @datos = Objeto.find_by_sql("select dato from infdavivienda")
    rutaupload = "#{::Rails.root}/public/archivos/Davivienda_#{Time.now.strftime("%Y%m%d")}.txt"
    File.delete(rutaupload) rescue nil
    File.open(rutaupload, "w") do |the_file|
      @datos.each do |dat|
        the_file.write dat.dato.to_s + "\r\n"
      end
      the_file.close
    end
    send_file rutaupload, :type => "text/plain"#, :x_sendfile => true
  end

  def sygma_informecartera
    puts "-----------------------------SALIDA 0 --> " + Time.now.strftime('%Y%M%D-%X')
    ActiveRecord::Base.connection.execute("begin prc_sygma_informecartera; end;")
    puts "-----------------------------SALIDA 1 --> " + Time.now.strftime('%Y%M%D-%X')
    @datos = Objeto.find_by_sql("select * from informe_cartera")
    puts "-----------------------------SALIDA 2 --> " + Time.now.strftime('%Y%M%D-%X')
    #headers['Content-Type'] = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="InfoCartera_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    respond_to do |format|
      format.xls
    end
    puts "-----------------------------SALIDA 3 --> " + Time.now.strftime('%Y%M%D-%X')
  end

  def sygmadownload
  end

  def sygmarchivo
    send_file params[:ruta].to_s, :type => "application/zip", :disposition => "attachment"
  end

  def sygma_infcontrol
    ActiveRecord::Base.connection.execute("begin prc_sygma_infcontroles; end;")
    @datos = Objeto.find_by_sql("select * from infcontroles order by persona_id")
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="InfoJuridico_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
    respond_to do |format|
      format.xls
    end
  end

  def param
    fecha = params[:ubicacion][:fecha]
    ActiveRecord::Base.connection.execute("update param set fecha = '#{fecha.to_date}'")
    flash[:notice] = 'Fecha Actualizada'
    redirect_to procesos_path
  end

  def reversar
    ActiveRecord::Base.connection.execute("begin prc_reversar; end;")
    flash[:notice] = 'Ultimo Pago reversado'
    redirect_to procesos_path
  end

  def recaudo
    var1 = params[:var1]
    if var1.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_recaudo(#{var1.to_i}); end;")
      flash[:notice] = 'Recaudo realizado'
    end
    redirect_to procesos_path
  end

  def mora
    ActiveRecord::Base.connection.execute("begin prc_obligacionmora; end;")
    flash[:notice] = 'Mora generada'
    redirect_to procesos_path
  end

  def morafecha
    var1 = params[:ubicacion][:fch]
    if var1.to_s != ""
      ActiveRecord::Base.connection.execute("begin prc_obligacionmoraf('#{var1}'); end;")
      flash[:notice] = 'Mora generada para la fecha '+var1
    else
      flash[:notice] = 'Debe registrar la Fecha.....'
    end
    redirect_to procesos_path
  end

  def buscar
    var1 = params[:var1]
    var2 = params[:var2]
    var3 = params[:var3]
    var4 = params[:var4]
    ActiveRecord::Base.connection.execute("delete from planes")
    ActiveRecord::Base.connection.execute("begin prc_plan('#{var1.to_s}','#{var2.to_s}','#{var3.to_s}'); end;")
    flash[:notice] = 'Plan de pago creado exitosamente....'
    redirect_to procesos_path
  end

  def solicitudes
    @consecutivo = Objeto.find_by_sql("select consecutivos_seq.nextval consecutivo from dual")[0].consecutivo rescue 0
    isadmin = is_admin
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
      # crear el archivo
      File.open(path, "wb") { |f| f.write(archivo.read) }
      file = File.open(path, "rb")
      file.each do |line|
        d1,d2,d3,d4 = line.strip.split(";")
        ActiveRecord::Base.connection.execute("insert into solicitudestmp (consecutivo,user_id,nro_obligacion,fecha_inicio_proceso,termino,observacion)
                                               values (#{@consecutivo},#{isadmin},#{d1},'#{d2.to_date}',#{d3},'#{d4.to_s}')")
      end
      file.close
      ActiveRecord::Base.connection.execute("begin prc_sygma_solicitudesmasive(#{@consecutivo}); end;")
      @solicitudestmp = Objeto.find_by_sql("select * from solicitudestmp where consecutivo = #{@consecutivo}")
      flash[:temporal] = 'Archivo Cargado con Exito...'
    else
      flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../procesos/import">Aqui</a> para regresar'
    end
  end

  def creditos
    @consecutivo = Objeto.find_by_sql("select consecutivos_seq.nextval consecutivo from dual")[0].consecutivo rescue 0
    isadmin = is_admin
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
      # crear el archivo
      File.open(path, "wb") { |f| f.write(archivo.read) }
      file = File.open(path, "rb")
      file.each do |line|
        d1,d2_1,d2_2,d2_3,d2_4,d3,d4,d5,d6,d7,d8,d9,d10,d11,d12,d13,d14,d15,d16,d17,d18,d19,d20,d21,d22 = line.strip.split(";")
        begin
          ActiveRecord::Base.connection.execute("insert into migracionescreditos (consecutivo,user_cargue,nro_obligacion,primer_nombre,segundo_nombre,primer_apellido,segundo_apellido,tipodocumento,identificacion,estado_juridico,direccion,ciudad,departamento,nombre_solidario,direccion_solidario,ciudad_solidario,departamento_solidario,valor,tasa_final,ipc,spread,plazo,fecha_matricula,pac,asesor,tasa_mercado,tasa_mora)
                                               values (#{@consecutivo},#{isadmin},'#{d1.to_s}','#{d2_1.to_s}','#{d2_2.to_s}','#{d2_3.to_s}','#{d2_4.to_s}','#{d3.to_s}','#{d4.to_s}','#{d5.to_s}','#{d6.to_s}','#{d7.to_s}','#{d8.to_s}','#{d9.to_s}','#{d10.to_s}','#{d11.to_s}','#{d12.to_s}','#{d13}','#{d14.gsub(',','.')}','#{d15.gsub(',','.')}','#{d16.gsub(',','.')}','#{d17}',to_date('#{d18.to_s}','dd-mm-yyyy'),'#{d19.to_s}','#{d20.to_s}','#{d21.gsub(',','.')}','#{d22.gsub(',','.')}')")
        rescue Exception => exc
          logger.error("Problemas con cargue de archivo")
        end
      end
      file.close
      ActiveRecord::Base.connection.execute("begin prc_sygma_migracionescredito(#{@consecutivo},'CREDITOS'); end;")
      @datos = Objeto.find_by_sql("select * from migracionescreditos where consecutivo = #{@consecutivo}")
      flash[:temporal] = 'Archivo Cargado con Exito...'
    else
      flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../procesos/import">Aqui</a> para regresar'
    end
  end

  def asesores
    @consecutivo = Objeto.find_by_sql("select consecutivos_seq.nextval consecutivo from dual")[0].consecutivo rescue 0
    isadmin = is_admin
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
      # crear el archivo
      File.open(path, "wb") { |f| f.write(archivo.read) }
      file = File.open(path, "rb")
      file.each do |line|
        d1,d2 = line.strip.split(";")
        begin
          ActiveRecord::Base.connection.execute("insert into migracionescreditos (consecutivo,user_cargue,nro_obligacion,asesor)
                                               values (#{@consecutivo},#{isadmin},'#{d1.to_s}','#{d2.to_s}')")
        rescue Exception => exc
          logger.error("Problemas con cargue de archivo")
        end
      end
      file.close
      ActiveRecord::Base.connection.execute("begin prc_sygma_migracionescredito(#{@consecutivo},'ASESORES'); end;")
      @datos = Objeto.find_by_sql("select * from migracionescreditos where consecutivo = #{@consecutivo}")
      flash[:temporal] = 'Archivo Cargado con Exito...'
    else
      flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../procesos/import">Aqui</a> para regresar'
    end
  end

  private
  def determine_layout
    if ['import','solicitudes','creditos','asesores','importcreditos'].include?(action_name)
      "basico"
    elsif ['sygmadownload'].include?(action_name)
      "download"
    else
      "application"
    end
  end
end
