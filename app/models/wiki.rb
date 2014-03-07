class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body
end
