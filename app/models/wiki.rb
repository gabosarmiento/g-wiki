class Wiki < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  include PublicActivity::Common
  #scope :collaboration_instance, lambda {|w_id, u_id| where("collaborations.wiki_id = ? && collaborations.user_id = ?", w_id, u_id)}
  # tracked owner: ->(controller, model) { controller && controller.current_user }
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
