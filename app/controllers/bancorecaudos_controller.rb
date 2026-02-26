class BancorecaudosController < ApplicationController
  before_filter :require_user
  require 'ruby_plsql'
  layout :determine_layout
  require 'csv'

  # Método Cargar Asobancaria:
  #   Carga un archivo en formato de la asobancaria
  #   de esta manera es suficientemente versatil para soportar
  #   recaudo de multiples bancos
  def cargarAsobancaria
    ActiveRecord::Base.connection.execute("delete from bancorecaudos where aplicado is null")
    collections_file = params[:file]
    collections_text = collections_file.read
    Bancorecaudo.transaction do
      collections_text.split("\n").each do |collection_text|
        case collection_text[0..1]
          when '01'
            logger.info("iniciando archivo asobancaria #{collection_text}")
            @collection_batch = Bancorecaudo.last.consecutivo + 1
            @collection_date = Date.strptime(collection_text[12..19], '%Y%m%d')
            @collection_entity = collection_text[20..22]
          when '05'
            logger.info('ingresando a lote')
          when '06'
            logger.info("recaudo #{collection_text}")
            collection = Bancorecaudo.new
            case collection_text[64..65] 
              when '03' 
                collection.nro_obligacion =  (collection_text[2..19]).to_i 
                collection.personasobligacion_id = Personasobligacion.first(:conditions => "nro_obligacion=#{(collection_text[2..19]).to_i}").id
                collection.persona_id = Personasobligacion.first(:conditions => "nro_obligacion=#{(collection_text[2..19]).to_i}").persona_id
              else 
                collection.nro_obligacion =  (collection_text[2..49]).to_i 
                collection.personasobligacion_id = Personasobligacion.first(:conditions => "nro_obligacion=#{(collection_text[2..49]).to_i}").id
                collection.persona_id = Personasobligacion.first(:conditions => "nro_obligacion=#{(collection_text[2..49]).to_i}").persona_id
            end
            collection.entity = @collection_entity
            collection.origin = collection_text[64..65]
            collection.media = collection_text[66..67]
            collection.valor = (collection_text[50..63].to_i)/100
            collection.fecha_recaudo = @collection_date
            collection.fecha = DateTime.now.to_date
            collection.consecutivo = @collection_batch
            collection.temp_otro = collection_text

            collection.save
          when '08'
            logger.info('finalizando lote')
          when '09'
            logger.error('finalizando archivo')
          else 
            logger.info("tramo de archivo no identificado \'#{collection_text[0..1]}\'")
        end
      end
    end
    @bancorecaudos = Bancorecaudo.find(:all,:conditions=>["aplicado is null"],:order=> "id")
    flash[:temporal] = 'Archivo Cargado con Exito...'
  end


  def cargar2
    ActiveRecord::Base.connection.execute("delete from bancorecaudos where aplicado is null")
    lastConsecutivo = Bancorecaudo.maximum('consecutivo') rescue 0
    begin
      if Bancorecaudo.exists?(["consecutivo = #{lastConsecutivo}"]) == true
        @consecutivo = lastConsecutivo + 1
      else
        @consecutivo = 1
      end
    rescue
      @consecutivo = 1
    end
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    path = File.join(directory, name)
    logger.error("path...."+path.to_s)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.txt'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        file = File.open(path, "rb")
        file.each do |line|
          d1,d2 = line.strip.split(";")
          a = Bancorecaudo.new
          a.temp_otro = d1
          a.save
        end
        file.close
        ActiveRecord::Base.connection.execute("begin prc_recaudosmasivo('#{@consecutivo}','A'); end;")
        @bancorecaudos = Bancorecaudo.find(:all,:conditions=>["aplicado is null"],:order=> "id")
        flash[:temporal] = 'Archivo Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../bancorecaudos/import">Aqui</a> para regresar'
    end
=begin
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    #ruta = "C://RailsApp//sapienciaorc//public//archivos//"
    ruta = Parametro.find(5).valor.to_s
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.txt'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @usr  = Parametro.find(1).valor.to_s+'/'+Parametro.find(2).valor.to_s+'@'+Parametro.find(3).valor.to_s
        #Parametro.find(1).valor.to_s+"/"+Parametro.find(2).valor.to_s+"@"+Parametro.find(3).valor.to_s
        @ctl  = ruta+'bancorecaudos.ctl'
        @log  = ruta+'bancorecaudos.lst'
        @ruta = ruta+name.to_s
        logger.error("Ruta..."+@ruta.to_s)
        #ActiveRecord::Base.connection.execute("truncate table temporales")
        system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        ActiveRecord::Base.connection.execute("begin prc_recaudosmasivo('#{@consecutivo}','A'); end;")
        @bancorecaudos = Bancorecaudo.find(:all,:conditions=>["aplicado is null"],:order=> "id")
        flash[:temporal] = 'Archivo Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../bancorecaudos/import">Aqui</a> para regresar'
    end
