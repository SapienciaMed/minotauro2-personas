class Personasalisbimagen < ActiveRecord::Base
  belongs_to :personasalisbien
  belongs_to :user

  has_attached_file :peralisbien, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :peralisbien
  validates_attachment_presence :peralisbien, :message => 'Debe seleccionar un archivo valido!!'

end
