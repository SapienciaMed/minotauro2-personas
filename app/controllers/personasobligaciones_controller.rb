
class PersonasobligacionesController < ApplicationController
  # fabian
  require 'rake'
  include ApplicationHelper
  require 'fileutils'
  require 'find'
  require 'zip'
  require 'barby/barcode/code_128'
  require 'barby/barcode/ean_13'
  require 'barby/outputter/svg_outputter'

  layout :determine_layout


  def new
    @active_record = Personasobligacion.find(params[:active_id]) if params[:active_id].present?
    @persona = Persona.find(params[:persona_id])
    @personasobligacion = Personasobligacion.new
    respond_to { |format| format.js }
  end

  def create
    @persona = Persona.find(params[:persona_id])
    @personasobligacion = Personasobligacion.new(personasobligacion_params)
    @personasobligacion.persona_id = @persona.id
    if @personasobligacion.fondo == 'ENLAZAMUNDOS'
      @personasobligacion.nro_obligacion = is_help_lastconse
    elsif @personasobligacion.fondo == 'EXTENDIENDO FRONTERAS'
      @personasobligacion.nro_obligacion = is_help_lastconseext
    end
    respond_to do |format|
      if @personasobligacion.save
        ActiveRecord::Base.connection.execute("begin prc_obligacion('#{@personasobligacion.id}'); end;")
        format.js { render inline: "location.reload();" }
      else
        format.js { render 'layouts/errors', locals: { object: @personasobligacion } }
      end
    end
  end

  def destroy
    @personasobligacion.destroy
  end

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
                                                   observacion: "#{@personasobligacion.id} - PAGO ",
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

  def self.generarfactura
    puts "INGRESA  AL METODO PARA IMPRIMIR #{Time.now}"

    folder_path = "#{::Rails.root}/public/facturas"
    folder_png_path = "#{::Rails.root}/public/barcodes"

    if Dir.exist?(folder_path)
      Dir.glob("#{folder_path}/*.pdf").each do |file_path|
        FileUtils.rm(file_path)
      end
    else
      puts "La carpeta #{folder_path} no existe."
    end

    # Planesfactura.where("TO_CHAR(fecha_corte, 'YYYY-MM') = ? and id in (17342540, 17329452)", Time.now.strftime('%Y-%m')).update(genera_factura: nil, secuenciageneracion: nil)
    planesfacturas = Planesfactura.where("genera_factura is null and secuenciageneracion is null and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(5000)
    #planesfacturas = Planesfactura.where("TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(5)
    if planesfacturas.present?
      puts "INGRESA al proceso de facturas PARA IMPRIMIR #{Time.now}"
      finaliza = "FINALIZA #{Time.now.strftime('%Y%m%d%X').gsub(":", "_")}"
      planesfacturas.update_all(secuenciageneracion: Time.now.strftime('%Y%m%d%X').gsub(":", "_"))
      planesfacturas.each do |p|
        begin


          valor = p.p_minimo.to_i.to_s.rjust(10, '0') rescue 0
          obligacion = p.obligacion.to_s.to_s.rjust(10, '0')

          datos = {
            identificador0: '415',
            identificador1: '7709998763906',
            identificador2: '8020',
            numero_referencia: obligacion.to_s,
            identificador3: '390',
            valor_pagar: valor,
            identificador4: '96',
            fecha: "20241225"
          }

          datoc = Barby::Code128.new("#{Barby::Code128::STARTC}")
          dato1 = Barby::Code128.new("#{Barby::Code128::FNC1}")

          #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}#{datos[:valor_pagar]}#{dato1}#{datos[:identificador4]}#{datos[:fecha]}"
          #group1 = "(415)7709998763906(8020)#{obligacion.to_s}(3900)#{valor}#{datos[:identificador4]}#{datos[:fecha]}"

          # Prueba 1
          group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador4]}#{datos[:fecha]}"
          group1 = "(415)7709998763906(8020)#{obligacion.to_s}(96)#{datos[:fecha]}"

          # Prueba 2 con valor 0
          #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}0000000000#{dato1}#{datos[:identificador4]}#{datos[:fecha]}"
          #group1 = "(415)7709998763906(8020)#{obligacion.to_s}(3900)0000000000(#{datos[:identificador4]})#{datos[:fecha]}"

          # Prueba 3
          #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}"
          #group1 = "(415)7709998763906(8020)#{obligacion.to_s}"



          puts "-----------------  IMPRIME GROUP 1 - #{group.to_s} - linea 105 ----------------- "
          nameextrado = "Fact_#{p.obligacion}_#{p.fecha_corte.strftime('%m_%Y')}" rescue nil
          ruta = "#{folder_png_path}/#{nameextrado}.png"

          blop = Barby::Code128.new(group.to_s).to_png(margin: 2, height: 95) # Modelo A
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
          # FileUtils.rm_r Dir.glob(ruta)
        rescue Exception => e
          error_message = "#{e.class.name}: #{e.message}"
          backtrace_info = e.backtrace.join("\n")

          p.update_all(observacion_creacion: "#{error_message}\n#{backtrace_info}")

        end
      end

      begin
        planesfacturas = Planesfactura.where("genera_factura = '#{finaliza}' and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(5000)
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

              puts "Error generando factura para #{l.id}: #{error_message}"
              puts "Backtrace:\n#{backtrace_info}"

              l.update_all(observacion_creacion: "#{error_message}\n#{backtrace_info}", secuenciageneracion: nil, genera_factura: nil)
            end
          end
        end
      rescue Exception => e
        error_message = "#{e.class.name}: #{e.message}"
        backtrace_info = e.backtrace.join("\n")
        puts "Error general: #{error_message}"
        puts "Backtrace:\n#{backtrace_info}"
      end
    end
  end


  def self.generarfactura_test
    puts "INGRESA  AL METODO PARA IMPRIMIR #{Time.now}"

    folder_path = "#{::Rails.root}/public/facturas"
    folder_png_path = "#{::Rails.root}/public/barcodes"

    if Dir.exist?(folder_path)
      Dir.glob("#{folder_path}/*.pdf").each do |file_path|
        FileUtils.rm(file_path)
      end
    else
      puts "La carpeta #{folder_path} no existe."
    end

    planesfacturas = Planesfactura.where("genera_factura is null and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(100)
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

          datoc = Barby::Code128.new("#{Barby::Code128::STARTC}")
          dato1 = Barby::Code128.new("#{Barby::Code128::FNC1}")
          #group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}#{datos[:identificador3]}"
          #group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}(#{datos[:identificador3]})"

          group = "#{dato1}#{datos[:identificador0]}#{datos[:identificador1]}#{datos[:identificador2]}#{datos[:numero_referencia]}#{dato1}"
          group1 = "C(#{datos[:identificador0]})#{datos[:identificador1]}(#{datos[:identificador2]})#{datos[:numero_referencia]}"

          puts "-----------------  IMPRIME GROUP 1 - #{group.to_s} - linea 105 ----------------- "
          nameextrado = "Fact_#{p.obligacion}_#{p.fecha_corte.strftime('%m_%Y')}" rescue nil
          ruta = "#{folder_png_path}/#{nameextrado}.png"

          blop = Barby::Code128.new(group.to_s).to_png(margin: 2, height: 95) # Modelo A
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
          # FileUtils.rm_r Dir.glob(ruta)
        rescue Exception => e
          error_message = "#{e.class.name}: #{e.message}"
          backtrace_info = e.backtrace.join("\n")

          # Actualizar el campo observacion_creacion en el registro
          p.update_all(observacion_creacion: "#{error_message}\n#{backtrace_info}")

        end
      end

      begin
        planesfacturas = Planesfactura.where("genera_factura = '#{finaliza}' and TO_CHAR(fecha_corte, 'YYYY-MM') = ?", Time.now.strftime('%Y-%m')).order("id asc").limit(100)
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
        error_message = "#{e.class.name}: #{e.message}"
        backtrace_info = e.backtrace.join("\n")
        puts "Error general: #{error_message}"
        puts "Backtrace:\n#{backtrace_info}"
      end
    end
  end

  def carta
    @personasobligacion  = Personasobligacion.find(params[:id])
    fname = "Carta_" + @personasobligacion.nro_obligacion.to_s + '_' + @personasobligacion.persona.identificacion
    respond_to do |format|
      format.pdf {render pdf: "#{fname}", template: "personasobligaciones/carta.html.erb", encoding: "UTF-8", page_size: 'Letter',:margin => {top: 15, :bottom => 20, :left => 15,:right => 15}}
    end
  end

  def historico_pagos
    @personasobligacion  = Personasobligacion.find(params[:id])
    fname = "HistoricoPagos_" + @personasobligacion.nro_obligacion.to_s + '_' + @personasobligacion.persona.identificacion
    respond_to do |format|
      format.pdf {render pdf: "#{fname}", template: "personasobligaciones/historico_pagos.html.erb", encoding: "UTF-8", page_size: 'Letter',:margin => {top: 15, :bottom => 20, :left => 15,:right => 15}}
    end
  end

  def historico_pagos2
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="Historico_Pago_Obligacion_' + "#{Time.now.strftime("%Y%m%d_%X")}" + '.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma'] = "public"
    @personasobligacion = Personasobligacion.find(params[:id])
    @planesrecaudos = Planesrecaudo.where("personasobligacion_id = #{@personasobligacion.id} and tipo_pago not in (select valor from parametros where descripcion = 'TIPO_AJUSTE')").order(fecha_recaudo: :asc)
  end

  private

  def determine_layout
    if ['resumen_paymentez'].include?(action_name)
      "application"
    elsif ['historico_pagos2'].include?(action_name)
      "blank"
    else
      'application_admin'
    end
  end

  def personasobligacion_params
    params.require(:personasobligacion).permit!
  end
end