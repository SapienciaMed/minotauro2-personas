class Personasobligacion < ApplicationRecord
  belongs_to :persona
  has_many :planesobligaciones, :dependent => :destroy
  has_many :planesrecaudos, :dependent => :destroy
  has_many :solicitudes, :dependent => :destroy
  has_many :personasoblcambios, :dependent => :destroy
  belongs_to :historicostasa
  has_many :personasalistamientos
  has_many :planesfacturas

  validates_presence_of :fecha_matricula, :valor, :plazo, :nro_obligacion, :tasa_ipc, :tasa_puntos, :fondo, :pac, :tasa_mercado
  validates_numericality_of :valor, :plazo, :tasa_ipc, :tasa_puntos, :tasa_mercado
  validates_uniqueness_of :nro_obligacion

  def before_save
    self.tasa_final = self.tasa_ipc.to_f + self.tasa_puntos.to_f
    self.reestruc_vlr_otros_ori = self.reestruc_vlr_otros
  end

  def fchiniciocredito
    planesobligacion = Planesobligacion.where(["personasobligacion_id = #{self.id}"]).order("nro_cuota asc").first
    if planesobligacion
      return planesobligacion.fecha_vence rescue nil
    end
  end

  def identificacioncodeudor
    personascodeudor = Personascodeudor.where(["persona_id = #{self.persona_id}"]).order("id asc").first
    if personascodeudor
      return personascodeudor.identificacion rescue nil
    end
  end

  def nombrecodeudor
    personascodeudor = Personascodeudor.where(["persona_id = #{self.persona_id}"]).order("id asc").first
    if personascodeudor
      return personascodeudor.nombres rescue nil
    end
  end

  def dircodeudor
    personascodeudor = Personascodeudor.where(["persona_id = #{self.persona_id}"]).order("id asc").first
    if personascodeudor
      return personascodeudor.direccion_casa rescue nil
    end
  end

  def ciucodeudor
    personascodeudor = Personascodeudor.where(["persona_id = #{self.persona_id}"]).order("id asc").first
    if personascodeudor
      return personascodeudor.ciudad.to_s + " - " + personascodeudor.departamento.to_s rescue nil
    end
  end

  def telcodeudor
    personascodeudor = Personascodeudor.where(["persona_id = #{self.persona_id}"]).order("id asc").first
    if personascodeudor
      return personascodeudor.telefono_casa.to_s rescue nil
    end
  end

  def saldocapitalvencido
    self.planesobligaciones.where("fecha_vence < trunc(sysdate)").sum("amortiza").to_i
  end

  def saldointerescorriente
    self.planesobligaciones.where("fecha_vence < trunc(sysdate)").sum("corriente").to_i
  end

  def saldootros
    self.planesobligaciones.where("fecha_vence < trunc(sysdate)").sum("otros").to_i
  end

  def saldototalotros
    return self.planesobligaciones.sum("otros").to_i
  end

  def saldointeresmora
    a = 0
    #if self.obligacionvencida.to_s == 'SI'
    #  a = self.planesobligaciones.sum("mora").to_i + self.planesobligaciones.sum("morapendiente").to_i
    #elsif
    a = self.planesobligaciones.sum("mora").to_i + self.planesobligaciones.where("mora = 0").sum("morapendiente").to_i
    #end
    return a
  end

  def diasmora
    return self.planesobligaciones.sum("diasmora")
  end

  def diasvencoblig
    dias = 0
    planesobligacion = Planesobligacion.where(["cuota > 0 and personasobligacion_id = #{self.id}"]).order("fecha_vence").first
    objetos = Plan.find_by_sql(["select count(9) cant
                                 from   fechascontables
                                 where  fecha between '#{planesobligacion.fecha_vence.to_date + 1}' and trunc(sysdate)"])
    objetos.each do |objeto|
      dias = objeto.cant rescue nil
    end
    return dias.to_i
  end

  def calificacionmora
    diasvenc = self.diasvencoblig.to_i
    if diasvenc <= 30
      return '0 - 30'
    elsif diasvenc > 30 and diasvenc <= 60
      return '31 - 60'
    elsif diasvenc > 60 and diasvenc <= 90
      return '61 - 90'
    elsif diasvenc > 90 and diasvenc <= 120
      return '91 - 120'
    elsif diasvenc > 120 and diasvenc <= 150
      return '121 - 150'
    elsif diasvenc > 150 and diasvenc <= 180
      return '151 - 180'
    elsif diasvenc > 180 and diasvenc <= 360
      return '181 - 360'
    elsif diasvenc > 360
      return '> 360'
    end
  end

  def tipogestioncobro
    diasvenc = self.diasvencoblig.to_i
    if diasvenc > 30 and diasvenc <= 90
      return 'COBRANZA ADMINISTRATIVA'
    elsif diasvenc > 90 and diasvenc <= 180
      return 'COBRANZA PREJURIDICA'
    elsif diasvenc > 180 and diasvenc <= 360
      return 'ALISTAMIENTO JUDICIAL'
    elsif diasvenc > 360
      return 'COBRANZA JUDICIAL'
    else
      return 'CREDITOS AL DIA'
    end
  end

  def calificacion
    if self.diasvencoblig.to_i <= 60
      return 'A'
    elsif self.diasvencoblig.to_i > 60 and self.diasvencoblig.to_i <= 120
      return 'B'
    elsif self.diasvencoblig.to_i > 120 and self.diasvencoblig.to_i <= 180
      return 'C'
    elsif self.diasvencoblig.to_i > 180 and self.diasvencoblig.to_i <= 360
      return 'D'
    elsif self.diasvencoblig.to_i > 360
      return 'E'
    end
  end

  def totalvencido
    #mora = self.planesobligaciones.sum("mora",:conditions=>["fecha_vence <= trunc(sysdate)"]).to_i rescue nil
    mora = self.saldointeresmora.to_i rescue 0
    coramootro = self.planesobligaciones.where("fecha_vence < trunc(sysdate)").sum("nvl(corriente,0) + nvl(amortiza,0) + nvl(otros,0) ").to_i rescue nil
    #amortiza = self.planesobligaciones.sum("amortiza",:conditions=>["fecha_vence < trunc(sysdate)"]).to_i rescue nil
    #otros = self.planesobligaciones.sum("otros",:conditions=>["fecha_vence < trunc(sysdate)"]).to_i rescue nil
    return (mora.to_i + coramootro.to_i)
  end

  def totalcorriente
    corriente = self.planesobligaciones.sum("corriente").to_i rescue nil
    return corriente.to_i
  end

  def vlrcuota
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      self.planesobligaciones.where("to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')").sum("cuota").to_i rescue nil
    else
      return 0
    end
  end

  def vlrcuotacapital
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      self.planesobligaciones.where("to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')").sum("amortiza").to_i
    else
      return 0
    end
  end

  def vlrcuotacorriente
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      self.planesobligaciones.where("to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')").sum("corriente").to_i
    else
      return 0
    end
  end

  def vlrcuotaotros
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      self.planesobligaciones.where("to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')").sum("otros").to_i
    else
      return 0
    end
  end

  def capitalporpagar
    if self.planesobligaciones.exists?(["amortiza > 0"])
        self.planesobligaciones.where("to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')").sum("final").to_i
    else
      return 0
    end
  end

  def otrosporpagar
    if self.planesobligaciones.exists?(["amortiza > 0"])
        self.planesobligaciones.where("fecha_vence > fnc_last_day(trunc(sysdate))").sum("otros").to_i
    else
      return 0
    end
  end

  def saldototaldeuda
    saldos = self.totalvencido.to_i + self.vlrcuota.to_i + self.capitalporpagar.to_i + self.otrosporpagar.to_i
    if saldos.to_s == ""
      return 0
    else
      return saldos
    end
  end

  def obplazo
    return self.planesobligaciones.count
  end

  def obcuotaspagadas
    return self.planesobligaciones.where(["cuota = 0"]).count.to_i rescue 0
  end

  def obcuotasmora
    return self.planesobligaciones.where(["fecha_vence < fnc_last_day(trunc(sysdate)) and amortiza > 0"]).count.to_i rescue 0
  end

  def obcuotasporpagar
    return self.planesobligaciones.where(["cuota > 0 and fecha_vence >= fnc_last_day(trunc(sysdate))"]).count.to_i rescue 0
  end

  def obaltura
    return self.planesobligaciones.where(["to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')"]).first.nro_cuota.to_i - 1 rescue 0
  end

  def estadoobli
    #logger.error("valor obplazo... "+self.obplazo.to_s+"...")
    #logger.error("valor obaltura..."+self.obaltura.to_s+"...")
    if self.saldocapitalvencido.to_i == 0 and self.saldointerescorriente.to_i == 0 and self.saldointeresmora.to_i == 0 and self.saldootros.to_i == 0 and self.saldototaldeuda.to_i > 0
      return 'AL DIA'
    elsif (self.saldocapitalvencido.to_i > 0 or self.saldointerescorriente.to_i > 0 or self.saldointeresmora.to_i > 0 or self.saldootros.to_i > 0) and self.obplazo.to_i >= self.obaltura.to_i
      return 'EN MORA'
    elsif (self.saldocapitalvencido.to_i > 0 or self.saldointerescorriente.to_i > 0 or self.saldointeresmora.to_i > 0 or self.saldootros.to_i > 0) and self.obplazo < self.obaltura
      return 'VENCIDO'
    elsif self.saldototaldeuda.to_i == 0
      return 'CANCELADO'
    end
  end

  def vlrcuotasimulacion
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      return Planessimulacion.where(["personasobligacion_id = #{self.id} and to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')"]).sum("cuota").to_i
    else
      return 0
    end
  end

  def totalcorrientesimulacion
    return Planessimulacion.where(["personasobligacion_id = #{self.id}"]).sum("corriente").to_i
  end

  def totalotrossimulacion
    return Planessimulacion.where(["personasobligacion_id = #{self.id}"]).sum("otros").to_i
  end

  def obplazosimulacion
    return Planessimulacion.where(["personasobligacion_id = #{self.id}"]).count.to_i
  end

  def vlramortizacuota
    if Fechascontable.exists?(["fecha = trunc(sysdate)"])
      return self.planesobligaciones.where(["to_char(fecha_vence,'MM-YYYY') = to_char(sysdate,'MM-YYYY')"])[0].amortiza.to_i rescue 0
    else
      return 0
    end
  end

  def saldocapital
    @tot = self.saldocapitalvencido.to_i + self.capitalporpagar.to_i + self.vlramortizacuota.to_i
    return @tot
  end

  def saldototalsimulador
    return self.saldocapital.to_i + self.totalcorriente.to_i
  end

  def saldocapitalreestruc
    @saldo = self.saldocapitalvencido.to_i + self.capitalporpagar.to_i + self.vlramortizacuota.to_i
    return @saldo
  end

  def saldootrosrreestruc
    @saldo = self.saldototalotros.to_i + self.saldointerescorriente.to_i + self.saldointeresmora.to_i
    #logger.error("saldootrosrreestruc ... "+@saldo.to_s)
    return @saldo
  end

  def totalfinanciado
    return self.valor.to_i + self.reestruc_vlr_otros_ori.to_i
  end

  def totalporpagar
    return (self.capitalporpagar.to_i + self.otrosporpagar.to_i)
  end

  def fondodesc
    if self.fondo.to_s == "FONDO MEDELLIN EPM"
      return 'FONDO MEDELLIN EPM'
    elsif self.fondo.to_s == "ENLAZAMUNDOS"
      return 'PROGRAMA ENLAZAMUNDOS'
    else
      return 'PROGRAMA ESPECIAL'
    end
  end

  def obligacionvencida
    dftvencido = self.planesobligaciones.maximum("fecha_vence")
    if Time.now > dftvencido
      return 'SI'
    else
      return 'NO'
    end
  end

  def vlrultimorecaudo
    if self.fch_ult_pago.to_s != ""
      vlr = Planesrecaudo.where("personasobligacion_id = #{self.id} and fecha_recaudo = '#{self.fch_ult_pago.to_date}'
                                   and tipo_pago not in ('NOVACION','AJUSTE AUTOMATICO','AJUSTE CREDITO','AJUSTE')").sum('valor')
      return vlr.to_f
    end
  end

  def descripcion_input
    "#{nro_obligacion} - Pago Minimo: #{totalvencido.ceil + vlrcuota.ceil}" rescue nil
  end

end
