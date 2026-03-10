class Comite < ActiveRecord::Base
  has_many :comitesobservaciones
  has_many :comitesusers
  has_many :comitesimagenes
  has_many :comitessolicitudes
  belongs_to :comitestipo

  validates_presence_of :fecha, :user_responsable, :temas

  def self.search (creainicial,creafinal,temas,vencinicial,vencfinal,comiteid)
      cadena = ""
      if creainicial.to_s != "" and creafinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and fecha between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
        else
          cadena = cadena + ' fecha between ' + "'#{creainicial}'" + ' and ' + "'#{creafinal}'"
        end
      end
      if temas.to_s != ""
        if cadena != ""
          cadena = cadena + ' and temas like '+ "'%%#{temas.to_s}%%'"
        else
          cadena = cadena + ' temas like '+ "'%%#{temas.to_s}%%'"
        end
      end
      if vencinicial.to_s != "" or vencfinal.to_s != ""
        if cadena != ""
          cadena = cadena + ' and id  in (select comite_id
                                          from   comitesactividades
                                          where  fecha_limite  between ' + "'#{vencinicial}'" + ' and ' + "'#{vencfinal}'" +')'
        else
          cadena = cadena + ' id  in (select comite_id
                                          from   comitesactividades
                                          where  fecha_limite  between ' + "'#{vencinicial}'" + ' and ' + "'#{vencfinal}'" +')'
        end
      end
      if comiteid.to_s != ""
        if cadena != ""
          cadena = cadena + ' and consecutivo = '+ "'#{comiteid}'"
        else
          cadena = cadena + ' consecutivo = '+ "'#{comiteid}'"
        end
      end
      if cadena != ""
        find(:all, :conditions => [cadena], :order => "created_at")
      else
        find(:all, :conditions => ['trunc(created_at) = trunc(sysdate)'], :order => "created_at")
      end
  end

  def self.notifica(comite)
    @user = User.find(comite.user_responsable)
    correopri = @user.email.to_s
    nombrepri = @user.nombre.to_s
    if Usersnotificacion.exists?(["user_id = #{@user.id}"]) == true
      @correos = ""
      @cant = 0
      @usersnotificaciones = Usersnotificacion.find(:all, :conditions=>["user_id = #{@user.id}"])
      @usersnotificaciones.each do |usersnotificacion|
        @cant = @cant + 1
        if @cant == @usersnotificaciones.count
          @correos = @correos.to_s + usersnotificacion.usernuevocorreo.to_s
        else
          @correos = @correos.to_s + usersnotificacion.usernuevocorreo.to_s + ','
        end
      end
      @correos = @correos + ','+ correopri.to_s
    else
      @correos = correopri
    end
    @comites = Comite.find(:all, :conditions=>["user_responsable = #{comite.user_responsable} and id in (select comite_id from comitesactividades where estado not in ('SI REALIZADA','DESACTIVADA') and envioinformacion is not null)"])
    #logger.error("Enviado a "+@correos.to_s)
    Notifier.deliver_comitenotifica_message(@correos, nombrepri, @comites)
  end

  def before_save
    self.temas = quita_acento(self.temas)
  end

  def quita_acento(dato)
    valor = dato.gsub('Á','A') rescue nil
    valor = valor.gsub('É','E') rescue nil
    valor = valor.gsub('Í','I') rescue nil
    valor = valor.gsub('Ó','O') rescue nil
    valor = valor.gsub('Ú','U') rescue nil
    valor = valor.gsub('Ñ','N') rescue nil
    return valor.to_s
  end

end
