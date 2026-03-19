class Desembolsosrelacion < ActiveRecord::Base
  belongs_to :desembolsospersona
  belongs_to :persona
  belongs_to :personasobligacion
  has_many :desembolsoscreditos
end
