class Personasproceso < ActiveRecord::Base
  belongs_to :persona
  belongs_to :personasobligacion
  belongs_to :user
  belongs_to :municipio
  has_many :personasproimagenes

  def useraboagadonombre
    return User.find(self.user_abogado).nombre rescue nil
  end
end
