class Personasalislimagen < ActiveRecord::Base
  belongs_to :personasalislaboral
  belongs_to :user

  has_attached_file :peralislaboral, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :peralislaboral
  validates_attachment_presence :peralislaboral, :message => 'Debe seleccionar un archivo valido!!'

end
