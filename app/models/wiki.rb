class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body, :public
  belongs_to :user
  has_many :collaborations
  has_many :users, :through => :collaborations
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) } 

  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  validates :wikiname, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true  
  private

end
