class Personascorreo < ActiveRecord::Base
  belongs_to :persona
  belongs_to :user

  validates_presence_of :email
  validates_format_of :email, with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: '* Correo electrónico invalido'

  validates :email, uniqueness: { scope: :persona_id, message: "Correo ya Registrado en este estudiante" }

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
