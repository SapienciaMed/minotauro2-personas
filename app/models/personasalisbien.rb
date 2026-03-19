class Personasalisbien < ActiveRecord::Base
  belongs_to :personasalistamiento
  belongs_to :user
  belongs_to :oficina
  belongs_to :municipio
  has_many :personasalisbimagenes
  
end
