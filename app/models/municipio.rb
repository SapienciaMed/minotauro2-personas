class Municipio < ActiveRecord::Base
  has_many :personasalisbienes
  belongs_to :oficina

end
