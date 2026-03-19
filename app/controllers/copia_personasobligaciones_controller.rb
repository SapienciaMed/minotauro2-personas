class PersonasobligacionesController < ApplicationController

  require 'rake'
  include ApplicationHelper
  require 'fileutils'
  require 'find'
  require 'zip'
  require 'barby/barcode/code_128'
  require 'barby/barcode/ean_13'
  require 'barby/outputter/svg_outputter'

  layout :determine_layout

  def calculate_scale(barcode_width)
    ideal_width = 20.0
    max_width = 31.8
    min_width = 15.0

    if barcode_width > max_width
      scale = max_width / barcode_width
    elsif barcode_width < min_width
      scale = min_width / barcode_width
    else
      scale = ideal_width / barcode_width
    end

    return scale
  end

  def self.generar_codigo_barras(datos)

    barcode = Barby::Code128.new(codigo)
    svg = Barby::SvgOutputter.new(barcode).to_svg
    return svg
  end

  # Descripcion: Metodo que cuenta con los datos del cliente y la informacion del pago en un resumen y se crea el numero de factura de teseo
  # Fecha Creacion: 22-Marzo-2022
  def resumen_paymentez
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @valor = params[:valor].present? ? params[:valor] : params[:opciones]
    # Crear el registro del recibo para comporar cuando sea aprobado el pago
    @personasoblrecibo = Personasoblrecibo.create!(persona_id: @personasobligacion.persona_id,
                                                   fecha_recaudo: Date.today,
                                                   valor: @valor,
                                                   user_id: current_user.id,
                                                   forma_pago: 'PENDIENTE',
                                                   estado: 'PENDIENTE',
                                                   observacion: "#{@personasobligacion.id} - PAGO PAYMENTEZ",
                                                   personasobligacion_id: @personasobligacion.id)
  end

  def paymentez_success
    @personasoblrecibo = Personasoblrecibo.find(params[:ref])
    @valor = params[:vlr]
    @personasobligacion = Personasobligacion.find(params[:obl])
  end

  def paymentez_failure
    @personasoblrecibo = Personasoblrecibo.find(params[:ref])
    @valor = params[:vlr]
    @personasobligacion = Personasobligacion.find(params[:obl])
  end

  def paymentez_pending
    @personasoblrecibo = Personasoblrecibo.find(params[:ref])
    @valor = params[:vlr]
    @personasobligacion = Personasobligacion.find(params[:obl])
  end

  def paymentez_review
    @personasoblrecibo = Personasoblrecibo.find(params[:ref])
    @valor = params[:vlr]
    @personasobligacion = Personasobligacion.find(params[:obl])
  end

  def formato_factura
    @planesfactura = Planesfactura.find(params[:id])
    datos = {
      identificador_aplicacion: '415',
      numero_referencia: @planesfactura.obligacion.to_s.rjust(22, '0'),
      valor_pagar: @planesfactura.c_actual.to_i.to_s.rjust(14, '0')
    }
    # con valor
    #@group = "C#{datos[:identificador_aplicacion]}F1#{datos[:numero_referencia]}F1#{datos[:valor_pagar]}"
    @group = "C#{datos[:identificador_aplicacion]}F1#{datos[:numero_referencia]}F1"
    ruta = "#{::Rails.root}/app/assets/images/barcodes/#{@planesfactura.obligacion.to_s}.png"
    blop = Barby::Code128.new(@group.to_s).to_png(:margin => 2, :height => 55, :width => '22mm')
    File.open(ruta.to_s, 'wb') { |f| f.write blop }
    response_body_pdf("Factura Nro #{@planesfactura.personasobligacion.nro_obligacion}", 10, 0, 5, 5,
                      nil,
                      nil,
                      'personasobligaciones/formato_factura.html.erb')
    FileUtils.rm_r Dir.glob(ruta)
  end

  def ver_facturas
    @personasobligacion = Personasobligacion.find(params[:personasobligacion_id])
    @planesfacturas = @personasobligacion.planesfacturas.order("id desc")
  end

  def download
    planesfactura = Planesfactura.find(params[:id])
    file = "Fact_#{planesfactura.obligacion}_#{planesfactura.fecha_corte.strftime('%m')}_#{planesfactura.fecha_corte.strftime('%Y')}.pdf"
    documento = File.join(Rails.root, "public", "facturas")
    send_file(File.join(documento, file.to_s))
  end

  def download_zip
    info = params[:info]
    documento = File.join(Rails.root, "public", "download")
    send_file(File.join(documento, info.to_s))
  end

  # Planesfactura.where("genera_factura like '%PROCESANDO%' and to_char(fecha_corte, 'YYYYMMDD') >= '20221101'").count - Valida los que estan en proceso
  # Planesfactura.where("genera_factura like '%FINALIZA%' and to_char(fecha_corte, 'YYYYMMDD') >= '20221101'").count - Valida los que estan en proceso
  # Planesfactura.where("genera_factura like '%PROCESANDO%' and to_char(fecha_corte, 'YYYYMMDD') >= '20221101'").update_all(genera_factura: nil)
  # Planesfactura.where(["to_char(fecha_corte, 'YYYYMMDD') >= '20221201'"]).update_all(genera_factura: nil)
  # Planesfactura.where(["to_char(fecha_corte, 'YYYYMMDD') >= '20221201'"]).count
  def self.generarfactura
    puts "INGRESA  AL METODO PARA IMPRIMIR #{Time.now}"
    #folder_path = "#{::Rails.root}/public/facturas"
    #folder_png_path = "#{::Rails.root}/app/assets/images/barcodes"

    folder_path = "#{::Rails.root}/public/facturas"
    folder_png_path = "#{::Rails.root}/public/barcodes"

    if Dir.exist?(folder_path)
      Dir.glob("#{folder_path}/*.pdf").each do |file_path|
        FileUtils.rm(file_path)
      end
    else
      puts "La carpeta #{folder_path} no existe."
    end
