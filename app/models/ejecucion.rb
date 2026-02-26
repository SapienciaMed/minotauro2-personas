class Ejecucion < ApplicationRecord
  belongs_to :user
   require 'csv'
  require 'find'
  require 'rubygems'
  require 'zip'
  require 'axlsx'


  def self.ejecrake
    validacion = Ejecucion.where(["estado = 'PENDIENTE' and Substr(Descripcion, 1, Length('Programacion RakeEmailG.')) = 'Programacion RakeEmailG.' and instr(Descripcion,'Controlador:') > 0"]).exists?
    if Ejecucion.where(["estado = 'PENDIENTE' and Substr(Descripcion, 1, Length('Programacion RakeEmailG.')) = 'Programacion RakeEmailG.' and instr(Descripcion,'Controlador:') > 0"]).exists?
      idprocesamiento = Objeto.find_by_sql("Select To_Char(SysDate, 'YYYYMMDDHH24MISS') || Round(DBMS_Random.Value(1,1000), 0) procesamiento_id From dual")[0].procesamiento_id rescue 0
      Ejecucion.where(["estado = 'PENDIENTE' and Substr(Descripcion, 1, Length('Programacion RakeEmailG.')) = 'Programacion RakeEmailG.' and instr(Descripcion,'Controlador:') > 0"]).update_all(estado: 'EN CURSO', procesamiento_id: idprocesamiento, inicioejecucion: Time.now)
      Ejecucion.select("id
                       , Substr(Descripcion,
                          Instr(Descripcion, 'Controlador:') + Length('Controlador:'),
                          Instr(Substr(Descripcion, Instr(Descripcion, 'Controlador:') + Length('Controlador:'), Length(Descripcion) - Instr(Descripcion, 'Controlador:') - Length('Controlador:') + 1), '. ') - 1) as Controlador
                       , Substr(Descripcion,
                          Instr(Descripcion, 'Metodo:') + Length('Metodo:'),
                          Instr(Substr(Descripcion, Instr(Descripcion, 'Metodo:') + Length('Metodo:'), Length(Descripcion) - Instr(Descripcion, 'Metodo:') - Length('Metodo:') + 1), '. ') - 1) as Metodo
                       ").where(["estado = 'EN CURSO' and procesamiento_id = #{idprocesamiento} and Substr(Descripcion, 1, Length('Programacion RakeEmailG.')) = 'Programacion RakeEmailG.' and instr(Descripcion,'Controlador:') > 0"]).each do |e|
        Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'EN EJECUCION', inicioejecucion: Time.now)
        begin
          execute = e.controlador.to_s + '.' + e.metodo.to_s
          eval(execute)
          Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'EXITOSO', finejecucion: Time.now)
        rescue Exception => ex
          Ejecucion.where(["id  = #{e.id}"]).update_all(estado: 'ERROR', observacion: ex.message[0..349].to_s, finejecucion: Time.now)
        end
      end
    end
  end
end
