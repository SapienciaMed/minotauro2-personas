class User < ApplicationRecord
  #audited except: [:etapap, :etapa, :unique_session_id, :unlock_token, :failed_attempts, :sesion, :portafolio_id, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :sign_in_count]

  #has_many :audits
  # Include default devise modules. Others available are:
  # :confirmable, :omniauthable
  devise :two_factor_authenticatable,
         :otp_secret_encryption_key => '2eb8ceeaf09042a4edda0c6dc8d8b564674f76bed3780bd220b4bd208e123823bc2b5254c40b0be9278029694b389e569ee17f1516a349a545663be7a6331e2b'

  devise :recoverable, :trackable, :validatable, :timeoutable, :lockable, :ssl_session_verifiable, :session_limitable

  has_many :login_activities, as: :user
  #  acts_as_authentic
  #  acts_as_authentic do |c|
  #    c.logged_in_timeout(1.minutes)
  #  end
  has_many :registros
  has_many :personas
  has_many :noticias
  has_many :personasoblpazysalvos
  has_many :centrosusers
  has_many :centrosresponsables
  has_many :portafoliosreportes
  has_many :personassoblgcas
  has_many :personasprogastos
  has_many :usersmodulos, dependent: :destroy
  has_many :userspermisos, dependent: :destroy
  has_many :personasprogadmisiones
  #has_many :usersproyectos, dependent: :destroy
  has_many :usersportafolios, dependent: :destroy
  has_many :usersfechas, dependent: :destroy
  has_many :usersimagenes, dependent: :destroy
  has_many :solicitudesobservaciones
  has_many :personasobservaciones
  has_many :personasalistamientos
  has_many :personasalisbienes
  has_many :personasacuerdos
  has_many :personasacuerdosdetalles
  has_many :personasacuerdoscreditos
  has_many :personasoblpagadurias
  has_many :personasoblinversionistas
  has_many :personasobligaciones
  has_many :personasimagenes
  has_many :covinocobligaciones
  has_many :agendas
  has_many :usersvehiculos
  belongs_to :portafolio
  belongs_to :portafoliossucursal
  belongs_to :portafolioscargo
  belongs_to :municipio
  belongs_to :centro
  belongs_to :portafoliosarea
  has_many :gruposusers
  has_many :personasvehiculos
  has_many :userssucursales
  has_many :universidadesusers
  has_many :cjetapas
  has_many :personasprogrecibos
  has_many :centrosgerentes
  has_many :usersreportes
  has_many :personasoblusers
  has_many :quejasasignaciones
  has_many :personasprojuzgados
  has_many :personasprousers
  has_many :personasproanalistas
  has_many :archivos
  has_many :personascasosensibles
  has_many :personasprocautelares
  has_many :usersanalistas, dependent: :destroy
  has_many :periodosconvocatorias
  has_many :personasoblpropietarios

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/assets/user_img.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  validates :nombre, :username, :email, presence: true

  validates :email, format: { with: /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :multiline => true, message: "* Correo electrónico invalido" }
  #validate :codeudor

  validates :email, uniqueness: { message: "El Correo ya esta registrado" }, on: :create

  validates :username, uniqueness: true, on: :create

  validates :identificacion, uniqueness: { message: "Ya hay una misma cedula" }, on: :create

  validates :password, presence: true, if: :valitatecountone

  before_save :antesdeguardar

  #clave segura validación
  #validates :password, password_strength: true

  scope :name_like, -> (nombre) { where("nombre like ?", nombre) }

  # Warden::Manager.before_logout do |user, auth, opts|
  #   user.sesion = false
  #   user.save
  # end

  def self.find_for_database_authentication(warden_conditions)

      conditions = warden_conditions.dup
      if conditions != nil
        conditions[:username].downcase! if conditions[:username]
        username = conditions[:username].downcase rescue nil
        where(["lower(username) = :value ", { :value => username }]).first
      end
  end

  def educacion
    if self.portafolio_id == 10100 or self.portafolio_id == 10101
      return true
    end
  end

  def activate_otp
    self.otp_required_for_login = true
    self.otp_secret = unconfirmed_otp_secret
    self.unconfirmed_otp_secret = nil
    save!
  end

  def deactivate_otp
    self.otp_required_for_login = false
    self.otp_secret = nil
    save!
  end

  def valitatecountone
    currentuser = self.geintac rescue nil
    self.sign_in_count == 1 and currentuser == "S"
  end


  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2 ** ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2 ** ROLES.index(r)).zero? }
  end

  def role?(role)
    roles.include? role.to_s
  end

  def self.search(search, isportafolio, page)
    paginate(page: page, per_page: 15).where("portafolio_id = #{isportafolio} and (geintac = 'N' or geintac is null) and upper(nombre||username) like upper('%%#{replacespace(search.to_s)}%%')").order('nombre')
  end

  def self.searchgeintac(search, page)
    paginate(page: page, per_page: 15).where("upper(nombre||username) like upper('%%#{replacespace(search.to_s)}%%')").order('nombre')
  end

  def antesdeguardar
    self.nombre = quita_acento(self.nombre)
  end

  def quita_acento(dato)
    valor = dato.gsub('Á', 'A') rescue nil
    valor = valor.gsub('É', 'E') rescue nil
    valor = valor.gsub('Í', 'I') rescue nil
    valor = valor.gsub('Ó', 'O') rescue nil
    valor = valor.gsub('Ú', 'U') rescue nil
    valor = valor.gsub('Ñ', 'N') rescue nil
    return valor.to_s
  end

  def self.replacespace(campo)
    b = campo.sub(" ", "%%")
    b = b.sub(" ", "%%")
    b = b.sub(" ", "%%")
    b = b.sub(" ", "%%")
    return b
  end

  def nombreysucursal
    if self.portafoliossucursal_id
      return self.nombre.to_s + " (" + Portafoliossucursal.find(self.portafoliossucursal_id).descripcion.to_s + ")" rescue nil
    else
      return self.nombre.to_s rescue nil
    end
  end

  def fchinforme
    return (self.fchinicio.strftime('%d-%m-%Y').to_s + ' y ' + self.fchfin.strftime('%d-%m-%Y').to_s) rescue nil
  end

  def imagen_encabezado
    if self.usersimagenes.exists?(["clase = 'ENCABEZADO'"]) == true
      dd = Usersimagen.where("user_id = #{self.id} and clase = 'ENCABEZADO'").first
      return "#{RAILS_ROOT}/public/system/usersimagenes/#{dd.id}/original/#{dd.usersimagen_file_name.to_s}"
    else
      return "#{RAILS_ROOT}/public/images/alert1.png"
    end
  end

  def imagen_pie
    if self.usersimagenes.exists?(["clase = 'PIEDEPAGINA'"]) == true
      dd = Usersimagen.where("user_id = #{self.id} and clase = 'PIEDEPAGINA'").first
      return "#{RAILS_ROOT}/public/system/usersimagenes/#{dd.id}/original/#{dd.usersimagen_file_name.to_s}"
    else
      return "#{RAILS_ROOT}/public/images/alert1.png"
    end
  end

  def d_etapa(dato)
    if self.etapa.to_s == dato.to_s
      return 'btn btn-danger'
    else
      return 'btn btn-default'
    end
  end

  def identificacion_nombre
    user.try(:nombre)
  end

  def identificacion_nombre=(nombre)
    self.user = User.find_by(nombre: nombre) if nombre.present?
  end

  def user_nombre
    user.try(:nombre)
  end

  def user_nombre=(nombre)
    self.user = User.find_by(nombre: nombre) if nombre.present?
  end

  def cambio_user2
    user.try(:nombre)
  end

  def cambio_user2=(nombre)
    self.user = User.find_by(nombre: nombre) if nombre.present?
  end

  def nombrecompleto
    self.nombre.to_s + ' - ' + self.username.to_s
  end

  def self.is_auth(objeto, is_admin)
    objetoid = Objeto.find_by_descripcion(objeto.to_s).id rescue 0
    if objetoid.to_s != ""
      return Userspermiso.exists?(["user_id = ? and objeto_id = ? and crea = 'S'", is_admin, objetoid])
    else
      return false
    end
  end

  def self.importar(path, portafolio_id, is_admin, nombrearchivo)
    extensionarchivo = path.slice(path.rindex("."), path.length).downcase
    cr = 0
    cadena = []
    spreadsheet = Roo::Spreadsheet.open(path, extension: extensionarchivo)
    (spreadsheet.first_row + 1..spreadsheet.last_row).each do |i|
      if is_auth('cargacazadores', is_admin)
        cadena.push " INTO migracionesusers (created_at,updated_at,nombre,identificacion,username,email,password,portafoliossucursal_id,
                                             cargo_id,telefonos,celular,tipoconsulta,direccion,ciudad,genero,fecha_nacimiento,fchinicio,
                                             centro_id,banco_id,tipo_cuenta,nro_cuenta,observaciones,extension,portafolio_id,userreg_id,namefile)
                      VALUES (sysdate,sysdate,'#{spreadsheet.row(i)[0].to_s}','#{spreadsheet.row(i)[1].to_i}','#{spreadsheet.row(i)[2].to_s}',
                              '#{spreadsheet.row(i)[3].to_s}','#{spreadsheet.row(i)[4].to_i}','#{spreadsheet.row(i)[5].to_i}','#{spreadsheet.row(i)[6].to_i}',
                              '#{spreadsheet.row(i)[7].to_i}','#{spreadsheet.row(i)[8].to_i}','COMERCIAL','#{spreadsheet.row(i)[9].to_s}','#{spreadsheet.row(i)[10].to_s}',
                              '#{spreadsheet.row(i)[11].to_s}','#{spreadsheet.row(i)[12].to_s}','#{spreadsheet.row(i)[13].to_s}.','#{spreadsheet.row(i)[14].to_s}',
                              '#{spreadsheet.row(i)[15].to_s}','#{spreadsheet.row(i)[16].to_s}','#{spreadsheet.row(i)[17].to_s}','#{spreadsheet.row(i)[18].to_s}','#{spreadsheet.row(i)[19].to_i}',#{portafolio_id},#{is_admin},'#{nombrearchivo}')"
      else
        cadena.push " INTO migracionesusers (created_at,updated_at,nombre,identificacion,username,email,tipoconsulta,password,portafoliossucursal_id,
                                             cargo_id,telefonos,celular,direccion,ciudad,genero,fecha_nacimiento,fchinicio,observaciones,
                                             extension,portafolio_id,userreg_id,namefile)
                      VALUES (sysdate,sysdate,'#{spreadsheet.row(i)[0].to_s}','#{spreadsheet.row(i)[1].to_s}','#{spreadsheet.row(i)[2].to_s}',
                              '#{spreadsheet.row(i)[3].to_s}','#{spreadsheet.row(i)[4].to_s}','#{spreadsheet.row(i)[5].to_s}','#{spreadsheet.row(i)[6].to_i}',
                              '#{spreadsheet.row(i)[7].to_i}','#{spreadsheet.row(i)[8].to_s}','#{spreadsheet.row(i)[9].to_s}','#{spreadsheet.row(i)[10].to_s}',
                              '#{spreadsheet.row(i)[11].to_s}','#{spreadsheet.row(i)[12].to_s}','#{spreadsheet.row(i)[13].to_s}','#{spreadsheet.row(i)[14].to_s}',
                              '#{spreadsheet.row(i)[15].to_s}','#{spreadsheet.row(i)[16].to_i}',#{portafolio_id},#{is_admin},'#{nombrearchivo}')"
      end
      cr = cr + 1
      if cr >= 100
        self.save_data(cadena)
        cadena.clear
        cr = 0
      end
    end
    if not cadena.empty?
      self.save_data(cadena)
      cadena.clear
    end
  end

  def self.importar2(path, portafolio_id, is_admin, nombrearchivo)
    extensionarchivo = path.slice(path.rindex("."), path.length).downcase
    cr = 0
    cadena = []
    spreadsheet = Roo::Spreadsheet.open(path, extension: extensionarchivo)
    (spreadsheet.first_row..spreadsheet.last_row).each do |i|
      if is_auth('cargacazadores', is_admin)
        cadena.push " INTO migracionesusers (created_at,updated_at,identificacion,portafolio_id,userreg_id,namefile)
                      VALUES (sysdate,sysdate,'#{spreadsheet.row(i)[0].to_i}',#{portafolio_id},#{is_admin},'#{nombrearchivo}')"
      else
        cadena.push " INTO migracionesusers (created_at,updated_at,identificacion,portafolio_id,userreg_id,namefile)
                      VALUES (sysdate,sysdate,'#{spreadsheet.row(i)[0].to_i}',#{portafolio_id},#{is_admin},'#{nombrearchivo}')"
      end
      cr = cr + 1
      if cr >= 100
        self.save_data(cadena)
        cadena.clear
        cr = 0
      end
    end
    if not cadena.empty?
      self.save_data(cadena)
      cadena.clear
    end
  end

  # MARK unico de cargue
  def self.save_data(registros)
    sql = "Insert all "
    sql << " #{registros.join(" ")} select * from dual"
    res = ActiveRecord::Base.connection.execute(sql)
  end

  def ciudadmunicipio
    return Municipio.find(self.municipio_id).descripcion rescue nil
  end

  def img_foto
    if avatar_file_name.to_s != ""
      ruta1 = "#{::Rails.root}/public/system/avatars/#{id}/original/"
      bashrc1 = File.join(ruta1, avatar_file_name)
      if File.exist?(bashrc1) # => true
        return "<img src='/system/avatars/#{id}/medium/#{avatar_file_name}' border='0' title='User Image', class='user-image'/>".html_safe
      end
    end
  end
end
