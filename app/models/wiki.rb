class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body, :public
  belongs_to :user
  before_create :set_visibility
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }

  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  # def should_generate_new_friendly_id?
  #   new_record?
  # end

  private
  def set_visibility
   self.public = 'true'
  end

end
