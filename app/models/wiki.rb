class Wiki < ActiveRecord::Base
  has_paper_trail
  acts_as_taggable
  include PublicActivity::Common
  
  attr_accessible :wikiname, :description, :body, :user_id, :public, :tag_list
  belongs_to :user
  has_many :collaborations, dependent: :destroy 
  has_many :users, :through => :collaborations
  scope :visible_to, lambda { |user| user ? scoped : where(public: true) } 
  scope :hidden_to, lambda  { |user| where(public: false) } 
  
  #FriendlyID for nice looking urls
  extend FriendlyId
  friendly_id :wikiname, use: [:slugged, :history]

  #Tire for Elastic Search
  include Tire::Model::Search
  include Tire::Model::Callbacks 
  
  #Checks if an user is a Collaborator for a wiki
  def is_collaborator?(user)
    self.collaborations.each do |c|
     if c.user_id == user.id
       return true
     elsif c.user_id != user.id
       return false 
     end
    end
  end  

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
