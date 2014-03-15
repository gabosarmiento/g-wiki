class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body, :public
  belongs_to :user
  has_and_belongs_to_many :collaborators, :class_name => 'User', :join_table => 'wiki_collaborators'
  before_create :set_visibility
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) }

  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  # def should_generate_new_friendly_id?
  #   new_record?
  # end
  validates :wikiname, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true  
  private
  def set_visibility
   self.public = 'true'
  end

end
