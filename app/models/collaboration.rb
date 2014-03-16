class Collaboration < ActiveRecord::Base
  attr_accessible :user_id, :wiki_id
  belongs_to :user
  belongs_to :wiki 

end