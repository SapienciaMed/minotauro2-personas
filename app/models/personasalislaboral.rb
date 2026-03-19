class Personasalislaboral < ActiveRecord::Base
  belongs_to :personasalistamiento
  belongs_to :user
  belongs_to :municipio
  has_many :personasalislimagenes
end
