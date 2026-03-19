class Planesrecaudo < ActiveRecord::Base
  belongs_to :personasobligacion
  belongs_to :user
  has_many :planesrecaudosdetalles, :dependent =>:destroy
  has_many :planesrespaldos

  validates_presence_of :fecha_recaudo, :valor, :tipo_pago, :tipo_afecta
  
end
