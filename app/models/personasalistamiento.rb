class Personasalistamiento < ActiveRecord::Base
  has_many :personasalisbienes
  has_many :personasalislaborales
  has_many :personasalisasociados
  belongs_to :persona
  belongs_to :personasobligacion
  belongs_to :user
end
