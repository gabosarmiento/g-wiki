class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body
  belongs_to :user
end
