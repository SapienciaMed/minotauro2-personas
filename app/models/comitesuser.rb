class Comitesuser < ActiveRecord::Base
  belongs_to :comite
  belongs_to :user

  validates_presence_of :user_id
end
