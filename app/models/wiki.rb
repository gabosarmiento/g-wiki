class Wiki < ActiveRecord::Base
  attr_accessible :title, :description, :body
end
