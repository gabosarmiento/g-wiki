class Sale < ActiveRecord::Base
  belongs_to :user
  attr_accessible :email, :guid

  before_create :populate_guid
  
  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end

end
