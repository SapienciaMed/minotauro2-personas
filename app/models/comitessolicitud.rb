class Comitessolicitud < ActiveRecord::Base
  belongs_to :comite
  belongs_to :solicitud
end