#    rescue
#    flash[:temporal] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
=end
  end

  def cargar2e
    ActiveRecord::Base.connection.execute("delete from bancorecaudos where aplicado is null")
    lastConsecutivo = Bancorecaudo.maximum('consecutivo') rescue 0
    begin
      if Bancorecaudo.exists?(["consecutivo = #{lastConsecutivo}"]) == true
        @consecutivo = lastConsecutivo + 1
      else
        @consecutivo = 1
      end
    rescue
      @consecutivo = 1
    end
    archivo = params[:file]
    name =  archivo.original_filename
    directory = "public/archivos/"
    ruta = Parametro.find(5).valor.to_s
    path = File.join(directory, name)
    extensionarchivo = name.slice(name.rindex("."), name.length).downcase
    if extensionarchivo == '.csv'
        # crear el archivo
        File.open(path, "wb") { |f| f.write(archivo.read) }
        @archivoGuardado = true
        @usr  = Parametro.find(1).valor.to_s+'/'+Parametro.find(2).valor.to_s+'@'+Parametro.find(3).valor.to_s
        #Parametro.find(1).valor.to_s+"/"+Parametro.find(2).valor.to_s+"@"+Parametro.find(3).valor.to_s
        @ctl  = ruta+'bancorecaudose.ctl'
        @log  = ruta+'bancorecaudose.lst'
        @ruta = ruta+name.to_s
        logger.error("Ruta..."+@ruta.to_s)
        #ActiveRecord::Base.connection.execute("truncate table temporales")
        system (" sqlldr #{@usr} control=#{@ctl} data=#{@ruta} log=#{@log}")
        ActiveRecord::Base.connection.execute("begin prc_recaudosmasivo('#{@consecutivo}','A'); end;")
        @bancorecaudos = Bancorecaudo.find(:all,:conditions=>["aplicado is null"],:order=> "id")
        flash[:temporal] = 'Archivo Cargado con Exito...'
    else
        flash[:temporalerror] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../bancorecaudos/import">Aqui</a> para regresar'
    end
#    rescue
#    flash[:temporal] = 'Error: El archivo no tiene la Extensión .CSV, pulse <a href="../temporales/import">Aqui</a> para regresar'
  end

  def cargar
    ActiveRecord::Base.connection.execute("begin prc_recaudosmasivo(#{params[:id].to_i},'B'); end;")
    redirect_to :controller=>"bancorecaudos", :action=>"cargar3", :id=>params[:id]
  end

  def cargar3
    @bancorecaudos = Bancorecaudo.find(:all,:conditions=>["consecutivo = #{params[:id].to_i}"],:order=> "id")
  end

  def index
    @fecha = params[:ubicacion][:searchn] rescue nil
    @bancorecaudos = Bancorecaudo.search(params[:search],@fecha.to_s,params[:search0], params[:page])
    if @bancorecaudos.count == 0
      #flash[:notice] = "No hay resultados de la consulta "+params[:search].to_s
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @bancorecaudos }
      end
    else
      #flash[:notice] = "Se encontraron varios resultados"
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @bancorecaudos }
      end
    end
  end

  # GET /bancorecaudos/1
  # GET /bancorecaudos/1.xml
  def show
    @bancorecaudo = Bancorecaudo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bancorecaudo }
    end
  end

  # GET /bancorecaudos/new
  # GET /bancorecaudos/new.xml
  def new
    @bancorecaudo = Bancorecaudo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bancorecaudo }
    end
  end

  # GET /bancorecaudos/1/edit
  def edit
    @bancorecaudo = Bancorecaudo.find(params[:id])
  end

  # POST /bancorecaudos
  # POST /bancorecaudos.xml
  def create
    @bancorecaudo = Bancorecaudo.new(params[:bancorecaudo])

    respond_to do |format|
      if @bancorecaudo.save
        flash[:notice] = 'Bancorecaudo was successfully created.'
        format.html { redirect_to(@bancorecaudo) }
        format.xml  { render :xml => @bancorecaudo, :status => :created, :location => @bancorecaudo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bancorecaudo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bancorecaudos/1
  # PUT /bancorecaudos/1.xml
  def update
    @bancorecaudo = Bancorecaudo.find(params[:id])

    respond_to do |format|
      if @bancorecaudo.update_attributes(params[:bancorecaudo])
        flash[:notice] = 'Bancorecaudo was successfully updated.'
        format.html { redirect_to(@bancorecaudo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bancorecaudo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bancorecaudos/1
  # DELETE /bancorecaudos/1.xml
  def destroy
    @bancorecaudo = Bancorecaudo.find(params[:id])
    @bancorecaudo.destroy

    respond_to do |format|
      format.html { redirect_to(bancorecaudos_url) }
      format.xml  { head :ok }
    end
  end

  private
  def determine_layout
    if ['buscarx','cartam'].include?(action_name)
      "informes"
    elsif ['import','cargar2','cargar','cargar3'].include?(action_name)
      "basico"
    else
      "application"
    end
  end
end
