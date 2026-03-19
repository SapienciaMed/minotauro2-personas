class UsersController < ApplicationController
  before_action :set_user, only: [:desbloquearusuario, :activaruser, :inactivaruser, :show, :edit, :update, :destroy]

  layout :set_layout
  autocomplete :user, :nombre

  autocomplete :identificacion, :nombre

  autocomplete :cambio, :user2

  before_action :checkaccess, except: [:desbloqueoreset, :cambioportafolio, :reestablecesusuario, :inconsistencias, :importar, :importar2, :carguemasivo, :fincargue, :cargar, :cargar2, :modograficoedu, :autocomplete_identificacion_nombre, :actemail, :updateemailedu, :edupol_resetpass,:edupol_desbloquearusuario,:modogestion, :cambiosucursal, :etapar, :etapa, :update, :cambiotipoconsulta], if: :user_signed_in?
  before_action :authenticate_user!, except: [:desbloqueoreset, :autocomplete_identificacion_nombre]



  def autocomplete_user_nombre
    term = params[:term]
    if is_sygma
      users = User.where('upper(username) LIKE ? OR upper(nombre) LIKE ? OR identificacion LIKE ?', "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%").limit(10).order(:nombre).all
      render :json => users.map { |user| {id: user.id, label: user.nombrecompleto, value: user.nombre} }
    end
  end

  def autocomplete_cambio_user2
    term = params[:term]
    if params[:portafolio_id].to_s != "" or params[:portafolio_id].to_s != nil
      users = User.where('activo = ? and portafolio_id = ? and (upper(username) LIKE ? OR upper(identificacion) LIKE ? OR upper(nombre) LIKE ?)', "S", params[:portafolio_id].to_i, "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%").limit(10).order(:nombre).all
      render :json => users.map { |user| {id: user.id, label: user.nombrecompleto, value: user.nombre} }
    end
  end

  def cambiousuario
    if params[:user_id].to_s != ""
      ProcesoJob.perform_now("prc_cambiousuario(#{is_admin},#{params[:user_id]},'A')")
    end
    redirect_to root_path
  end

  def reestablecesusuario
    ProcesoJob.perform_now("prc_cambiousuario(#{current_user.id},-1,'B')")
    redirect_to root_path
  end

  def autocomplete_identificacion_nombre
    term = params[:term]
    cohorte_id = params[:cohorte].to_i
    if params[:tipoconsulta] != "" or params[:tipoconsulta] != nil
      if cohorte_id != 0
        users = User.where('portafolio_id LIKE ? AND (tipoconsulta LIKE ? OR tipoconsulta2 LIKE ?) AND (upper(identificacion) LIKE ? OR upper(nombre) LIKE ?)', "%#{params[:portafolio_id]}%", "%#{params[:tipoconsulta]}%", "%#{params[:tipoconsulta]}%",  "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%").order(:nombre).all
        render :json => users.map { |user| {id: user.id, label: user.nombre, value: user.id} }
      else
        users = User.where('activo = ? and portafolio_id LIKE ? AND (tipoconsulta LIKE ? OR tipoconsulta2 LIKE ?) AND (upper(identificacion) LIKE ? OR upper(nombre) LIKE ?)', "S", "%#{params[:portafolio_id]}%", "%#{params[:tipoconsulta]}%", "%#{params[:tipoconsulta]}%",  "%#{replacespace(term.upcase)}%", "%#{replacespace(term.upcase)}%").order(:nombre).all
        render :json => users.map { |user| {id: user.id, label: user.nombre, value: user.id} }
      end
    end
  end

  def carguemasivo

  end

  def tabhome
    @user = User.find(params[:id])
    @user.hometab = params[:tab]
    @user.save(validate: false)
    redirect_to menus_path
  end

  def importar
    isadmin = is_admin
    Migracionesuser.where(userreg_id: isadmin).destroy_all
    @consecutivo = is_controlmigracion
    archivo = params[:file]
    if archivo
      nombrearchivo =  archivo.original_filename
      if Migracionesuser.where(namefile: nombrearchivo.to_s).exists? == false
        directory = "public/portafolios/#{is_portafolio}/"
        path = File.join(directory, nombrearchivo)
        extensionarchivo = nombrearchivo.slice(nombrearchivo.rindex("."), nombrearchivo.length).downcase
        if extensionarchivo == ".xlsx" or extensionarchivo == ".xls"
          File.open(path, "wb") { |f| f.write(archivo.read) }

          ImportFileJob.perform_later(path, is_portafolio, 'users_importar', isadmin, nombrearchivo.to_s)

          ProcesoJob.perform_now("prc_teseo_verificausers(#{isadmin},#{is_portafolio}, 'A')")
          flash[:notice] = 'Archivo Cargado con Exito'
          redirect_to fincargue_users_path(carga: 'S')
        else
          flash[:warning] = 'Error: El archivo no tiene la Extensión .xlsx o .xls, verifique'
          if is_auth_c('cargacazadores')
            redirect_to descargaedupol_procesos_path
          else
            redirect_to users_path
          end
        end
      else
        flash[:warning] = 'Error: El nombre del archivo ya se encuentra cargado, verifique'
        if is_auth_c('cargacazadores')
          redirect_to descargaedupol_procesos_path
        else
          redirect_to users_path
        end
      end
    else
      flash[:warning] = 'Error: Archivo Invalido'
      if is_auth_c('cargacazadores')
        redirect_to descargaedupol_procesos_path
      else
        redirect_to users_path
      end
    end
  end

  def importar2
    isadmin = is_admin
    Migracionesuser.where(userreg_id: isadmin).destroy_all
    @consecutivo = is_controlmigracion
    archivo = params[:file]
    if archivo
      nombrearchivo =  archivo.original_filename
      if Migracionesuser.where(namefile: nombrearchivo.to_s).exists? == false
        directory = "public/portafolios/#{is_portafolio}/"
        path = File.join(directory, nombrearchivo)
        extensionarchivo = nombrearchivo.slice(nombrearchivo.rindex("."), nombrearchivo.length).downcase
        if extensionarchivo == ".xlsx" or extensionarchivo == ".xls"
          File.open(path, "wb") { |f| f.write(archivo.read) }
          ImportFileJob.perform_later(path, is_portafolio, 'users_importar2', isadmin, nombrearchivo.to_s)
          ProcesoJob.perform_now("prc_teseo_verificausers(#{isadmin},#{is_portafolio}, 'B')")
          flash[:notice] = 'Archivo Cargado con Exito'
          redirect_to fincargue_users_path(carga: 'N')
        else
          flash[:warning] = 'Error: El archivo no tiene la Extensión .xlsx o .xls, verifique'
          if is_auth_c('cargacazadores')
            redirect_to descargaedupol_procesos_path
          else
            redirect_to users_path
          end
        end
      else
        flash[:warning] = 'Error: El nombre del archivo ya se encuentra cargado, verifique'
        if is_auth_c('cargacazadores')
          redirect_to descargaedupol_procesos_path
        else
          redirect_to users_path
        end
      end
    else
      flash[:warning] = 'Error: Archivo Invalido'
      if is_auth_c('cargacazadores')
        redirect_to descargaedupol_procesos_path
      else
        redirect_to users_path
      end
    end
  end

  def fincargue
    isadmin = is_admin
    isportafolio = is_portafolio
    @contotal = Objeto.find_by_sql(["select * from migracionesusers where portafolio_id = #{isportafolio} and userreg_id = #{isadmin}"])
    @consinerror = Objeto.find_by_sql(["select * from migracionesusers where portafolio_id = #{isportafolio} and userreg_id = #{isadmin} and error is null"])
    @conconerror = Objeto.find_by_sql(["select * from migracionesusers where portafolio_id = #{isportafolio} and userreg_id = #{isadmin} and error is not null"])
  end

  def cargar
    @userporcrear = Migracionesuser.where("error is null and aplicado is null and userreg_id = #{is_admin}")
    @userporcrear.each do |u|
    user = User.new
    user.nombre = u.nombre.upcase
    user.identificacion = u.identificacion
    user.username = u.username
    user.email = u.email
    user.genero = u.genero
    user.portafoliossucursal_id = u.portafoliossucursal_id
    user.direccion = u.direccion
    user.ciudad = u.ciudad
    user.celular = u.celular
    user.telefonos = u.telefonos
    buser = User.find_by(identificacion: u.identificacion)
    if buser
      user.tipoconsulta2 = u.tipoconsulta
    else
      user.tipoconsulta = u.tipoconsulta
    end
    user.cargo_id = u.cargo_id
    user.centro_id = u.centro_id
    user.banco = u.banco_id
    user.municipio_id = u.municipio_id
    user.tipo_cuenta = u.tipo_cuenta
    user.nro_cuenta = u.nro_cuenta
    user.tipoconsulta = u.tipoconsulta
    user.extension = u.extension
    user.observaciones = u.observaciones
    user.password = u.password
    user.portafolio_id = u.portafolio_id
    user.activo = 'S'
    user.user_actualiza = is_admin
    user.save(validate: false)
    u.aplicado = 'SI'
    u.save
  end
    flash[:notice] = 'Archivo Cargado con Exito...'
    if is_auth_c('cargacazadores')
      redirect_to descargaedupol_procesos_path
    else
      redirect_to users_path
    end
  end

  def cargar2
    @userporcrear = Migracionesuser.where("error is null and aplicado is null and userreg_id = #{is_admin}")
    @userporcrear.each do |u|
    buser = User.find_by(identificacion: u.identificacion)
    buser.activo = 'N'
    buser.save
  end
    flash[:notice] = 'Archivo Cargado con Exito...'
    if is_auth_c('cargacazadores')
      redirect_to descargaedupol_procesos_path
    else
      redirect_to users_path
    end
  end

  def inconsistencias
    @mconerror = Migracionesuser.where("error is not null and aplicado is null and userreg_id = #{is_admin}").order("id")
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="Teseo_inconsistenciasUsers_'+"#{Time.now.strftime("%Y%m%d_%X")}"+'.xls"'
    headers['Cache-Control'] = 'max-age=0'
    headers['pragma']="public"
  end

  def checkaccess
    redirect_to root_path
    #return is_permit('admin/users')
  end

  def actemail
    @user = User.find(params[:id])
    @persona = Persona.find(params[:persona_id])
  end

  def updateemailedu
    @email_actual = params[:email_actual].strip
    @user = User.find(params[:user][:id])
    existe = User.where(email: params[:user][:email].strip.split.first, portafolio_id: is_portafolio).exists?
    existe2 = User.where(username: params[:user][:email].strip.split.first, portafolio_id: is_portafolio).exists?
    if existe == false and existe2 == false
      if params[:user][:email] =~ /@/
        @user.username = params[:user][:email].strip.split.first
        @user.email = params[:user][:email].strip.split.first
        respond_to do |format|
          if @user.save(validate: false)
            persona = Persona.find(params[:user][:persona_id])
            persona.email = @user.email.strip.split.first
            persona.save(validate: false)
            format.js
            flash[:success] = 'Actualizado Correctamente'

            @registro = Registro.new
            @registro.modelo = 'ACTUALIZACIONEMAIL'
            @registro.estado = 'CORRECTO'
            @registro.user_id = @user.id
            @registro.usuario = @user.username
            @registro.save
          else
            format.js
          end
        end
      else
        flash[:warning] = 'Tiene que ser un Correo Electrónico'
      end
    elsif @user.email == params[:user][:email].strip
      flash[:warning] = 'Este es tu Correo Electrónico'
    else
      flash[:warning] = 'El Correo Electrónico ya fue tomado por otro Usuario'
    end
  end

  def show
  end

  def index
    if is_sygma == true
      @blockedusers = User.where(failed_attempts: 3)
      @q = User.ransack(params[:q])
      @users = @q.result.paginate(:page => params[:page], :per_page => 10)
      @q = User.ransack(params[:q])

      if @q == nil
        @users = User.all.paginate(:page => params[:page], :per_page => 10)
      else
        @users = @q.result.paginate(:page => params[:page], :per_page => 10)
      end
      if params[:nombre]
        @users = User.name_like("%#{params[:nombre].upcase}%").order(:nombre).paginate(:page => params[:page], :per_page => 10)
        if @users.count == 1
          @user = @users.last
          redirect_to edit_user_path(etapa: "A", id: params[:user_id])
        end
      else
      end
    else
      @blockedusers = User.where(failed_attempts: 3, portafolio_id: is_portafolio)
      @q = User.ransack(params[:q])
      @users = @q.result.paginate(:page => params[:page], :per_page => 10).where(["portafolio_id= #{is_portafolio} and (geintac = 'N' or geintac is null)"])
      if @users.count == 1
        @user = @users.last
        redirect_to edit_user_path(etapa: "A", id: @user.id)
      end
    end
  end

  def new
    @user = User.new
    @user.etapa = 'A'
    render "user_form"
  end

  def edit
    if @user.etapa.to_s == 'F'
      @usersvehiculos = @user.usersvehiculos.all
    elsif @user.etapa.to_s == 'H'
      @usersportafolios = @user.usersportafolios.all
    elsif @user.etapa.to_s == 'G'
      @userssucursales = @user.userssucursales.all
    elsif @user.etapa.to_s == 'B'
      @usersmodulos = @user.usersmodulos.all
    elsif @user.etapa.to_s == 'I'
      @usersreportes = @user.usersreportes.all
    elsif @user.etapa.to_s == 'C'
      @userspermisos = @user.userspermisos.all
    elsif @user.etapa.to_s == 'A'
      is_portafolio = is_portafolio
      @portafolioscargos = Portafolioscargo.where("portafolio_id = #{@user.portafolio_id}")
    end
    @clientes = Cliente.find_by_sql(["select distinct cliente, count(9) cantidad from personasobligaciones where user_id = #{@user.id} group by cliente"])
    respond_to do |format|
      format.html { render :action => "user_form" }
    end
  end

  def create
    @user = User.new(user_params)
    if is_sygma == false
      @user.portafolio_id = is_portafolio
    end
    @user.user_actualiza = is_admin
    respond_to do |format|
      if @user.save
        if @user.geintac == 'S'
          @modulos = Modulo.all
          @objetos = Objeto.all
          @reportes = Reporte.where.not(metodo: nil)

          @modulos.each do |modulo|
            usersmodulo = Usersmodulo.new
            usersmodulo.user_id = @user.id
            usersmodulo.modulo_id = modulo.id
            usersmodulo.save
          end

          @reportes.each do |reporte|
            usersreporte = Usersreporte.new
            usersreporte.user_id = @user.id
            usersreporte.reporte_id = reporte.id
            usersreporte.save
          end

          @objetos.each do |objeto|
            userspermiso = Userspermiso.new
            userspermiso.user_id = @user.id
            userspermiso.objeto_id = objeto.id
            userspermiso.actualiza = 'S'
            userspermiso.crea = 'S'
            userspermiso.elimina = 'S'
            userspermiso.save
          end
        end
        format.html { redirect_to edit_user_path(etapa: "A", id: @user.id), notice: 'Usuario creado correctamente' }
        format.json { render :show, status: :created, location: @user }
      else
        @user.etapa = 'A'
        format.html {render "user_form"}
      end
    end
  end

  def modogestion
    if params[:act].to_s == 'SI'
      @user = User.find(params[:id])
      @user.etapa = 'GE'
      @user.user_actualiza = is_admin
      @user.save
      flash['success'] = "Modo Gestión Activado"
      redirect_to root_path
    elsif params[:act].to_s == 'NO'
      @user = User.find(params[:id])
      @user.etapa = 'A'
      @user.user_actualiza = is_admin
      @user.save
      flash['success'] = "Modo Gestión Desactivado"
      redirect_to root_path
    end
  end

  def modograficoedu
    if User.find(is_admin).estapaedu.to_s == 'ACTIVA'
      @user = User.find(params[:id])
      @user.estapaedu = 'INACTIVA'
      @user.user_actualiza = is_admin
      @user.save(validate: false)
      redirect_to gestiondocumental_path
    else
      @user = User.find(params[:id])
      @user.estapaedu = 'ACTIVA'
      @user.user_actualiza = is_admin
      @user.save(validate: false)
      redirect_to root_path
    end
  end

  def act
    @users = User.where(["id in (select id from usersedupol)"])
    @users.each do |u|
      begin
        u.sign_in_count = 0
        u.password = u.identificacion + '123'
        u.password_confirmation = u.identificacion + '123'
        u.save(validate: false)
        rescue nil
      end
    end
    flash['success'] = "Usuario actualizado"
    redirect_to root_path
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
    if params[:user][:ingresoseguro].to_s == "NO"
      @user.encrypted_otp_secret = nil
      @user.encrypted_otp_secret_iv = nil
      @user.encrypted_otp_secret_salt = nil
      @user.consumed_timestep = nil
      @user.otp_required_for_login = nil
      @user.unconfirmed_otp_secret = nil
    end
    if @user.update(user_params)
      flash['success'] = "Usuario actualizado"
      redirect_to edit_user_path(id: @user.id, etapa: 'A')
    else
      @usersmodulo = Usersmodulo.new
      @userspermiso = Userspermiso.new
      @Usersportafolio = Usersportafolio.new
      @usersfecha = Usersfecha.new
      @usersimagen = Usersimagen.new
      render "user_form"
    end
  end

  def desbloquearusuario
    @user.user_actualiza = is_admin
    @user.failed_attempts = 0
    @user.unlock_token = nil
    @user.locked_at = nil
    @user.save(validate: false)
    flash['success'] = "Desbloqueado correctamente"
    redirect_to users_path
  end

  def edupol_desbloquearusuario
    @user = User.find(params[:id])
    @user.failed_attempts = 0
    @user.unlock_token = nil
    @user.locked_at = nil
    @user.user_actualiza = is_admin
    @user.save(validate: false)
    flash['success'] = "Desbloqueado correctamente"
    redirect_to root_path
  end

  def inactivaruser
    @user.activo = 'N'
    @user.user_actualiza = is_admin
    @user.save
    flash['success'] = "Usuario inactivado correctamente"
    redirect_to users_path
  end

  def activaruser
    @user.activo = 'S'
    @user.user_actualiza = is_admin
    @user.save
    flash['success'] = "Usuario activado correctamente"
    redirect_to users_path
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Usuario eliminado correctamente' }
      format.json { head :no_content }
    end
  end

  def etapa
    @user = User.find(params[:id])
    if params[:etapa].to_s != ""
      if params[:cohorte_id].to_s != ""
        ActiveRecord::Base.connection.execute("update users set etapa = '#{params[:etapa]}', cohorte_id = #{params[:cohorte_id].to_i} where id = #{params[:id]} and portafolio_id = #{is_portafolio}")
      else
        User.find(params[:id]).update_columns(etapa: params[:etapa].to_s)
        #ActiveRecord::Base.connection.execute("update users set etapa = '#{params[:etapa]}' where id = #{params[:id]} and portafolio_id = #{is_portafolio}")
      end
    end
    if params[:identificaciongd].to_s != ""
      redirect_to gestiondocumental_path(identificaciongd: params[:identificaciongd])
    else
      redirect_to gestiondocumental_path
    end
  end

  def etapar
    isadmin = is_admin
    isportafolio = is_portafolio
    isportafoliosucursal = is_portafoliossucursal
    if params[:etapa].to_s != ""
      @user = User.find(isadmin)
      @user.etapa = params[:etapa]
      @user.save(validate: false)

    end
    redirect_to reportes_path(etapa: params[:etapa], lasucursalid: params[:surcursal], vehiculonombre: params[:vehiculonombre], sucursalnombre: params[:sucursalnombre], mes: @dato1, anno: @dato2, vehiculoid: params[:vehiculoid], estado: params[:estado])
  end

  def etapabd
    etapa = params[:etapa].to_s
    if etapa.to_s != ""
      @user = User.find(is_admin)
      @user.etapa = etapa
      @user.save(validate: false)
    end
    if ["B1","B2","B3","B4","B5","B6","B7"].include?(etapa)
      redirect_to administracion_index_path
    elsif ["S1","S2","S3","S4"].include?(etapa)
      redirect_to root_path
    end
  end

  def cambioportafolio
    @user = User.find(params[:id])
    @user.portafolio_id = params[:p]
    @user.save(validate: false)
    respond_to do |format|
      if is_tipoconsulta == 'SUCURSAL'
        ProcesoJob.perform_now("prc_controlsucursalusers(#{is_admin},#{params[:p]})")
      end
      format.js
    end
  end

  def cambiotipoconsulta
    @user = User.find(params[:id])
    @user.tipoconsulta = params[:nueva]
    @user.tipoconsulta2 = params[:actual]
    @user.save(validate: false)
    redirect_to menus_path
  end

  def cambiosucursal
    @user = User.find(params[:id])
    @user.portafoliossucursal_id = params[:s]
    @user.save(validate: false)
    redirect_to menus_path
  end

  def resetpass
    @user = User.find(params[:id])
    @user.sign_in_count = 0
    @user.password = '123456789'
    @user.password_confirmation = '123456789'
    @user.save(validate: false)
    redirect_to users_path
  end

  def cambiarperfil
    @user = User.find(params[:id])
    @user.portafolioscargo_id = params[:portafolioscargo_id]
    @user.save(validate: false)
    ProcesoJob.perform_now("prc_userscargos(#{@user.id},#{params[:portafolioscargo_id]})")

    flash[:notice] = "Cargo actualizado con exito"
    redirect_to edit_user_path(:id=>@user.id)
  end

  def retirarcargos
    @user = User.find(params[:id])
    @user.portafolioscargo_id = nil
    Userspermiso.where(user_id: @user.id).delete_all
    Usersmodulo.where(user_id: @user.id).delete_all
    Usersreporte.where(user_id: @user.id).delete_all
    @user.save(validate: false)

    redirect_to edit_user_path(:id=>@user.id)
  end

  def permisosymodulos
    isportafolio = is_portafolio
    if [10025,10026,10027,10032].include?(isportafolio)
      isportafolio = "10025,10026,10027,10032"
    end
    @datos = Objeto.find_by_sql(["
                      select u.id,u.identificacion, u.nombre, u.username, u.email, u.tipoconsulta, u.observaciones, decode(u.activo,'S','SI','NO') estado,
                             'MODULO' proceso, m.descripcion modulo, null despermiso, null permiso, null elimina, null actualiza, null crea,
                             (select descripcion from portafolioscargos where id = u.portafolioscargo_id) cargo, 
                             (select descripcion from portafoliossucursales where id = u.portafoliossucursal_id) sucursal,
                             u.ingresoseguro, u.ambito, trunc(u.created_at) fecha_creacion
                      from   users u, usersmodulos um, modulos m
                      where  u.portafolio_id in (#{isportafolio}) and u.tipoconsulta != 'ESTUDIANTE' AND (u.GEINTAC = 'N' OR u.GEINTAC IS NULL)
                      and    u.id = um.user_id
                      and    um.modulo_id = m.id
                      union
                      select u.id,u.identificacion, u.nombre, u.username, u.email, u.tipoconsulta, u.observaciones, decode(u.activo,'S','SI','NO') estado,
                             'PERMISO' proceso,null, m.descripcion despermiso, m.descripcion_ampliada, decode(up.elimina,'S','SI','NO'), decode(up.actualiza,'S','SI','NO'), decode(up.crea,'S','SI','NO'),
                             (select descripcion from portafolioscargos where id = u.portafolioscargo_id) cargo, 
                             (select descripcion from portafoliossucursales where id = u.portafoliossucursal_id) sucursal,
                             u.ingresoseguro, u.ambito, trunc(u.created_at) fecha_creacion
                      from   users u, userspermisos up, objetos m
                      where  u.portafolio_id in (#{isportafolio}) and u.tipoconsulta != 'ESTUDIANTE' AND (u.GEINTAC = 'N' OR u.GEINTAC IS NULL)
                      and    u.id = up.user_id
                      and    up.objeto_id = m.id
                      and    u.username is not null"])
    @datos1 = Objeto.find_by_sql(["
                      select u.id,u.identificacion, u.nombre, u.username, u.email, to_char(u.current_sign_in_at,'DD-MM-YYYY HH24:MM:SS') current_sign_in_at, u.tipoconsulta, decode(u.activo,'S','SI','NO') estado
                      from   users u
                      where  u.portafolio_id in (#{isportafolio}) and u.tipoconsulta != 'ESTUDIANTE' AND (u.GEINTAC = 'N' OR u.GEINTAC IS NULL)
                      and    u.username is not null"])
    @datos2 = Objeto.find_by_sql(["
                      select u.id,u.identificacion, u.nombre, u.username, u.email, u.tipoconsulta, to_char(i.updated_at,'DD-MM-YYYY HH24:MM:SS') fchgeneracion,
                             decode(i.metodo,'download_datacollector','download_datacollector',(select max(nombre) from reportes where metodo = i.metodo)) nombre_informe
                      from   informes i, users u
                      where  i.portafolio_id in (#{isportafolio})
                      and    i.user_id = u.id
                      and    i.portafolio_id = u.portafolio_id
                      and    u.tipoconsulta != 'ESTUDIANTE' AND (u.GEINTAC = 'N' OR u.GEINTAC IS NULL)
                      and    u.username is not null
                      order by u.id, i.updated_at desc"])
    response_body_xlsx('Teseo_Usuarios') # Metodo que reemplaza el response do -  AFP 16/Marzo/2022
  end



  private

    def set_layout
      if ['index', 'new', 'create', 'update'].include?(action_name)
        'application_admin'
      elsif ['edit'].include?(action_name)
        'application_users'
      elsif ['inconsistencias'].include?(action_name)
        'excel'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if params[:etapa].to_s != ""
        @user = User.find(params[:id])
        @user.etapa = params[:etapa]
        @user.save(validate: false)
      end
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit!
    end
end
