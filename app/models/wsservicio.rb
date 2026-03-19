class Wsservicio < ApplicationRecord
  belongs_to :personasobligacion
  belongs_to :persona
  belongs_to :tiposservicio
end
