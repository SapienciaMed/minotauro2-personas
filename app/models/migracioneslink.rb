class Migracioneslink < ApplicationRecord
  belongs_to :user

  def self.importar(path, is_admin, consecutivo, archivoid)

    spreadsheet = Roo::Spreadsheet.open(path)

    migrep = []
    c = 0

    archivo = Archivo.find(archivoid)
    moduloid = Modulo.where(imagenmin: archivo.proceso).first&.id
    moduloscampos = Moduloscampo.where(modulo_id: moduloid).order("orden asc")

    headers = moduloscampos.map(&:campo).join(',').split(',')

    spreadsheet.each_with_index do |row, idx|
      next if idx == 0

      user_data = Hash[[headers, row].transpose]
      user_data["user_id"]     = is_admin
      user_data["consecutivo"] = consecutivo
      user_data["archivo_id"]  = archivo.id

      migrep << Migracioneslink.new(user_data)
      c += 1

      if c >= 200
        Migracioneslink.import migrep, validate: false
        migrep = []
        c = 0
      end
    end

    # Importar los restantes
    Migracioneslink.import migrep, validate: false if migrep.any?

    ActiveRecord::Base.connection.execute("begin prc_migracioneslinks('#{consecutivo}'); end;")


    # Ejecutar procedimiento
    # prcExecute = "prc_migracioneslinks(#{consecutivo});"
    #
    # Ejecucion.create(
    #   user_id: is_admin,
    #   procedimiento: prcExecute,
    #   estado: 'PENDIENTE',
    #   descripcion: "SAPIENCIA. Modulo:Migracioneslink. Proceso:Cargue lote #{consecutivo}. Origen:APP.",
    #   tiempoejecucion: 1
    # )

  rescue => e
    Rails.logger.error "ERROR IMPORTANDO MIGRACIONESLINK: #{e.message}"
    raise e
  end
end
