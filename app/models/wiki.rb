class Wiki < ActiveRecord::Base
  attr_accessible :body, :description, :public, :title
end
