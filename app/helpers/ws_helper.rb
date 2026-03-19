module WsHelper
  def vlr_issocialreason(tDocumento)
    if tDocumento == 3
      # Si es Empresa(NIT)
      return true
    else
      # Si es Cedula
      return false
    end
  end

  def vlr_idtypecode(tDocumento)
    if tDocumento == 1
      # Si es Cedula
      return 13
    elsif tDocumento == 3
      # Si es Empresa(NIT)
      return 31
    elsif tDocumento == 8
      # Si es Pasaporte
      return 41
    elsif tDocumento == 5
      # Si es Tarjeta de Identidad
      return 12
    end
  end

  def vlr_fullname(tDocumento,vlNombre)
    if tDocumento == 3
      # Si es Empresa
      return vlNombre
    else
      return nil
    end
  end

  def vlr_firstname(tDocumento, vlPrimerNombre)
    if tDocumento == 1 or tDocumento == 5
      # Si es Persona Nombre
      return vlPrimerNombre
    else
      return nil
    end
  end

  def vlr_lastname(tDocumento, vlPrimerApellido)
    if tDocumento == 1 or tDocumento == 5
      # Si es Persona Apellido
      return vlPrimerApellido
    else
      return nil
    end
  end
end
