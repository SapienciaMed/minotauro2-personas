class Personasproimagen < ActiveRecord::Base
  belongs_to :personasproceso

  has_attached_file :proceso, :styles => { :medium => "300x300!", :thumb => "100x100!" }, :whiny => false
  validates_presence_of :descripcion
  validates_attachment_presence :proceso, :message => 'Debe seleccionar un archivo valido!!'
end
