class Collaboration < ActiveRecord::Base
  attr_accessible :user_id, :wiki_id
  belongs_to :user
  belongs_to :wiki 
  scope :something, lambda  { |wiki| where(public: false) } 

  def is_mine?(user)
    if self.user_id == user.id
      return true
    else
      return false
    end
  end 

end