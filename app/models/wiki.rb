class Wiki < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  attr_accessible :wikiname, :description, :body, :user_id, :public, :tag_list
  belongs_to :user
  has_many :collaborations, dependent: :destroy 
  has_many :users, :through => :collaborations
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) } 

  #FriendlyID for nice looking urls
  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  #Tire for Elastic Search
  include Tire::Model::Search
  include Tire::Model::Callbacks 

  # def self.search(params)
  # tire.search(load: true) do
  #   query { string params[:query]} if params[:query].present?
  #   end
  # end

  validates :wikiname, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true  
  

end
