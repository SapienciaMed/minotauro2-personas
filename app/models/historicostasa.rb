class Historicostasa < ActiveRecord::Base
  has_many :personasobligaciones
  has_many :solicitudes
end
