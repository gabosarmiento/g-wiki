class Wiki < ActiveRecord::Base
  attr_accessible :wikiname, :description, :body, :public
  belongs_to :user

  scope :visible_to, lambda { |user| user.role ? scoped : where(public: true) }

  private

end
