class Collaboration < ActiveRecord::Base
  attr_accessible :user_id, :wiki_id
  belongs_to :user
  belongs_to :wiki 
  scope :collaboration_instance, lambda {|w_id, u_id| where("collaborations.wiki_id = ? && collaborations.user_id = ?", w_id, u_id)}
end