=begin
    if Dir.exist?(folder_png_path)
      Dir.glob("#{folder_png_path}/*.png").each do |file_path|
        FileUtils.rm(file_path)
      end
    else
      puts "La carpeta Png #{folder_png_path} no existe."
    end
=end



    #    Planesfactura.update_all(genera_factura: nil, secuenciageneracion: nil).where("TO_CHAR(fecha_corte, 'YYYY-MM') = ?", '2023-08')

    # ActiveRecord::Base.connection.execute("update planesfacturas set genera_factura = null, secuenciageneracion = null where TO_CHAR(fecha_corte, 'YYYY-MM') = '2023-11'")
    #planesfacturas = Planesfactura.where("genera_factura is null and secuenciageneracion is null and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", '2023-11').order("id asc").limit(2000)
    planesfacturas = Planesfactura.where("genera_factura is null and secuenciageneracion is null and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(2000)
    #planesfacturas = Planesfactura.where("genera_factura is null and secuenciageneracion is null and to_char(fecha_corte, 'YYYY-MM') = 'to_char(sysdate, 'YYYY-MM')'").order("id asc")
    if planesfacturas.present?
      puts "INGRESA al proceso de facturas PARA IMPRIMIR #{Time.now}"
      finaliza = "FINALIZA #{Time.now.strftime('%Y%m%d%X').gsub(":", "_")}"
      planesfacturas.update_all(secuenciageneracion: Time.now.strftime('%Y%m%d%X').gsub(":", "_"))
      planesfacturas.each do |p|
        begin
          valor = p.p_minimo.to_i.to_s.rjust(14, '0') rescue 0
          obligacion = p.obligacion.to_s.rjust(22, '0')

          datos = {
            identificador0: '415',
            identificador1: '7709998763906',
            identificador2: '8020',
            numero_referencia: obligacion,
            identificador3: '390',
            valor_pagar: valor
          }
          # 2023-06-08 FFA
          # https://github.com/toretore/barby/blob/master/lib/barby/barcode/code_128.rb
          # Con Code128 Se envia prueba 1 (FacturasModelo_A.zip)
          # Con Code128B Se envia prueba 2 (Facturas20230608_B.zip)

          datoc = Barby::Code128.new("#{Barby::Code128::STARTC}")
          dato1 = Barby::Code128.new("#{Barby::Code128::FNC1}")
          # group = "#{datoc}#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}#{datos[:valor_pagar]}"
          # Con Valor
          #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}#{datos[:valor_pagar]}"
          #group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}(#{datos[:identificador3]})#{datos[:valor_pagar]}"

          group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}"
          group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}(#{datos[:identificador3]})"

          puts "-----------------  IMPRIME GROUP 1 - #{group.to_s} - linea 105 ----------------- "
          nameextrado = "Fact_#{p.obligacion}_#{p.fecha_corte.strftime('%m_%Y')}" rescue nil
          #ruta = "#{::Rails.root}/app/assets/images/barcodes/#{nameextrado}.png"
          ruta = "#{folder_png_path}/#{nameextrado}.png"

          blop = Barby::Code128.new(group.to_s).to_png(margin: 2, height: 95) # Modelo A
          # blop = Barby::Code128.new(group.to_s).to_png(margin => 2, :height => 60, :width => '40mm')
          File.open(ruta.to_s, 'wb') { |f| f.write blop }
          sleep(1)

          rutafact = "#{::Rails.root}/public/facturas/"
          rutanamefile = "#{::Rails.root}/public/facturas/#{nameextrado}.pdf"
          ######################## GENERAR FACTURA ######################
          pdf = ApplicationController.render pdf: "#{nameextrado}",
                                             template: "personasobligaciones/formato_factura.html.erb",
                                             :save_to_file => rutanamefile,
                                             :save_only => true,
                                             encoding: "UTF-8", page_size: 'A4', locals: { planesfactura: p, group: group1, nameextrado: nameextrado }
          save_path = rutanamefile
          File.open(save_path, 'wb') do |file|
            file << pdf
          end
          p.update(genera_factura: "#{finaliza}")
          puts "Factura bar #{nameextrado}"
          #FileUtils.rm_r Dir.glob(ruta)
        rescue Exception => e
          error_message = "#{e.class.name}: #{e.message}"
          backtrace_info = e.backtrace.join("\n")

          # Actualizar el campo observacion_creacion en el registro
          p.update_all(observacion_creacion: "#{error_message}\n#{backtrace_info}")

        end
      end

      begin
          planesfacturas = Planesfactura.where("genera_factura = '#{finaliza}' and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(2000)
        zipfile_folder = "#{::Rails.root}/public/download/Facturas_#{Time.now.strftime("%Y%m%d_%H%M%S")}.zip"
        FileUtils.rm_r Dir.glob(zipfile_folder)
        rutaupload = "#{::Rails.root}/public/facturas/"

        Zip::File.open(zipfile_folder, Zip::File::CREATE) do |zipfile|
          planesfacturas.each do |l|
            begin
              nameFile = "Fact_#{l.obligacion}_#{l.fecha_corte.strftime('%m')}_#{l.fecha_corte.strftime('%Y')}.pdf"
              path = File.join(rutaupload, File.basename(nameFile).to_s)
              zipfile.add(nameFile, path)
            rescue Exception => e
              error_message = "#{e.class.name}: #{e.message}"
              backtrace_info = e.backtrace.join("\n")

              # Imprimir información del error en la consola
              puts "Error generando factura para #{l.id}: #{error_message}"
              puts "Backtrace:\n#{backtrace_info}"

              # Actualizar campos de la factura con información del error
              l.update_all(observacion_creacion: "#{error_message}\n#{backtrace_info}", secuenciageneracion: nil, genera_factura: nil)
            end
          end
        end
      rescue Exception => e
        # Manejar errores generales que puedan ocurrir alrededor del bloque principal
        error_message = "#{e.class.name}: #{e.message}"
        backtrace_info = e.backtrace.join("\n")

        # Imprimir información del error en la consola
        puts "Error general: #{error_message}"
        puts "Backtrace:\n#{backtrace_info}"
      end


=begin
      planesfacturas = Planesfactura.where("genera_factura = '#{finaliza}' and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(2000)
      #planesfacturas = Planesfactura.where("genera_factura = '#{finaliza}' and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", '2023-11').order("id asc").limit(2000)
      zipfile_folder = "#{::Rails.root}/public/download/Facturas_#{Time.now.strftime("%Y%m%d_%H%M%S")}.zip"
      FileUtils.rm_r Dir.glob(zipfile_folder)
      rutaupload = "#{::Rails.root}/public/facturas/"
      Zip::File.open(zipfile_folder, Zip::File::CREATE) do |zipfile|
        planesfacturas.each do |l|
          begin
            nameFile = "Fact_#{l.obligacion}_#{l.fecha_corte.strftime('%m')}_#{l.fecha_corte.strftime('%Y')}.pdf"
            path = File.join(rutaupload, File.basename(nameFile).to_s)
            zipfile.add(nameFile, path)
          rescue ActiveRecord::ActiveRecordError => invalid
            error = invalid.to_s
            l.update_all(observacion_creacion: error[0..999].to_s, secuenciageneracion: nil, genera_factura: nil)
          end
        end
      end
=end
    end
  end

  def self.generador_png
    folder_png_path = "#{::Rails.root}/public/barcodes"
    planesfacturas = Planesfactura.where(" TO_CHAR(fecha_corte, 'YYYY-MM') >= ?", Time.now.strftime('%Y-%m')).order("id asc").limit(2000)
    planesfacturas.each do |p|
      begin
        valor = p.p_minimo.to_i.to_s.rjust(14, '0') rescue 0
        obligacion = p.obligacion.to_s.rjust(22, '0')

        datos = {
          identificador0: '415',
          identificador1: '7709998763906',
          identificador2: '8020',
          numero_referencia: obligacion,
          identificador3: '390',
          valor_pagar: valor
        }

        datoc = Barby::Code128.new("#{Barby::Code128::STARTC}")
        dato1 = Barby::Code128.new("#{Barby::Code128::FNC1}")
        # con Valor
        #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}#{datos[:valor_pagar]}"
        #group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}(#{datos[:identificador3]})#{datos[:valor_pagar]}"

        group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}"
        group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}(#{datos[:identificador3]})"

        puts "-----------------  IMPRIME GROUP 1 - #{group.to_s} - linea 105 ----------------- "
        nameextrado = "Fact_#{p.obligacion}_#{p.fecha_corte.strftime('%m_%Y')}" rescue nil
        ruta = "#{folder_png_path}/#{nameextrado}.png"

        blop = Barby::Code128.new(group.to_s).to_png(margin: 2, height: 95) # Modelo A
        File.open(ruta.to_s, 'wb') { |f| f.write blop }
        sleep(1)

      end
    end
  end

  private

  def determine_layout
    "application_admin"
  end

  def personasobligacion_params
    params.require(:personasobligacion).permit!
  end
end