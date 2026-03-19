class Personastelefono < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :telefono, :ciudad, :tipo
  validates :telefono, numericality: true
  validates :telefono, uniqueness: { scope: :persona_id,
                                     message: "Telefono ya Registrado en este estudiante" }

  validate :deliminar_telefono

  def deliminar_telefono
    if self.telefono.length > 10
      errors.add :telefono, "El número debe tener 10 dígitos"
    elsif self.telefono.length < 10
      errors.add :telefono, "El número debe tener 10 dígitos"
    end
  end

  def estadoa
    if self.estado == 'ACTIVO'
      return 'tabac'
    elsif self.estado == 'INACTIVO'
      return 'tabin'
    elsif self.estado == 'TERCERO'
      return 'tabter'
    end
  end
end
