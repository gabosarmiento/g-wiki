class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body, :user_id, :public
  belongs_to :user
  has_many :collaborations
  has_many :users, :through => :collaborations
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) } 

  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  #Tire for Elastic Search
  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
  tire.search(load: true) do
    query { string params[:query]} if params[:query].present?
    end
  end

  validates :wikiname, length: { minimum: 5 }, presence: true
  validates :description, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :user, presence: true  
  

end
